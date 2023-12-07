
var currentId = 1;

function openEditModal() {
    $('#editProductModal').modal('show');
    selectedRowIndex = $(this).closest('tr').index();
}

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
    var editedProductName = document.getElementById('editProductName').value;
    var editedCategory = document.getElementById('editCategory').value;
    var editedPrice = document.getElementById('editPrice').value;
    var editedAmount = document.getElementById('editAmount').value;

    console.log("Edited Product Name:", editedProductName); // ....

    var rowToUpdate = $('#datatablesSimple tbody tr').eq(selectedRowIndex);

    if (rowToUpdate.length > 0) {
        rowToUpdate.find('td:eq(1)').text(editedProductName);
        rowToUpdate.find('td:eq(2)').text(editedCategory);
        rowToUpdate.find('td:eq(3)').text(editedPrice);
        rowToUpdate.find('td:eq(4)').text(editedAmount);

        closeAddModal();
    } else {
        console.error("Row to update not found!");
    }
}

function closeAddModal() {
    $('#editProductModal').modal('hide');
}

function openAddModal() {
    $('#addProductName').val('');

    $('#addProductModal').modal('show');
}

function closeAddModal() {
    $('#addProductModal').modal('hide');
}

function addNewProduct() {
    var productName = $('#addProductName').val();
    var category = $('#addCategory').val();
    var price = $('#addPrice').val();
    var amount = $('#addAmount').val();
    var currentDateTime = getCurrentDateTime(); // Lấy giá trị ngày hiện tại

    console.log("Product Name:", ProductName);
    console.log("Current Date/Time:", currentDateTime); // ....
    // Còn cột thumnail là upload ảnh lên, GPT nhé

    currentId++;

    // Tạo dòng mới bằng cách sử dụng template string
    var newRow = `
        <tr>
            <td>${currentId}</td>
            <td>${productName}</td>
            <td>${category}</td>
            <td>${price}</td>
            <td>${amount}</td>
            <td>NULL</td>           
            <td>${currentDateTime}</td>
            <td>NULL</td>
            <td>NULL</td>
            <td>
                <a href="#" class="btn btn-info btn-tiny" title="Edit"><i class="fa fa-pencil"></i></a>
                <button class="btn btn-danger btn-tiny" title="Delete" disabled><i class="fa fa-trash"></i></button>
            </td>
        </tr>`;

    // Thêm dòng vào bảng
    $('#datatablesSimple tbody').append(newRow);

    closeAddModal();
}


$(document).on('click', '.btn-info.btn-tiny', function() {
    openEditModal();
    populateEditModalFields($(this).closest('tr')[0]);
});

$(document).on('click', '#addProductBtn', function() {
    openAddModal();
});

$(document).on('click', '#cancelAddBtn', function() {
    closeAddModal();
});

$(document).on('click', '#saveChangesBtn', function() {
    saveChanges();
});

$(document).on('click', '#cancelChangesBtn', function() {
    closeEditModal();
});



function getCurrentDateTime() {
    var currentDate = new Date();

    var year = currentDate.getFullYear();
    var month = ('0' + (currentDate.getMonth() + 1)).slice(-2); // Thêm '0' và cắt chỉ lấy hai số cuối cùng
    var day = ('0' + currentDate.getDate()).slice(-2);
    var hours = ('0' + currentDate.getHours()).slice(-2);
    var minutes = ('0' + currentDate.getMinutes()).slice(-2);
    var seconds = ('0' + currentDate.getSeconds()).slice(-2);

    // Định dạng theo yêu cầu "YYYY-MM-DD HH:mm:ss"
    var formattedDateTime = year + '-' + month + '-' + day + ' ' + hours + ':' + minutes + ':' + seconds;

    return formattedDateTime;
}

// Sử dụng hàm để cập nhật giá trị ngày hiện tại
var currentDateTime = getCurrentDateTime();
console.log(currentDateTime);
