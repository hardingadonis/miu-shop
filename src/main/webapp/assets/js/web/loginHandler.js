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

document.querySelectorAll('.show-password-toggle').forEach(function (eyeIcon) {
    eyeIcon.addEventListener('click', function () {
        const inputId = this.getAttribute('data-toggle');
        const passwordInput = document.getElementById(inputId);

        passwordInput.type = passwordInput.type === 'password' ? 'text' : 'password';

        // Toggle between the eye and eye-slash icons
        this.classList.toggle('fa-eye', !(passwordInput.type === 'password'));
        this.classList.toggle('fa-eye-slash', (passwordInput.type === 'password'));
    });
});