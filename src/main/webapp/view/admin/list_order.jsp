
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" href="<%=request.getContextPath()%>/assets/images/favicon/favicon.png" type="image/ico"/>
        <title>Order Management</title>
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
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
            
            <!-- Navbar-->
            <ul class="navbar-nav d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
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
                            <a class="nav-link" href="admin">
                                <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                                Dashboard
                            </a>
                            <a class="nav-link" href="listUser">
                                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                                User Management
                            </a>
                            <a class="nav-link" href="listOrder">
                                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                                Order Management
                            </a>
                            <a class="nav-link" href="listCategory">
                                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                                Category Management
                            </a>
                            <a class="nav-link" href="listProduct">
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
                        <h1 class="mt-4">List Order</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">Admin Role</li>
                        </ol>
                        
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-table me-1"></i>
                                Order Table
                            </div>
                            <div class="card-body">
                                <table id="datatablesSimple">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>User Name</th>
                                            <th>Total Price</th>
                                            <th>Payment</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>1</td>
                                            <td>Haha</td>
                                            <td>300.000</td>
                                            <td>Bank Account</td>
                                            <td>Delivering</td>
                                            <td>
                                                <a href="#" class="btn btn-info btn-tiny" title="Edit">
                                                    <i class="fa fa-pencil"></i>
                                                </a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>2</td>
                                            <td>Hoho</td>
                                            <td>300.000</td>
                                            <td>Momo</td>
                                            <td>Waiting</td>
                                            <td>
                                                <a href="#" class="btn btn-info btn-tiny" title="Edit">
                                                    <i class="fa fa-pencil"></i>
                                                </a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>3</td>
                                            <td>Hihi</td>
                                            <td>300.000</td>
                                            <td>Cash</td>
                                            <td>Complete</td>
                                            <td>
                                                <a href="#" class="btn btn-info btn-tiny" title="Edit">
                                                    <i class="fa fa-pencil"></i>
                                                </a>
                                            </td>
                                        </tr>
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

    <!-- Edit Order Modal -->
    <div class="modal fade" id="editOrderModal" tabindex="-1" role="dialog" aria-labelledby="editOrderModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <!-- Modal Header -->
                <div class="modal-header">
                    <h5 class="modal-title" id="editOrderModalLabel">Edit Order Status</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="closeEditModal()">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <!-- Modal Body -->
                <div class="modal-body">
                    <form>
                        <div class="form-group">
                            <label for="editStatus">Status:</label>
                            <select class="form-select" id="editStatus">
                                <option value="Processing">Processing</option>
                                <option value="Shipping">Shipping</option>
                                <option value="Done">Done</option>
                                <option value="Cancel">Cancel</option>
                            </select>
                        </div>
                    </form>
                </div>
                
                <!-- Modal Footer -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" onclick="saveChanges()">Save changes</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="closeEditModal()">Cancel</button>
                </div>
            </div>
        </div>
    </div>



        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="<%=request.getContextPath()%>/assets/js/admin/scripts.js"></script>
        <script src="<%=request.getContextPath()%>/assets/js/admin/edit-order-modal.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"></script>
        <script src="<%=request.getContextPath()%>/assets/js/admin/demo/chart-area-demo.js"></script>
        <script src="<%=request.getContextPath()%>/assets/js/admin/demo/chart-bar-demo.js"></script>
        <script src="<%=request.getContextPath()%>/assets/js/admin/demo/chart-pie-demo.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"></script>
        <script src="<%=request.getContextPath()%>/assets/js/admin/demo/datatables-simple-demo.js"></script>
    </body>
</html>

