<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
        <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/register.css" />

        <title>Miu Shop | Đăng ký</title>
    </head>
    <body>
        <div class="mt-3">
            <form onsubmit="return validateForm()">
                <div class="row jumbotron box8 border border-dark rounded bg-light">
                    <div class="col-sm-12 mx-t3 mb-4">
                        <h3 class="text-center text-white bg-dark p-3 rounded">Register</h3>
                    </div>

                    <div class="col-sm-6 form-group">
                        <label for="name">Full name<span class="text-danger">(*)</span></label>
                        <input type="text" class="form-control" name="name" id="name" placeholder="Enter your full name" required>
                    </div>

                    <div class="col-sm-6 form-group">
                        <label for="Date">Year Of Birth<span class="text-danger">(*)</span></label>
                        <input type="Date" name="dob" class="form-control" id="Date" placeholder="" required>
                    </div>

                    <div class="col-sm-12 form-group">
                        <label for="sex">Gender<span class="text-danger">(*)</span></label>
                        <select id="sex" class="form-control browser-default custom-select">
                            <option value="male">Male</option>
                            <option value="female">Female</option>
                            <option value="unspesified">Unspecified</option>
                        </select>
                    </div>

                    <div class="col-sm-12 form-group">
                        <label for="email">Email<span class="text-danger">(*)</span></label>
                        <input type="email" class="form-control" name="email" id="email" placeholder="Enter your email." required>
                    </div>      

                    <div class="col-sm-12 form-group">
                        <label for="pass">Password<span class="text-danger">(*)</span></label>
                        <input type="Password" name="password" class="form-control" id="pass" placeholder="Enter your password" required>
                        <small id="pass2Error" class="text-danger"></small>
                    </div>

                    <div class="col-sm-12 form-group">
                        <label for="pass2">Confirm Password<span class="text-danger">(*)</span></label>
                        <input type="Password" name="cnf-password" class="form-control" id="pass2" placeholder="Re-enter your password" required>
                    </div>
                    <div class="col-sm-12 d-flex align-items-center mt-1">
                        <input type="checkbox" class="form-check d-inline" id="chb" required>
                        <label for="chb" class="form-check-label">
                            &nbsp;I accept all terms and conditions.
                        </label>
                    </div>

                    <div class="form-group mt-3 mb-0">
                        <button class="btn">Sign Up</button>
                    </div>
                </div>
            </form>

            <div class="login">
                <span>Đã có tài khoản? <a href="login">Đăng nhập ngay!</a></span>
            </div>
        </div>


        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="<%=request.getContextPath()%>/assets/js/registerValidation.js"></script>
    </body>
</html>