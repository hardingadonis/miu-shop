const prices = document.getElementsByClassName("price");
const tooltips = document.querySelectorAll(".product");

for (let price of prices) {
    const amount = parseFloat(price.textContent);

    price.textContent = formatCurrencyVND(amount);
}

function formatCurrencyVND(amount) {
    const formatter = new Intl.NumberFormat('vi-VN', {
        style: 'currency',
        currency: 'VND'
    });

    return formatter.format(amount);
}

tooltips.forEach(t => {
    new bootstrap.Tooltip(t);
});