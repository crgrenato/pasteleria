<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ page import="modelo.Categorias" %>
<%@ page import="controller.CarritoBD" %>
<%@ page import="modelo.Clientes" %>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Pastelería UPN</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <style> 
    /* Estilo para el color de fondo rosa suave */
    body {
        background-color: #fce4ec; /* Color rosa suave */
        overflow-x: hidden; /* Eliminar la barra de desplazamiento horizontal */
        position: relative; /* Posición relativa para los copos de nieve */
    }

    h2 {
        background-size: cover;
        background: Sky Blue;
        margin-left: 50px;
        padding-right: 50px;
        margin-right: 50px;
        border-radius: 10px;
    }

    img {
        width: 150px;
        height: 150px;
        margin-bottom: 10px;
        border-radius: 75px; 
        box-shadow: 0px 4px 8px rgba(0, 0, 0, 2.7);
        transition: transform 0.3s ease-in-out;
    }

    img:hover {
        transform: translateY(-5px); 
    }

    .pastel-table {
        margin-top: 50px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Agregamos una sombra suave */
    }

    .pastel-table th, .pastel-table td {
        border-width: 0; /* Quitamos el borde */
        padding: 20px; /* Añadimos espacio interno */
        background-color: #f5f4f4e5; /* Hacemos el fondo transparente */
    }

    .pastel-table td {
        color: #333; /* Color de texto */
    }

    .title {
        text-align: center;
        font-size: 24px;
        color: #333; /* Color de texto */
        margin-bottom: 20px;
    }

    .slogan {
        font-size: 22px;
        color: #dc3545; /* Color rojo */
        margin-bottom: 30px;
    }

    .info-text {
        text-align: right;
        margin-right: 50px;
    }

    .scrolling-text {
        overflow: hidden;
        white-space: nowrap;
        animation: marquee 15s linear infinite;
    }

    @keyframes marquee {
        0% {
            transform: translateX(100%);
        }
        100% {
            transform: translateX(-100%);
        }
    }

 /* Estilo para el botón de cerrar sesión */
    .logout-button {
        position: absolute;
        top: 90px;
        right: 20px;
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
    <%
    HttpSession sesion = request.getSession();
    if(sesion.getAttribute("numarticulos") == null){
        sesion.setAttribute("numarticulos", 0);
        sesion.setAttribute("total", 0.0);
    }
    //RECUPERANDO DE LA SESION LOS VALORES DE numarticulos y total
    int nroarticulos= (int)(sesion.getAttribute("numarticulos"));
    double total = (double)(sesion.getAttribute("total"));
    //RECUPERANDO DE LA SESION EL ID DEL CLIENTE
    String idCliente = (String) session.getAttribute("idCliente");
    CarritoBD ObjBD = new CarritoBD();
    Clientes ObjP = ObjBD.InfoCliente(idCliente);
    String nombreCliente = ObjP.getNombres();
    String apellidoCliente = ObjP.getApellidos();
    List<Categorias> Lista = ObjBD.ListarCategorias();
    int columnas = 0;
    %>    

    <div class="title" style="text-align: center;">
    <div style="display: inline-block;">
        <div class="scrolling-text">
            <h2>Bienvenid@ <%=nombreCliente%> <%=apellidoCliente%> nos alegra tenerte de vuelta, para endulzar tu dia!</h2>
        </div>
        <img src="slogan.png" alt="Slogan Image" width="550" height="550" style="display: block; margin: 0 auto; margin-left: 599px;">
        <div class="slogan" style="margin: 20px auto 0; margin-left: -50px;"><strong>¡Los mejores pasteles para los mejores momentos!</strong></div>
    </div>
</div>
    
    <div class="info-text" style="text-align: center; margin-top: 20px;">
    <h2 style="display: inline-block; font-size: 18px; margin: 0 152px;">TOTAL DE PRODUCTOS: <%=nroarticulos %></h2>
    <h2 style="display: inline-block; font-size: 18px; margin: 0 30px;">TOTAL ACUMULADO: S/<%=total %></h2>
</div>
      
    <table class="table table-bordered rounded shadow pastel-table">
    <% 
       for(Categorias c : Lista){
            String imagen = "<img src='img/" + c.getImagen() + "' width='150' height='150'>";
            String enlace = "<a href='verproductos.jsp?id=" + c.getIdCategoria() + "' class='btn btn-danger'>Ver Productos</a>";
            if(columnas % 3 == 0) out.print("<tr>");
    %>
        <td style="text-align: center;">
            <h4><%=c.getDescripcion()%></h4>
            <%=imagen%><br/>
            <%=enlace%>
        </td>
    <% 
        columnas++;
        if(columnas % 3 == 0) out.print("</tr>");
       } 
       if(columnas % 3 != 0) out.print("</tr>");
    %>
    </table>

    <!-- Botón de cerrar sesión -->
    <a href="iniciarsesion.jsp" class="logout-button">Cerrar Sesión</a>

    <!-- Agregar los copos de nieve -->
    <div class="snowflake"></div>
    <div class="snowflake"></div>
    <div class="snowflake"></div>
    <!-- Puedes agregar más copos de nieve si lo deseas -->
</body>
</html>
