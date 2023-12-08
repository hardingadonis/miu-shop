// add-product.js

// Function to open the Add Product Modal
function openAddModal() {
    $('#addProductModal').modal('show');
}

// Function to handle form submission
$(document).ready(function () {
    $('#addProductForm').submit(function (e) {
        e.preventDefault();

        // Serialize form data
        var formData = $(this).serialize();

        // AJAX request to send form data to the server for processing
        $.ajax({
            type: 'POST',
            url: 'productmanagement', // Update with the actual URL
            data: formData,
            success: function (response) {
                // Handle success response
                console.log(response);

                // Close the modal after successful submission
                $('#addProductModal').modal('hide');

                // Optionally, you can update the product list or perform other actions
            },
            error: function (error) {
                // Handle error response
                console.error(error.responseText);
            }
        });
    });
});
