const prices = document.getElementsByClassName("price");
const maxAmount = parseInt(document.getElementById("max-amount").textContent);
const productID = parseInt(document.getElementById("product-id").textContent);
const quantity = document.getElementById("quantity");

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

quantity.addEventListener('input', function () {
    removeNonNumericCharacters(quantity);

    checkQuantity();
});

function removeNonNumericCharacters(input) {
    input.value = input.value.replace(/[^0-9]/g, '');
}

function increaseQuantity() {
    let currentQuantity = parseInt(quantity.value);

    quantity.value = currentQuantity + 1;

    checkQuantity();
}

function decreaseQuantity() {
    let currentQuantity = parseInt(quantity.value);

    quantity.value = currentQuantity - 1;

    checkQuantity();
}

function addToCart() {
    let currentQuantity = parseInt(quantity.value);

    let cartCookie = getCartCookie();

    if (cartCookie.hasOwnProperty(productID)) {
        cartCookie[productID] += currentQuantity;
    } else {
        cartCookie[productID] = currentQuantity;
    }

    let expirationDate = new Date();
    expirationDate.setFullYear(expirationDate.getFullYear() + 1);

    let cartJson = JSON.stringify(cartCookie);

    document.cookie = 'cart=' + cartJson + '; expires=' + expirationDate.toUTCString();

    setTotalProductQuantityToCart();

    alert('Added ' + currentQuantity + ' items to the cart!');
}

function checkQuantity() {
    let currentQuantity = parseInt(quantity.value);

    if (currentQuantity < 1 || isNaN(currentQuantity)) {
        quantity.value = 1;
    }

    if (currentQuantity > maxAmount) {
        quantity.value = maxAmount;
    }
}

jQuery(document).ready(function () {
    jQuery(".ecommerce-gallery").lightSlider({
        gallery: true,
        item: 1,
        loop: true,
        thumbItem: 4,
        thumbMargin: 10
    });
});

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

window.addEventListener('load', function() {
    setTotalProductQuantityToCart();
    updateProductHeight();
});
window.addEventListener('resize', updateProductHeight);