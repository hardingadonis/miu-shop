const prices = document.getElementsByClassName("price");

for (let price of prices) {
    const amount = parseFloat(price.textContent);

    price.textContent = formatCurrencyVND(amount);
}

function formatCurrencyVND(amount) {
    const formatter = new Intl.NumberFormat('vi-VN', {
        style: 'currency',
        currency: 'VND'
    });

    return formatter.format(amount);
}

function handleDeletePurchaseHistory(id) {
    Swal.fire({
        title: "Hủy đơn hàng?",
        text: "Bạn thực sự muốn hủy đơn hàng này?",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "Xác nhận!",
        cancelButtonText: "Không!"
    }).then((result) => {
        if (result.isConfirmed) {
            const url = "purchase-history?id=" + id;

            $.ajax({
                url: url,
                type: "DELETE",
                dataType: "json",
                success: function (data) {
                    if (data.status === "success") {
                        Swal.fire({
                            title: "Thành công!",
                            text: "Bạn đã hủy đơn hàng thành công!",
                            icon: "success"
                        }).then((result) => {
                            if (result.isConfirmed) {
                                window.location.reload();
                            }
                        });
                    } else {
                        Swal.fire({
                            title: "Oops...",
                            text: "Đã có lỗi xảy ra!",
                            icon: "error"
                        });
                    }
                },
                error: function () {
                    Swal.fire({
                        title: "Oops...",
                        text: "Đã có lỗi xảy ra khi gửi yêu cầu!",
                        icon: "error"
                    });

                    console.log("error");
                }
            });
        }
    });
}