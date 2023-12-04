const form = document.getElementById('profile-form');
const fullNameInput = document.getElementById('full-name');
const birthYearInput = document.getElementById('birth-year');

form.addEventListener('submit', function (event) {
    event.preventDefault();

    removeExtraSpaces(fullNameInput);

    this.submit();
});

birthYearInput.addEventListener('input', function () {
    removeNonNumericCharacters(birthYearInput);

    if (birthYearInput.value.length > 4) {
        birthYearInput.value = birthYearInput.value.slice(0, 4);
    }
});

function removeExtraSpaces(input) {
    input.value = input.value.replace(/\s+/g, ' ').trim();
}

function removeNonNumericCharacters(input) {
    input.value = input.value.replace(/[^0-9]/g, '');
}