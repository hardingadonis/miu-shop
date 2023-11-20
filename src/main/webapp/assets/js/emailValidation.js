var form = document.getElementById('login-form') || document.getElementById('register-form');

if (form !== null) {

    form.addEventListener('submit', function (event) {
        event.preventDefault();

        var emailInput = document.getElementById('email');
        var emailValue = emailInput.value;

        var errorMessage = document.getElementById('error-message') || document.createElement('div');
        errorMessage.id = 'error-message';

        if (isValidEmail(emailValue)) {
            this.submit();

            if (errorMessage.parentNode) {
                errorMessage.parentNode.removeChild(errorMessage);
            }
        } else {
            errorMessage.textContent = 'Email không hợp lệ!';
            errorMessage.style.color = 'red';

            var inputField = document.getElementById('submit-form');
            inputField.appendChild(errorMessage);

            emailInput.focus();
        }
    });
}

function isValidEmail(email) {
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
}