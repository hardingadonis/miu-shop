function getCartCookie() {
    let cookies = document.cookie.split(';');
    for (let i = 0; i < cookies.length; i++) {
        let cookie = cookies[i].trim();
        if (cookie.startsWith('cart=')) {
            return JSON.parse(cookie.substring(5));
        }
    }

    return {};
}

function getTotalProductQuantity() {
    let cartCookie = getCartCookie();
    let totalQuantity = 0;

    for (let productID in cartCookie) {
        if (cartCookie.hasOwnProperty(productID)) {
            totalQuantity += cartCookie[productID];
        }
    }

    return totalQuantity;
}

function setTotalProductQuantityToCart() {
    const cart = document.getElementById('total-products-in-cart');
    cart.innerText = getTotalProductQuantity();
}

window.addEventListener('load', function() {
    setTotalProductQuantityToCart();
});