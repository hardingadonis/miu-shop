    var selectedUserRowIndex;

    function openDeleteModal() {
        $('#deleteUserModal').modal('show');
        // Lưu index của hàng được chọn
        selectedUserRowIndex = $(this).closest('tr').index();
    }

    function closeDeleteModal() {
        $('#deleteUserModal').modal('hide');
    }

    function deleteUser() {
        console.log("Deleting user...");

        // Thực hiện các bước cần thiết để xóa user
        // ...

        // Xóa hàng trong bảng
        var rowToDelete = $('#datatablesSimple tbody tr').eq(selectedUserRowIndex);
        rowToDelete.remove();

        // Đóng modal
        closeDeleteModal();
    }

    // Event delegation to handle dynamically added elements
    $(document).on('click', '.btn-danger', function() {
        openDeleteModal();
    });