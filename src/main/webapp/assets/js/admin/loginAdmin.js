const usernameInput = document.getElementById('username');
const passwordInput = document.getElementById('password');

usernameInput.addEventListener('input', function () {
    removeSpaces(usernameInput);
});

passwordInput.addEventListener('input', function () {
    removeSpaces(passwordInput);
});

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