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

function decreaseQuantity(productID) {
    const quantity = document.getElementById("product-amount-" + productID);
    const quantityValue = parseInt(quantity.innerText);

    if (quantityValue > 1) {
        quantity.innerText = quantityValue - 1;

        updateTotalPriceForEachProduct(productID, quantityValue - 1);

        updateToCookie(productID, quantityValue - 1);

        updateTotalPrice();
    }
    else {
        removeProduct(productID);
    }
}

function increaseQuantity(productID) {
    const quantity = document.getElementById("product-amount-" + productID);
    const quantityMax = parseInt(quantity.getAttribute("max"));
    const quantityValue = parseInt(quantity.innerText);

    if (quantityValue >= quantityMax) {
        Toastify({
            text: 'Số lượng sản phẩm đã đạt giới hạn tối đa!',
            position: 'right',
            gravity: 'bottom',
            duration: 3000,
            backgroundColor: '#000000'
        }).showToast();
        return;
    }

    quantity.innerText = quantityValue + 1;

    updateTotalPriceForEachProduct(productID, quantityValue + 1);

    updateToCookie(productID, quantityValue + 1);

    updateTotalPrice();
}

function updateTotalPriceForEachProduct(productID, quantity) {
    const price = document.getElementById("product-price-" + productID);
    const priceValue = parseInt(price.innerText.replace(/[^0-9]/g, ''));

    const totalPrice = document.getElementById("product-total-price-" + productID);

    totalPrice.innerText = formatCurrencyVND(priceValue * quantity);
}

function updateTotalPrice() {
    let total = 0;

    let cartCookie = getCartCookie();

    for (let productID in cartCookie) {
        const price = document.getElementById("product-price-" + productID);
        const priceValue = parseInt(price.innerText.replace(/[^0-9]/g, ''));

        total += priceValue * cartCookie[productID];
    }

    document.getElementById("total-price").innerText = formatCurrencyVND(total);
}

function removeProduct(productID) {
    const product = document.getElementById("product-" + productID);

    product.remove();

    updateToCookie(productID, 0);

    updateTotalPrice();
    
    setTotalProductQuantityToCart();
}

function updateToCookie(productID, quantity) {
    let cartCookie = getCartCookie();

    if (quantity === 0) {
        delete cartCookie[productID];
    }
    else if (cartCookie.hasOwnProperty(productID)) {
        cartCookie[productID] = quantity;
    }

    if (Object.keys(cartCookie).length === 0) {
        document.cookie = 'cart=; expires=Thu, 01 Jan 1970 00:00:00 UTC;';
    } else {
        let expirationDate = new Date();
        expirationDate.setFullYear(expirationDate.getFullYear() + 1);

        let cartJson = JSON.stringify(cartCookie);

        document.cookie = 'cart=' + encodeURIComponent(cartJson) + '; expires=' + expirationDate.toUTCString();
    }
}