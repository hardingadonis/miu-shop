var orderId;

function openEditStatusModal() {
    $('#editOrderModal').modal('show');
}

// Function to populate fields in the edit modal with existing data
function populateEditModalFields(row) {
    var orderStatus = row.cells[4].textContent.trim();

    document.getElementById('editStatus').value = orderStatus;
}

function openEditOrderStatusModal(id) {
    orderId = id;
    
    openEditStatusModal();
}

function saveChangesEditOrder() {
    let editedStatus = document.getElementById('editStatus').value;

    // Get the order ID from the row or another source

    const url = contextPath + '/admin/order?id=' + orderId + '&status=' + editedStatus;

    $.ajax({
        url: url,
        type: "POST",
        dataType: "json",
        success: function (data) {
            if (data.status === "success") {
                Swal.fire({
                    title: "Success!",
                    text: "Order Status information updated successfully!",
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


// Function to close the edit modal
function closeEditModal() {
    $('#editOrderModal').modal('hide');
}

//// Event delegation to handle dynamically added elements
//$(document).on('click', '.btn-tiny', function () {
//    openEditModal.call(this); // Phải gọi hàm openEditModal với this là element được click
//    populateEditModalFields($(this).closest('tr')[0]);
//});

