const forgotForm = document.getElementById('forgot-password-form');
const emailInput = document.getElementById('email');
const errorMessage = document.getElementById('error-message');

if (forgotForm) {

    forgotForm.addEventListener('submit', function (event) {
        event.preventDefault();

        const emailValue = emailInput.value;

        if (!isValidEmail(emailValue)) {
            errorMessage.textContent = 'Email không hợp lệ!';
            emailInput.focus();
            return;
        }

        this.submit();
    });

    emailInput.addEventListener('input', function () {
        removeSpaces(emailInput);
    });
}

function removeSpaces(input) {
    input.value = input.value.replace(/\s/g, '');
}

function isValidEmail(email) {
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
}