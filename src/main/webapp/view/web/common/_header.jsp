<%@page import="io.hardingadonis.miu.services.Singleton"%>

<header>
    <nav class="navbar navbar-expand-lg navbar-light bg-light top-0 start-0 w-100">
        <div class="container">
            <a href="home" class="navbar-brand d-lg-none text-uppercase">
                Miu Shop
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse p-2 flex-column" id="navbarContent">
                <div class="d-flex justify-content-center justify-content-lg-between flex-column flex-lg-row w-100">
                    <form class="d-flex" action="search" method="get">
                        <input name="search-name" type="search" class="form-control me-2" placeholder="Tìm kiếm" value="${search_name}"/>
                        <button class="btn btn-outline-dark" type="submit">
                            <i class="fas fa-search"></i>
                        </button>
                    </form>
                    <a href="home" class="navbar-brand d-none d-lg-block text-uppercase">Miu Shop</a>
                    <div class="navbar-nav justify-content-center align-items-center px-3">
                        <c:if test="${sessionScope.user != null}">
                            <div class="nav-item align-items-center dropdown">
                                <div class="mx-2 my-2 d-flex" data-bs-toggle="dropdown" aria-expanded="false">
                                    <img src="./${sessionScope.user.avatarPath}" alt="Avatar" style="max-width: 1.5rem; max-width: 1.5rem;">
                                    <div class="px-2 fw-bold">${sessionScope.user.fullName}</div>
                                </div>
                                <ul class="dropdown-menu">
                                    <li>
                                        <a class="dropdown-item" href="profile">Cài đặt</a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="purchase-history?tab=all">Lịch sử mua hàng</a>
                                    </li>
                                    <li>
                                        <hr class="dropdown-divider">
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="logout">Đăng xuất</a>
                                    </li>
                                </ul>
                            </div>
                        </c:if>
                        <c:if test="${sessionScope.user == null}">
                            <li class="nav-item d-flex align-items-center">
                                <a href="register" class="btn btn-light">
                                    <i class="fas fa-plus"></i>
                                    Đăng ký
                                </a>
                            </li>
                            <li class="nav-item d-flex align-items-center">
                                <a href="login" class="btn btn-light">
                                    <i class="fas fa-sign-in"></i>
                                    Đăng nhập
                                </a>
                            </li>
                        </c:if>
                        <li class="nav-item d-flex align-items-center">
                            <a href="cart" class="nav-link mx-2">
                                <i class="fas fa-shopping-cart"></i>
                            </a>
                            <span id="total-products-in-cart" class="badge rounded-pill bg-secondary">0</span>
                        </li>
                    </div>
                </div>
                <div class="d-block w-100">
                    <ul class="navbar-nav d-flex justify-content-center align-items-center pt-3">
                        <c:forEach var="category" items="${Singleton.categoryDAO.getAll()}">
                            <li class="nav-item mx-2">
                                <a href="search?category_id=${category.ID}" class="nav-link">
                                    ${category.name}
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>
    </nav>
</header>