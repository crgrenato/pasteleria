<%@page import="modelo.Productos"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page session="true" %>
<%@ page import="modelo.Productos" %>
<%@ page import="controller.CarritoBD" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Carrito de Compras</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <style>
        body {
            background-color: #fce4ec; /* Color rosa suave */
            font-family: Arial, sans-serif; /* Fuente */
            padding-top: 20px; /* Espaciado superior */
        }

        .container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
        }

        .table {
            border-collapse: collapse;
            width: 50%;
            margin: auto; /* Centrar tabla */
            margin-top: 20px; /* Espaciado superior */
        }

        .table th,
        .table td {
            border-width: 5px; /* Grosor del borde */
            border-style: solid; /* Estilo del borde */
            padding: 10px; /* Espaciado interno */
            text-align: center; /* Alineación del texto */
        }

        .table img {
            max-width: 100px; /* Ancho máximo de la imagen */
            max-height: 100px; /* Altura máxima de la imagen */
        }

        .return-link {
            display: block;
            text-align: center;
            margin-top: 20px; /* Espaciado superior */
            text-decoration: none;
            color: #fff; /* Color de texto */
            background-color: #6c757d; /* Color de fondo */
            padding: 10px 20px; /* Espaciado interno */
            border-radius: 5px; /* Borde redondeado */
            transition: background-color 0.3s; /* Transición de color de fondo */
        }

        .return-link:hover {
            background-color: #5a6268; /* Cambio de color al pasar el mouse */
        }

        /* Estilos para el botón Añadir al Carrito */
        .btn-add-to-cart {
            color: #fff;
            background-color: #dc3545; /* Color naranja claro */
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .btn-add-to-cart:hover {
            background-color: #ff7b39; /* Cambio de color al pasar el mouse */
        }
        
        .title {
            text-align: center;
            font-size: 48px; /* Tamaño de fuente */
            color: #dc3545; /* Color rojo */
            font-weight: bold; /* Negrita */
            text-transform: uppercase; /* Mayúsculas */
            letter-spacing: 2px; /* Espaciado entre letras */
            margin-bottom: 20px; /* Espaciado inferior */
        }

        .error-message {
            color: #dc3545; /* Color rojo */
            font-size: 14px;
            text-align: center; /* Centrar texto */
            margin-bottom: 10px; /* Espaciado inferior */
        }
    </style>
</head>
<body>
<%
    String IdPro = request.getParameter("id");
    CarritoBD ObjBD = new CarritoBD();
    Productos ObjP = new Productos();
    ObjP = ObjBD.InfoProducto(IdPro);
%> 
<h1 class="title" align="center">CARRITO DE COMPRAS</h1>
<form action="carrito.jsp" id="carritoForm">
    <!-- Mensaje de error para la cantidad -->
    <p class="error-message" id="cantidadError"></p>
    <table class="table table-bordered rounded shadow">
        <tr>
            <td>IdProducto</td>
            <td><input name="txtid" value="<%=ObjP.getIdProducto()%>" readonly/></td>
        </tr>
        <tr>
            <td>Descripcion</td>
            <td><%=ObjP.getDescripcion()%></td>
        </tr>
        <tr>
            <td>Precio</td>
            <td><%=ObjP.getPrecioUnidad()%></td>
        </tr>
        <tr>
            <td>Stock</td>
            <td><%=ObjP.getStock()%></td>
        </tr>
        <tr>
            <td>Imagen</td>
            <td><img src="img/<%=ObjP.getImagen()%>" alt="<%=ObjP.getDescripcion()%>"></td>
        </tr>
        <tr>
            <td>Cantidad</td>
            <td><input name="txtcan" id="txtcan" /></td>
        </tr>
        <tr>
            <td colspan="2"><button type="button" onclick="addToCart()" class="btn-add-to-cart">Añadir al Carrito</button></td>
        </tr>
    </table>
</form>
<a href="javascript:history.back()" class="return-link">Seleccionar Otro Producto</a>

<!-- Script para validar la cantidad antes de enviar el formulario -->
<script>
    function addToCart() {
        var cantidad = document.getElementById('txtcan').value;
        var cantidadError = document.getElementById('cantidadError');
        if (cantidad.trim() === '') {
            // cantidadError.innerText = 'Por favor, ingrese una cantidad.';
            return;
        }
        document.getElementById('carritoForm').submit();
    }
</script>
</body>
</html>
