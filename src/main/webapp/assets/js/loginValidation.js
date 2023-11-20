const form = document.getElementById('login-form');
const emailInput = document.getElementById('email');
const passwordInput = document.getElementById('password');
const errorMessage = document.getElementById('error-message');

form.addEventListener('submit', function (event) {
    event.preventDefault();

    const emailValue = emailInput.value;

    if (isValidEmail(emailValue)) {
        this.submit();
    } else {
        errorMessage.textContent = 'Email không hợp lệ!';
        emailInput.focus();
    }
});

emailInput.addEventListener('input', function () {
    removeSpaces(emailInput);
});

passwordInput.addEventListener('input', function () {
    removeSpaces(passwordInput);
});

function isValidEmail(email) {
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
}

function removeSpaces(input) {
    input.value = input.value.replace(/\s/g, '');
}