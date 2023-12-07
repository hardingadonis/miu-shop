var selectedProductRowIndex;

function openDeleteModal() {
    $('#deleteProductModal').modal('show');
    // Lưu index của hàng được chọn
    selectedProductRowIndex = $(this).closest('tr').index();
}

function closeDeleteModal() {
    $('#deleteProductModal').modal('hide');
}

function deleteProduct() {
    console.log("Deleting product...");

    // Thực hiện các bước cần thiết để xóa user
    // ...

    // Xóa hàng trong bảng
    var rowToDelete = $('#datatablesSimple tbody tr').eq(selectedProductRowIndex);
    rowToDelete.remove();

    // Đóng modal
    closeDeleteModal();
}

// Event delegation to handle dynamically added elements
$(document).on('click', '.btn-danger', function() {
    openDeleteModal();
});