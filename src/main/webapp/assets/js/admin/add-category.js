var currentId = 6;

function openEditModal() {
    $('#editCategoryModal').modal('show');
    selectedRowIndex = $(this).closest('tr').index();
}

function populateEditModalFields(row) {
    var categoryName = row.cells[1].textContent.trim();
    
    document.getElementById('editCategoryName').value = categoryName;
}

function saveChanges() {
    var editedCategoryName = document.getElementById('editCategoryName').value;

    console.log("Edited User Name:", editedCategoryName);

    var rowToUpdate = $('#datatablesSimple tbody tr').eq(selectedRowIndex);

    if (rowToUpdate.length > 0) {
        rowToUpdate.find('td:eq(1)').text(editedCategoryName);

        closeEditModal();
    } else {
        console.error("Row to update not found!");
    }
}

function closeAddModal() {
    $('#editCategoryModal').modal('hide');
}

function openAddModal() {
    $('#addCategoryName').val('');

    $('#addCategoryModal').modal('show');
}

function closeAddModal() {
    $('#addCategoryModal').modal('hide');
}

function addNewCategory() {
    var categoryName = $('#addCategoryName').val();
    var currentDateTime = getCurrentDateTime(); // Lấy giá trị ngày hiện tại

    console.log("Category Name:", categoryName);
    console.log("Current Date/Time:", currentDateTime);

    currentId++;

    // Tạo dòng mới bằng cách sử dụng template string
    var newRow = `
        <tr>
            <td>${currentId}</td>
            <td>${categoryName}</td>
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


$(document).on('click', '.btn-tiny', function() {
    openEditModal();
    populateEditModalFields($(this).closest('tr')[0]);
});

$(document).on('click', '#addCategoryBtn', function() {
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