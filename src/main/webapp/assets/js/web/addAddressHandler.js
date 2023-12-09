const form = document.getElementById('add-address-form');
const specificInput = document.getElementById('specific');
const receiverInput = document.getElementById('receiver');
const phoneInput = document.getElementById('phone');
const errorMessage = document.getElementById('error-message');

form.addEventListener('submit', function (event) {
    event.preventDefault();

    const specific = specificInput.value;
    if (specific.trim() === '') {
        errorMessage.textContent = 'Địa chỉ không được để trống!';
        specificInput.focus();
        return;
    }

    const receiver = receiverInput.value;
    if (receiver.trim() === '') {
        errorMessage.textContent = 'Người nhận hàng không được để trống!';
        receiverInput.focus();
        return;
    }

    const phone = phoneInput.value;
    if (phone.trim() === '') {
        errorMessage.textContent = 'Số điện thoại không được để trống!';
        phoneInput.focus();
        return;
    }

    if (!isValidPhoneNumber(phone)) {
        errorMessage.textContent = 'Số điện thoại không hợp lệ!';
        phoneInput.focus();
        return;
    }

    this.submit();
});

phoneInput.addEventListener('input', function () {
    removeSpaces(phoneInput);
    removeNonNumericCharacters(phoneInput);

    if (phoneInput.value.length > 10) {
        phoneInput.value = phoneInput.value.slice(0, 10);
    }
});

function isValidPhoneNumber(phoneNumber) {
    const cleanedPhoneNumber = phoneNumber.replace(/\s/g, '');

    const phoneNumberRegex = /^\d{10}$/;

    return phoneNumberRegex.test(cleanedPhoneNumber);
}

function removeSpaces(input) {
    input.value = input.value.replace(/\s/g, '');
}

function removeNonNumericCharacters(input) {
    input.value = input.value.replace(/[^0-9]/g, '');
}

let citis = document.getElementById("city");
let districts = document.getElementById("district");
let wards = document.getElementById("ward");
let Parameter = {
    url: "https://raw.githubusercontent.com/hardingadonis/miu-shop/main/database/location_data.json",
    method: "GET",
    responseType: "json",
};
let promise = axios(Parameter);

promise.then(function (result) {
    renderCity(result.data);
});

function renderCity(data) {
    for (const x of data) {
        var opt = document.createElement('option');
        opt.value = x.Name;
        opt.text = x.Name;
        opt.setAttribute('data-id', x.Id);
        citis.options.add(opt);
    }
    citis.onchange = function () {
        district.length = 1;
        ward.length = 1;
        if (this.options[this.selectedIndex].dataset.id != "") {
            const result = data.filter(n => n.Id === this.options[this.selectedIndex].dataset.id);

            for (const k of result[0].Districts) {
                var opt = document.createElement('option');
                opt.value = k.Name;
                opt.text = k.Name;
                opt.setAttribute('data-id', k.Id);
                district.options.add(opt);
            }
        }
    };
    district.onchange = function () {
        ward.length = 1;
        const dataCity = data.filter((n) => n.Id === citis.options[citis.selectedIndex].dataset.id);
        if (this.options[this.selectedIndex].dataset.id != "") {
            const dataWards = dataCity[0].Districts.filter(n => n.Id === this.options[this.selectedIndex].dataset.id)[0].Wards;

            for (const w of dataWards) {
                var opt = document.createElement('option');
                opt.value = w.Name;
                opt.text = w.Name;
                opt.setAttribute('data-id', w.Id);
                wards.options.add(opt);
            }
        }
    };
}