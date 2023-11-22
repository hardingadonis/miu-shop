
function validateForm() {
            var password = document.getElementById("pass").value;
            var confirmPassword = document.getElementById("pass2").value;
            var pass2Error = document.getElementById("pass2Error");

            if (password !== confirmPassword) {
                pass2Error.innerHTML = "Password and Confirm Password must match!";
                return false; // Prevent form submission
            } else {
                pass2Error.innerHTML = "";
                return true; // Allow form submission
            }
        }