<%-- 
    Document   : product-management
    Created on : Dec 7, 2023, 3:27:52 PM
    Author     : Admin
--%>
<%@page import="io.hardingadonis.miu.services.Singleton"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <link rel="icon" href="./assets/img/favicon.ico" type="image/ico" />
        <title>Product Management</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="<%=request.getContextPath()%>/assets/css/admin/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

    </head>
    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <a class="navbar-brand ps-3" href="index.html">Welcome Admin</a>
            <!-- Sidebar Toggle-->
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i
                    class="fas fa-bars"></i></button>
            <!-- Navbar Search-->
            <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
            </form>
            <!-- Navbar-->
            <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown"
                       aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="#!">Logout</a></li>
                    </ul>
                </li>
            </ul>
        </nav>
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                        <div class="nav">
                            <div class="sb-sidenav-menu-heading">Core</div>
                            <a class="nav-link" href="index.html">
                                <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                                Dashboard
                            </a>
                            <a class="nav-link" href="list_user.html">
                                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                                User Management
                            </a>
                            <a class="nav-link" href="list_order.html">
                                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                                Order Management
                            </a>

                            <a class="nav-link" href="list_category.html">
                                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                                Category Management
                            </a>

                            <a class="nav-link" href="list_product.html">
                                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                                Product Management
                            </a>
                        </div>
                    </div>
                    <div class="sb-sidenav-footer">
                        <div class="small">Logged in as:</div>
                        Admin
                    </div>
                </nav>
            </div>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">List Product</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">Admin Role</li>
                        </ol>
                        <div class="add-action mb-2">
                            <button type="button" class="btn btn-success waves-effect" onclick="openAddModal()"> <i class="fa fa-plus-circle"></i> Add New Product</button>
                        </div>
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-table me-1"></i>
                                Product Table
                            </div>
                            <div class="card-body">
                                <table id="datatablesSimple" class="datatable-table">
                                    <thead>
                                        <tr>
                                            <th style="width: 5%">ID</th>
                                            <th style="width: 40%">Name</th>
                                            <th style="width: 10%">Category</th>
                                            <th style="width: 10%">Price</th>
                                            <th style="width: 10%">Amount</th>
                                            <th style="width: 15%">Thumbnail</th>
                                            <th style="width: 10%">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="p" items="${Singleton.productDAO.getAll()}">
                                            <tr>
                                                <td>${p.ID}</td>
                                                <td>${p.name}</td>
                                                <td>
                                                    ${Singleton.categoryDAO.getNameCategory(p.categoryID)}
                                                </td>
                                                <td>${p.price}</td>
                                                <td>${p.amount}</td>
                                                <td>
                                                    <img src="<%=request.getContextPath()%>/${p.thumbnail}" style="width: 80px; height: 80px" 
                                                         class="card-img-top">
                                                </td>
                                                <td>
                                                    <a href="#" class="btn btn-info btn-tiny btn-view-detail"
                                                       style="background-color: rgb(74, 172, 114);" title="View Detail">
                                                        <i class="fa fa-search"></i>
                                                    </a>

                                                    <a href="#" class="btn btn-info btn-tiny" title="Edit">
                                                        <i class="fa fa-pencil"></i>
                                                    </a>

                                                    <button class="btn btn-danger btn-tiny" title="Delete" onclick="deleteProduct(${p.ID})">
                                                        <i class="fa fa-trash"></i>
                                                    </button>
                                                </td>
                                        <input class="brand"  type="hidden" value="${p.brand}"/>
                                        <input class="origin"  type="hidden" value="${p.origin}"/>
                                        <input class="expiryDate"  type="hidden" value="${p.expiryDate}"/>
                                        <input class="weight"  type="hidden" value="${p.weight}"/>
                                        <input class="preservation"  type="hidden" value="${p.preservation}"/>
                                        <input class="images"  type="hidden" value="${p.images}"/>
                                        <input class="createAt"  type="hidden" value="${p.createAt}"/>
                                        <input class="updateAt"  type="hidden" value="${p.updateAt}"/>
                                        <input class="deleteAt"  type="hidden" value="${p.deleteAt}"/>
                                        </tr>
                                    </c:forEach>

                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </main>
                <footer class="py-4 bg-light mt-auto">
                    <div class="container-fluid px-4">
                        <div class="d-flex align-items-center justify-content-between small">
                            <div class="text-muted">Copyright &copy; Group1's Website 2023</div>
                            <div>
                                <a href="#">Privacy Policy</a>
                                &middot;
                                <a href="#">Terms &amp; Conditions</a>
                            </div>
                        </div>
                    </div>
                </footer>
            </div>
        </div>


        <!-- View detail Product -->
        <div class="modal fade" id="detailModal" tabindex="-1" role="dialog" aria-labelledby="detailModalLabel"
             aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="detailModalLabel">Product Detail</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <!-- Detail table content will be inserted here dynamically -->
                        <table id="datatablesSimple" class="datatable-table">

                            <c:forEach var="p" items="${Singleton.productDAO.getAll()}">
                                <tr>
                                    <td>${p.brand}</td>
                                    <td>${p.origin}</td>
                                    <td>${p.expiryDate}</td>
                                    <td>${p.weight}</td>
                                    <td>${p.preservation}</td>

                                    <td>${p.images}</td>

                                    <td>${p.createAt}</td>
                                    <td>${p.updateAt}</td>
                                    <td>${p.deleteAt}</td>

                                </tr>
                            </c:forEach>

                        </table>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>


        <!-- Add Product Modal -->
        <div class="modal fade" id="addProductModal" tabindex="-1" role="dialog" aria-labelledby="addProductModalLabel"
             aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addProductModalLabel">Add New Product</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <!-- Form for adding a new product -->
                        <form id="addProductForm">
                            <!-- Add your form fields here (e.g., name, category, price, etc.) -->
                            <!-- Example: -->
                            <div class="mb-3">
                                <label for="productName" class="form-label">Product Name</label>
                                <input type="text" class="form-control" id="productName" name="productName" required>
                            </div>
                            <!-- Add other form fields as needed -->

                            <button type="submit" class="btn btn-primary">Add Product</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>


        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
        <script src="js/scripts.js"></script>
        <script src="<%=request.getContextPath()%>/assets/js/admin/view-detail-product.js"></script>
        <script src="<%=request.getContextPath()%>/assets/js/admin/delete-product.js"></script>
        <script src="<%=request.getContextPath()%>/assets/js/admin/add-product.js"></script>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
        <script src="assets/js/admin/chart-area-demo.js"></script>
        <script src="assets/js/admin/chart-bar-demo.js"></script>
        <script src="assets/js/admin/chart-pie-demo.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
        crossorigin="anonymous"></script>
        <script src="js/datatables-simple-demo.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </body>
</html>
