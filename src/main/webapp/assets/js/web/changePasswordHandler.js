const form = document.getElementById('change-password-form');
const currentPasswordInput = document.getElementById('current-password');
const newPasswordInput = document.getElementById('new-password');
const confirmNewPasswordInput = document.getElementById('confirm-new-password');
const errorMessage = document.getElementById('error-message');

form.addEventListener('submit', function (event) {
    event.preventDefault();

    if (!isStrongPassword(newPasswordInput.value)) {
        errorMessage.textContent = 'Mật khẩu mới phải có ít nhất 6 ký tự, trong đó có ít nhất 1 chữ số, 1 chữ cái viết hoa, 1 ký tự đặc biệt!';
        newPasswordInput.focus();
        return;
    }

    if (!isPasswordMatch(newPasswordInput.value, confirmNewPasswordInput.value)) {
        errorMessage.textContent = 'Mật khẩu mới không khớp!';
        confirmNewPasswordInput.focus();
        return;
    }

    this.submit();
});

currentPasswordInput.addEventListener('input', function () {
    removeSpaces(currentPasswordInput);
});

newPasswordInput.addEventListener('input', function () {
    removeSpaces(newPasswordInput);
});

confirmNewPasswordInput.addEventListener('input', function () {
    removeSpaces(confirmNewPasswordInput);
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