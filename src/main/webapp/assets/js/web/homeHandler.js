const prices = document.getElementsByClassName("price");

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

function updateProductHeight() {
    let products = document.querySelectorAll('.row .product-detail');
    let maxHeight = 0;

    products.forEach(function (product) {
        product.style.height = 'auto';
        let productHeight = product.offsetHeight;
        maxHeight = Math.max(maxHeight, productHeight);
    });

    products.forEach(function (product) {
        product.style.height = maxHeight + 'px';
    });
}

window.addEventListener('load', updateProductHeight);
window.addEventListener('resize', updateProductHeight);