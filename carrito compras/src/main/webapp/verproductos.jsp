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
    <title>Productos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    
    <style>
        body {
            background-color: #fce4ec; /* Color rosa suave */
            font-family: Arial, sans-serif; /* Fuente */
            padding-top: 20px; /* Espaciado superior */
        }

        h1 {
            text-align: center;
            font-size: 32px; /* Tamaño de fuente */
            color: #dc3545; /* Color rojo */
            margin-bottom: 20px; /* Espaciado inferior */
        }

        .container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
        }

        .card {
            margin: 10px; /* Aumento del margen */
            border-radius: 15px; /* Aumento del radio de borde */
            overflow: hidden;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s ease-in-out;
            max-width: 200px; /* Ajuste del tamaño máximo de la tarjeta */
        }

        .card:hover {
            transform: translateY(-5px); /* Efecto al acercarse */
        }

        .card img {
            width: 100%;
            height: auto;
            border-top-left-radius: 15px; /* Ajuste del radio de borde */
            border-top-right-radius: 15px; /* Ajuste del radio de borde */
        }

        .card-body {
            padding: 8px;
            text-align: center;
        }

        .btn {
            color: #fff; /* Color de texto */
            background-color: #dc3545; /* Color de fondo */
            border: none;
            padding: 6px 12px;
            border-radius: 5px;
            text-decoration: none;
            transition: background-color 0.3s;
            margin-top: 8px; /* Espaciado superior */
            font-size: 14px; /* Tamaño de fuente */
        }

        .btn:hover {
            background-color: #c82333; /* Cambio de color al pasar el mouse */
        }

        .return-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            text-decoration: none;
            color: #fff;
            background-color: #6c757d; /* Color de fondo */
            padding: 8px 16px;
            border-radius: 5px;
            transition: background-color 0.3s;
            font-size: 16px; /* Tamaño de fuente */
        }

        .return-link:hover {
            background-color: #5a6268; /* Cambio de color al pasar el mouse */
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
    </style>
</head>
<body>
    <%
        String IdCat = request.getParameter("id");
        CarritoBD ObjBD = new CarritoBD();
        List<Productos> Lista = new ArrayList<>();
        Lista = ObjBD.ListarProductos(IdCat);
    %>    
   <h1 class="title" align="center">PRODUCTOS</h1>
    <div class="container">
        <%
            for(Productos c : Lista){
                String imagen = "img/" + c.getImagen();
                String enlace = "verdetalle.jsp?id=" + c.getIdProducto();
        %>
        <div class="card">
            <img src="<%=imagen%>" alt="<%=c.getDescripcion()%>" />
            <div class="card-body">
                <h4><%=c.getDescripcion()%></h4>
                <a href="<%=enlace%>" class="btn">Ver Detalle</a>
            </div>
        </div>
        <% 
            } 
        %>
    </div>
    <a href="index.jsp" class="return-link">REGRESAR A LA PÁGINA PRINCIPAL</a>
</body>
</html>
