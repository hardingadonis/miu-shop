var selectedRowIndex;

function openEditModal() {
    $('#editProductModal').modal('show');
    // Lưu index của hàng được chọn
    selectedRowIndex = $(this).closest('tr').index();
}

// Function to populate fields in the edit modal with existing data
function populateEditModalFields(row) {
    var productName = row.cells[1].textContent.trim();
    var category = row.cells[2].textContent.trim();
    var price = row.cells[3].textContent.trim();
    var amount = row.cells[4].textContent.trim();

    document.getElementById('editProductName').value = productName;
    document.getElementById('editCategory').value = category;
    document.getElementById('editPrice').value = price;
    document.getElementById('editAmount').value = amount;
}

function saveChanges() {
    // Lấy giá trị từ modal
    var editedProductName = document.getElementById('editProductName').value;
    var editedCategory = document.getElementById('editCategory').value;
    var editedPrice = document.getElementById('editPrice').value;
    var editedAmount = document.getElementById('editAmount').value;

    // Kiểm tra giá trị có đọc được không
    console.log("Edited Product Name:", editedProductName);
    console.log("Edited Category:", editedCategory);
    console.log("Edited Price:", editedPrice);
    console.log("Edited Amount:", editedAmount);

    // Cập nhật hàng trong bảng
    var rowToUpdate = $('#datatablesSimple tbody tr').eq(selectedRowIndex);
    console.log("Row to update:", rowToUpdate);

    // Kiểm tra có lấy được hàng cần update không
    if (rowToUpdate.length > 0) {
        rowToUpdate.find('td:eq(1)').text(editedProductName);
        rowToUpdate.find('td:eq(2)').text(editedCategory);
        rowToUpdate.find('td:eq(3)').text(editedPrice);
        rowToUpdate.find('td:eq(4)').text(editedAmount);

        // Đóng modal
        closeEditModal();
    } else {
        console.error("Row to update not found!");
    }
}

// Function to close the edit modal
function closeEditModal() {
    $('#editProductModal').modal('hide');
}

// Event delegation to handle dynamically added elements
$(document).on('click', '.btn-info.btn-tiny', function () {
    openEditModal.call(this); // Phải gọi hàm openEditModal với this là element được click
    populateEditModalFields($(this).closest('tr')[0]);
});

// Event delegation for dynamically added elements inside the modal
$(document).on('click', '.btn-save-changes', function () {
    saveChanges();
});

$(document).on('click', '.btn-cancel-changes', function () {
    closeEditModal();
});

