function openAddModal() {
    $('#addCategoryModal').modal('show');
}

function populateAddModalFields(row) {
    var categoryName = row.cells[1].textContent.trim();

    categoryName = document.getElementById('addCategoryName').value;
}

function saveChanges() {
    let addedCategoryName = document.getElementById('addCategoryName').value;

    const url = contextPath + '/admin/category?name=' + addedCategoryName;

    $.ajax({
        url: url,
        type: "POST",
        dataType: "json",
        success: function (data) {
            if (data.status === "success") {
                Swal.fire({
                    title: "Success!",
                    text: "You added a new category successfully!",
                    icon: "success"
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location.reload();
                    }
                });
            } else {
                Swal.fire({
                    title: "Oops...",
                    text: "Something was wrong!",
                    icon: "error"
                });
            }
        },
    });
}

function closeAddModal() {
    $('#addCategoryModal').modal('hide');
}

function openAddModal() {
    $('#addCategoryName').val('');

    $('#addCategoryModal').modal('show');
}

function closeAddModal() {
    $('#addCategoryModal').modal('hide');
}

$(document).on('click', '#addCategoryBtn', function () {
    openAddModal();
});

$(document).on('click', '#cancelAddBtn', function () {
    closeAddModal();
});

$(document).on('click', '#saveChangesBtn', function () {
    saveChanges();
});

$(document).on('click', '#cancelChangesBtn', function () {
    closeAddModal();
});