<?php
// ============================================================
// API: Gửi đánh giá sản phẩm — api/submit_review.php
// Nhận {product_id, rating (1-5), comment}. Mỗi khách chỉ được đánh giá 1 lần / sản phẩm.
// ============================================================
ob_start();
session_start();

require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../includes/shop_helpers.php';

mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
header('Content-Type: application/json; charset=utf-8');

function reply($success, $message, $http_code = 200) {
    ob_clean();
    http_response_code($http_code);
    echo json_encode(['success' => $success, 'message' => $message]);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    reply(false, 'Method not allowed', 405);
}
if (empty($_SESSION['user_id'])) {
    reply(false, 'Vui lòng đăng nhập để đánh giá sản phẩm.', 401);
}

$body = json_decode(file_get_contents('php://input'), true);
if (!is_array($body)) {
    reply(false, 'Dữ liệu không hợp lệ', 400);
}

$user_id    = (int)$_SESSION['user_id'];
$product_id = (int)($body['product_id'] ?? 0);
$rating     = (int)($body['rating'] ?? 0);
$comment    = mb_substr(trim(strip_tags((string)($body['comment'] ?? ''))), 0, 1000, 'UTF-8');

if ($product_id <= 0)             reply(false, 'Sản phẩm không hợp lệ', 422);
if ($rating < 1 || $rating > 5)   reply(false, 'Vui lòng chọn số sao từ 1 đến 5.', 422);

try {
    // Sản phẩm phải tồn tại
    $p = $conn->prepare("SELECT id FROM products WHERE id = ? LIMIT 1");
    $p->bind_param('i', $product_id);
    $p->execute();
    if ($p->get_result()->num_rows === 0) {
        reply(false, 'Không tìm thấy sản phẩm.', 404);
    }

    // Kiểm tra nếu đã đánh giá rồi thì chặn luôn, không cho sửa
    $e = $conn->prepare("SELECT id FROM reviews WHERE user_id = ? AND product_id = ? LIMIT 1");
    $e->bind_param('ii', $user_id, $product_id);
    $e->execute();
    if ($e->get_result()->num_rows > 0) {
        reply(false, 'Bạn đã đánh giá sản phẩm này rồi và không thể chỉnh sửa.', 409);
    }

    // Chưa có đánh giá thì phải đủ điều kiện (đã nhận hàng)
    if (!user_can_review($conn, $user_id, $product_id)) {
        reply(false, 'Chỉ khách đã nhận sản phẩm này mới có thể đánh giá.', 403);
    }

    $stmt = $conn->prepare("
        INSERT INTO reviews (product_id, user_id, rating, comment, status)
        VALUES (?, ?, ?, ?, 'visible')
    ");
    $stmt->bind_param('iiis', $product_id, $user_id, $rating, $comment);
    $stmt->execute();

    reply(true, 'Cảm ơn bạn đã đánh giá sản phẩm!');
} catch (mysqli_sql_exception $ex) {
    if ((int)$ex->getCode() === 1062) {
        reply(false, 'Bạn đã đánh giá sản phẩm này rồi và không thể chỉnh sửa.', 409);
    }
    error_log('submit_review sql error: ' . $ex->getMessage());
    reply(false, 'Có lỗi xảy ra, vui lòng thử lại.', 500);
} catch (Throwable $ex) {
    error_log('submit_review error: ' . $ex->getMessage());
    reply(false, 'Có lỗi xảy ra, vui lòng thử lại.', 500);
}