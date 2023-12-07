var selectedRowIndex;

function openEditModal() {
    $('#editCategoryModal').modal('show');
    // Lưu index của hàng được chọn
    selectedRowIndex = $(this).closest('tr').index();
}

// Function to populate fields in the edit modal with existing data
function populateEditModalFields(row) {
    var categoryName = row.cells[1].textContent.trim();

    document.getElementById('editCategoryName').value = categoryName;
}

function saveChanges() {
    // Lấy giá trị từ modal
    var editedCategoryName = document.getElementById('editCategoryName').value;

    // Kiểm tra giá trị có đọc được không
    console.log("Edited Category Name:", editedCategoryName);

    // Cập nhật hàng trong bảng
    var rowToUpdate = $('#datatablesSimple tbody tr').eq(selectedRowIndex);
    console.log("Row to update:", rowToUpdate);

    // Kiểm tra có lấy được hàng cần update không
    if (rowToUpdate.length > 0) {
        rowToUpdate.find('td:eq(1)').text(editedCategoryName);

        // Đóng modal
        closeEditModal();
    } else {
        console.error("Row to update not found!");
    }
}

// Function to close the edit modal
function closeEditModal() {
    $('#editCategoryModal').modal('hide');
}

// Event delegation to handle dynamically added elements
$(document).on('click', '.btn-tiny', function () {
    openEditModal.call(this); // Phải gọi hàm openEditModal với this là element được click
    populateEditModalFields($(this).closest('tr')[0]);
});

// Event delegation for dynamically added elements inside the modal
$(document).on('click', '#saveChangesBtn', function () {
    saveChanges();
});

$(document).on('click', '#cancelChangesBtn', function () {
    closeEditModal();
});