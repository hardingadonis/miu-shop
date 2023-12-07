function deleteUser(id) {
    Swal.fire({
        title: "Delete user?",
        text: "You really want to delete this user?",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "Delete!",
        cancelButtonText: "No!"
    }).then((result) => {
        if (result.isConfirmed) {
            const url = contextPath + "admin/user?id=" + id;

            $.ajax({
                url: url,
                type: "DELETE",
                dataType: "json",
                success: function (data) {
                    if (data.status === "success") {
                        Swal.fire({
                            title: "Success!",
                            text: "You delete user success!",
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
                error: function () {
                    Swal.fire({
                        title: "Oops...",
                        text: "Something was wrong when send the request!",
                        icon: "error"
                    });
                }
            });
        }
    });
}