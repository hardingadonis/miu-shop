let categoryId;

function openEditModal() {
    $('#editCategoryModal').modal('show');
}

function openEditModel(id) {
    categoryId = id;
    
    openEditModal();
}

function saveChangesEditCategory() {
    let editedCategoryName = document.getElementById('editCategoryName').value;

    // Get the category ID from the row or another source

    const url = contextPath + '/admin/category?id=' + categoryId + '&name=' + editedCategoryName;

    $.ajax({
        url: url,
        type: "POST",
        dataType: "json",
        success: function (data) {
            if (data.status === "success") {
                Swal.fire({
                    title: "Success!",
                    text: "Category information updated successfully!",
                    icon: "success"
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location.reload();
                    }
                });
            } else {
                Swal.fire({
                    title: "Oops...",
                    text: "Something went wrong!",
                    icon: "error"
                });
            }
        },
    });
}

function closeEditCategoryModal() {
    $('#editCategoryModal').modal('hide');
}

$(document).on('click', '#cancelEditBtn', function () {
    closeEditModal();
});

$(document).on('click', '#saveCategoryChangesBtn', function () {
    saveCategoryChanges();
});