var selectedRowIndex;

function openEditModal() {
    $('#editOrderModal').modal('show');
    // Lưu index của hàng được chọn
    selectedRowIndex = $(this).closest('tr').index();
}

// Function to populate fields in the edit modal with existing data
function populateEditModalFields(row) {
    var orderStatus = row.cells[4].textContent.trim();

    document.getElementById('editStatus').value = orderStatus;
}

function saveChangesEdit() {
    // Lấy giá trị từ modal
    var editedStatus = document.getElementById('editStatus').value;

    // Kiểm tra giá trị có đọc được không
    console.log("Edited Order Status:", editedStatus);

    // Cập nhật hàng trong bảng
    var rowToUpdate = $('#datatablesSimple tbody tr').eq(selectedRowIndex);
    console.log("Row to update:", rowToUpdate);

    // Kiểm tra có lấy được hàng cần update không
    if (rowToUpdate.length > 0) {
        rowToUpdate.find('td:eq(4)').text(editedStatus);

        // Đóng modal
        closeEditModal();
    } else {
        console.error("Row to update not found!");
    }
}

// Function to close the edit modal
function closeEditModal() {
    $('#editOrderModal').modal('hide');
}

// Event delegation to handle dynamically added elements
$(document).on('click', '.btn-tiny', function () {
    openEditModal.call(this); // Phải gọi hàm openEditModal với this là element được click
    populateEditModalFields($(this).closest('tr')[0]);
});

// Event delegation for dynamically added elements inside the modal
$(document).on('click', '#saveChangesBtn', function () {
    saveChangesEdit();
});

$(document).on('click', '#cancelChangesBtn', function () {
    closeEditModal();
});