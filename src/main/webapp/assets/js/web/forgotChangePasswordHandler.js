const changePasswordForm = document.getElementById('change-password-form');
const emailInput = document.getElementById('email');
const passwordInput = document.getElementById('password');
const confirmPasswordInput = document.getElementById('comfirm-password');
const errorMessage = document.getElementById('error-message');

if (changePasswordForm) {
    changePasswordForm.addEventListener('submit', function (event) {
        event.preventDefault();

        if (!isStrongPassword(passwordInput.value)) {
            errorMessage.textContent = 'Mật khẩu mới phải có ít nhất 6 ký tự, trong đó có ít nhất 1 chữ số, 1 chữ cái viết hoa, 1 ký tự đặc biệt!';
            passwordInput.focus();
            return;
        }

        if (!isPasswordMatch(passwordInput.value, confirmPasswordInput.value)) {
            errorMessage.textContent = 'Mật khẩu mới không khớp!';
            confirmNewPasswordInput.focus();
            return;
        }

        const url = 'forgot-change-password?email=' + emailInput.textContent + '&password=' + passwordInput.value;

        $.ajax({
            url: url,
            type: "POST",
            dataType: "json",
            success: function (data) {
                if (data && data.status === "success") {
                    Swal.fire({
                        title: "Thành công!",
                        text: "Bạn đã đổi mật khẩu thành công!",
                        icon: "success"
                    }).then((result) => {
                        if (result.isConfirmed) {
                            window.location.href = 'login';
                        }
                    });
                } else {
                    Swal.fire({
                        title: "Lỗi!",
                        text: "Không thể đổi mật khẩu. Vui lòng thử lại!",
                        icon: "error"
                    });
                }
            },
            error: function (xhr, status, error) {
                Swal.fire({
                    title: "Lỗi!",
                    text: "Đã xảy ra lỗi trong quá trình xử lý yêu cầu. Vui lòng thử lại!",
                    icon: "error"
                });
            }
        });

    });

    passwordInput.addEventListener('input', function () {
        removeSpaces(passwordInput);
    });

    confirmPasswordInput.addEventListener('input', function () {
        removeSpaces(confirmPasswordInput);
    });

    function removeSpaces(input) {
        input.value = input.value.replace(/\s/g, '');
    }

    function isPasswordMatch(password, confirmPassword) {
        return password === confirmPassword;
    }

    function isStrongPassword(password) {
        if (password.length < 6) {
            return false;
        }

        if (!/\d/.test(password)) {
            return false;
        }

        if (!/[!@#$%^&*()_+{}\[\]:;<>,.?~\\/-]/.test(password)) {
            return false;
        }

        if (!/[A-Z]/.test(password)) {
            return false;
        }

        return true;
    }

    $(".toggle-password").click(function () {
        $(this).toggleClass("fa-eye fa-eye-slash");
        input = $(this).parent().find("input");

        if (input.attr("type") == "password") {
            input.attr("type", "text");
        } else {
            input.attr("type", "password");
        }
    });
}
