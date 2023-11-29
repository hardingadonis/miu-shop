function getCartCookie() {
    let cookies = document.cookie.split(';');
    for (let i = 0; i < cookies.length; i++) {
        let cookie = cookies[i].trim();
        if (cookie.startsWith('cart=')) {
            return JSON.parse(decodeURIComponent(cookie.substring(5)));
        }
    }

    return {};
}

function getTotalProductQuantity() {
    let cartCookie = getCartCookie();
    const totalQuantity = Object.keys(cartCookie).length;

    return totalQuantity;
}

function setTotalProductQuantityToCart() {
    const cart = document.getElementById('total-products-in-cart');
    cart.innerText = getTotalProductQuantity();
}

window.addEventListener('load', function() {
    setTotalProductQuantityToCart();
});