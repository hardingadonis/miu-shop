<footer class="bg-light p-1">
    <div class="container position-relative text-center">
        <div class="d-flex justify-content-between my-5 text-start flex-wrap">
            <ul class="nav flex-column">
                <li class="fw-bold nav-item">
                    <a href="home" class="nav-link text-dark">
                        Danh mục sản phẩm
                    </a>
                </li>
                <c:forEach var="category" items="${Singleton.categoryDAO.getAll()}">
                    <li class="nav-item">
                        <a href="search?category_id=${category.ID}" class="nav-link text-muted">
                            ${category.name}
                        </a>
                    </li>
                </c:forEach>
            </ul>
            <ul class="nav flex-column">
                <li class="fw-bold nav-item text-dark">
                    <a href="home" class="nav-link text-dark">Hỗ trợ</a>
                </li>
                <li class="nav-item">
                    <a href="profile" class="nav-link text-muted">Cài đặt</a>
                </li>
                <li class="nav-item">
                    <a href="cart" class="nav-link text-muted">Giỏ hàng</a>
                </li>
                <li class="nav-item">
                    <a href="purchase-history?tab=all" class="nav-link text-muted">Lịch sử mua hàng</a>
                </li>
            </ul>
            <ul class="nav flex-column">
                <li class="fw-bold nav-item text-dark">
                    <a href="home" class="nav-link text-dark">Mã nguồn</a>
                </li>
                <li class="nav-item">
                    <a href="https://github.com/hardingadonis/miu-shop" target="_blank" class="nav-link text-muted">
                        <i class="fab fa-github"></i>
                        GitHub
                    </a>
                </li>
            </ul>
            <ul class="nav flex-column">
                <li class="fw-bold nav-item text-dark">
                    <a href="home" class="nav-link text-dark">Thông tin</a>
                </li>
                <li class="nav-item">
                    <a href="about" class="nav-link text-muted">Giới thiệu về Miu Shop</a>
                </li>
            </ul>
        </div>
    </div>
</footer>