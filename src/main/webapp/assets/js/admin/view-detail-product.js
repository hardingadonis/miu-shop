// view-detail-product.js

$(document).ready(function () {
    // Handle click on "View Detail" button
    $('.btn-view-detail').on('click', function (e) {
        e.preventDefault();

        // Get the data from the row
        var id = $(this).closest('tr').find('td:eq(0)').text();
        var name = $(this).closest('tr').find('td:eq(1)').text();
        var category = $(this).closest('tr').find('td:eq(2)').text();
        var price = $(this).closest('tr').find('td:eq(3)').text();
        var amount = $(this).closest('tr').find('td:eq(4)').text();
        var thumbnail = $(this).closest('tr').find('td:eq(5) img').attr('src');

        var brand = $('.brand').val();
        var origin = $('.origin').val();
        var expiryDate = $('.expiryDate').val();
        var weight = $('.weight').val();
        var preservation = $('.preservation').val();
        
        var images = $('.images').val();
        
        var createAt = $('.createAt').val();
        var updateAt = $('.updateAt').val();
        var deleteAt = $('.deleteAt').val();


        // Create HTML for the detail table
        var detailTable = `
            <table class="table">
                <tbody>
                    <tr>
                        <th>ID</th>
                        <td>${id}</td>
                    </tr>
                    <tr>
                        <th>Brand</th>
                        <td>${brand}</td>
                    </tr>
                    <tr>
                        <th>Name</th>
                        <td>${name}</td>
                    </tr>
                    <tr>
                        <th>Category</th>
                        <td>${category}</td>
                    </tr>
                    <tr>
                        <th>Origin</th>
                        <td>${origin}</td>
                    </tr>
                    <tr>
                        <th>Expiry Date</th>
                        <td>${expiryDate}</td>
                    </tr>
                    <tr>
                        <th>Weight</th>
                        <td>${weight}</td>
                    </tr>
                    <tr>
                        <th>Preservation</th>
                        <td>${preservation}</td>
                    </tr>
                    <tr>
                        <th>Price</th>
                        <td>${price}</td>
                    </tr>
                    <tr>
                        <th>Amount</th>
                        <td>${amount}</td>
                    </tr>
                    <tr>
                        <th>Thumbnail</th>
                        <td><img src="${thumbnail}" style="width: 80px; height: 80px" alt="${name}"></td>
                    </tr>
                    <tr>
                        <th>Images</th>
                        <td><img src="${images}" style="width: 80px; height: 80px" alt="${name}"></td>
                    </tr>
                    <tr>
                        <th>Create At</th>
                        <td>${createAt}</td>
                    </tr>
                    <tr>
                        <th>Update At</th>
                        <td>${updateAt}</td>
                    </tr>
                    <tr>
                        <th>Delete At</th>
                        <td>${deleteAt}</td>
                    </tr>
        
                </tbody>
            </table>
        `;

        // Display the detail table in a modal
        $('#detailModal .modal-body').html(detailTable);
        $('#detailModal').modal('show');
    });
});

