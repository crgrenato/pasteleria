<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="modelo.Productos" %>
<%@ page import="controller.CarritoBD" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ver Stock de Productos</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #fce4ec; /* Color de fondo */
        }
        .container {
            margin-top: 50px;
        }
        table {
            background-color: #fff; /* Fondo de la tabla */
            border-radius: 10px; /* Bordes redondeados */
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* Sombra suave */
        }
        th, td {
            vertical-align: middle;
        }
        th {
            background-color: #ffc0cb; /* Color de fondo del encabezado */
            color: #542c34; /* Color de texto del encabezado */
        }
        tbody tr:nth-child(odd) {
            background-color: #f8bbd0; /* Color de fondo de las filas impares */
        }
        tbody tr:nth-child(even) {
            background-color: #f48fb1; /* Color de fondo de las filas pares */
        }
        .logout-button {
            position: absolute;
            top: 50px;
            right: 50px;
            background-color: #dc3545;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
            text-decoration: none; /* Eliminar subrayado */
        }

        .logout-button:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="admin.jsp" class="btn btn-primary logout-button">Volver a Admin</a>
        <h1 class="mt-5">Stock de Productos</h1>
        <table class="table mt-3">
            <thead>
                <tr>
                    <th>ID Producto</th>
                    <th>ID Categoría</th>
                    <th>Descripción</th>
                    <th>Precio Unidad</th>
                    <th>Stock</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    CarritoBD carritoBD = new CarritoBD();
                    List<Productos> listaProductos = carritoBD.ListarProductos2();
                    for (Productos producto : listaProductos) {
                %>
                <tr>
                    <td><%= producto.getIdProducto() %></td>
                    <td><%= producto.getIdCategoria() %></td>
                    <td><%= producto.getDescripcion().toUpperCase() %></td>
                    <td>S/<%= producto.getPrecioUnidad() %></td>
                    <td><%= producto.getStock() %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</body>
</html>
