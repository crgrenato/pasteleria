<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ page import="modelo.Clientes" %>
<%@ page import="controller.CarritoBD" %>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Administración</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #fce4ec; /* Color de fondo fuera del contenedor */
        }    
        .category-container {
            margin-top: 50px;
            margin-bottom: 50px;
        }
        .category-card {
            margin-bottom: 20px;
            border-radius: 55px; /* Bordes redondeados */
            border: 2px solid #ccc; /* Borde ligeramente gris */
            background-color: #fff; /* Fondo blanco */
            transition: transform 0.3s ease; /* Transición en la transformación */
        }
        .category-card:hover {
            transform: translate(0px, -5px); /* Movimiento hacia arriba al pasar el mouse */
        }
        .category-card img {
            width: 50%; /* Reducir el tamaño de la imagen */
            height: auto;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
            margin-top: 20px; /* Añadir margen superior */
        }
        .category-card .card-body {
            text-align: center;
        }
        .category-card h4 {
            margin-top: 10px;
            margin-bottom: 10px;
        }
        .category-card a.btn {
            width: 100%;
        }
        .admin-title {
            text-align: center;
            font-size: 50px; /* Cambia el tamaño del título aquí */
            margin-top: 20px;
            margin-bottom: 30px;
        }

        /* Estilo para el botón de cerrar sesión */
        .logout-button {
            position: absolute;
            top: 50px; /* Ajuste de la posición vertical */
            right: 25px; /* Ajuste de la posición horizontal */
            background-color: #dc3545;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s, box-shadow 0.3s; /* Añadimos transición al sombreado */
            text-decoration: none; /* Eliminar subrayado */
            text-shadow: 0px 1px 1px #c82333; /* Sombreado de texto */
        }

        .logout-button:hover {
            background-color: #c82333;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.3); /* Cambiamos el sombreado */
        }

        .logout-button:focus {
            outline: none;
            text-decoration: none; /* Eliminar subrayado al enfocar */
        }

        /* Estilo para centrar el texto Bienvenid@ Administrador: */
        .welcome-text {
            text-align: center;
            font-size: 30px;
            margin-top: 50px; /* Ajuste vertical */
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row">
            <div class="col-12">
                <h1 class="admin-title">PANEL DE ADMINISTRACION</h1>
                <% 
                    String idCliente = (String) session.getAttribute("idCliente");
                    CarritoBD ObjBD = new CarritoBD();
                    Clientes ObjP = ObjBD.InfoCliente(idCliente);
                %>
                <h2 class="welcome-text">Bienvenid@ Administrador: <%=ObjP.getNombres()%> <%=ObjP.getApellidos()%></h2>
            </div>
        </div>
        <div class="row">
            <div class="col-md-4">
                <div class="category-container">
                    <div class="category-card card">
                        <img src="img/clientes.jpg" alt="Clientes" class="mx-auto d-block">
                        <div class="card-body">
                            <h4 class="card-title">Clientes</h4>
                            <a href="verClientes.jsp" class="btn btn-primary">Ver Clientes</a>
                        </div>
                    </div>
                </div>
            </div>
        <div class="col-md-4">
          <div class="category-container">
            <div class="category-card card">
                  <img src="img/ventas.png" alt="Ventas" class="mx-auto d-block">
                  <div class="card-body">
                  <h4 class="card-title">Ventas</h4>
                  <a href="verVentas.jsp" class="btn btn-primary">Ver Ventas</a>
               </div>
            </div>
          </div>
       </div>
          <div class="col-md-4">
             <div class="category-container">
              <div class="category-card card">
                <img src="img/stock_productos.png" alt="Stock Productos" class="mx-auto d-block">
                  <div class="card-body">
                  <h4 class="card-title">Stock Productos</h4>
                  <a href="verStockProductos.jsp" class="btn btn-primary">Ver Stock Productos</a>
                </div>
              </div>
            </div>
          </div>
        </div>
    </div>

    <!-- Botón de cerrar sesión -->
    <a href="iniciarsesion.jsp" class="logout-button">Cerrar Sesión</a>

</body>
</html>
