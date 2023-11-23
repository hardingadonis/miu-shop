
function validateForm() {

    // Kiểm tra mật khẩu khớp nhau
    var password = document.getElementById("pass").value;
    var confirmPassword = document.getElementById("pass2").value;
    var pass2Error = document.getElementById("pass2Error");

    if (password !== confirmPassword) {
        pass2Error.innerHTML = "Mật khẩu không khớp. Vui lòng nhập lại.";
        return false; // Ngăn chặn việc gửi form
    } else {
        pass2Error.innerHTML = "";
        return true; // Cho phép việc gửi form
    }
}
