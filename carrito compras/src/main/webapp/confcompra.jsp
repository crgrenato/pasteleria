<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page session="true" %>
<%@ page import="modelo.*" %>
<%@ page import="controller.CarritoBD" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %> 
<%@ page import= "java.time.LocalDate"%>
<%@ page import= "java.sql.Date "%>
<% 
    HttpSession sesion = request.getSession();  
    ArrayList<carrito> Lista = (ArrayList<carrito>) sesion.getAttribute("cesto");
    double total_venta = (double) sesion.getAttribute("total");
    char estado = '1';
    
    String fecha = "2024-05-04";
    
    CarritoBD ObjBD = new CarritoBD(); // CONTROLADOR     
    String IdClie = request.getParameter("username");
    
    int filas = ObjBD.NumeroFilas("ventas");
    String idventa ;
    if(filas == 0){  	  
        idventa = "VTA0000001";
    } else {
        idventa = "VTA"+String.format("%07d",filas+1);
    }
    
    // Convertir la cadena a un objeto Date
    String fechaCom = "2024-05-04";
    LocalDate fechaLocal = LocalDate.parse(fecha);
    Date fechaVenta = Date.valueOf(fechaLocal);
    
    double montototal = 0;
    // Recorrer todos los productos de Lista
    if(Lista != null){
        Ventas venta = new Ventas();
        venta.setIdVenta(idventa);
        venta.setIdCliente(IdClie);   	
        venta.setMontoTotal(total_venta);
        venta.setEstado(estado);  
        venta.setFechaVenta(fechaCom);
        
        //aca ya tengo mi venta lista
        ObjBD.InsertarVenta(venta);
        
        for (int i = 0; i < Lista.size(); i++) {
            Detalle detalle = new Detalle();
            detalle.setCantidad(Lista.get(i).getCantidad());
            detalle.setIdVenta(idventa);
            Productos item = new Productos();
            item = ObjBD.InfoProducto(Lista.get(i).getIdProducto());
            detalle.setEstado(item.getEstado());
            detalle.setIdProducto(Lista.get(i).getIdProducto());
            detalle.setPrecioUnidad(item.getPrecioUnidad());
            ObjBD.InsertarDetalle(detalle);
        }   	
    }
%>
<%
    String idClienteAutenticado = (String) session.getAttribute("idCliente");
    Clientes ObjP = new Clientes();
    ObjP = ObjBD.InfoCliente(idClienteAutenticado);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>COMPRA EXITOSA</title>
    <style>
        body {
            background-color: #fce4ec; /* Color de fondo rosa suave */
            font-family: Arial, sans-serif;
            padding-top: 50px;
            text-align: center;
        }

        h1 {
            font-size: 24px;
            color: #dc3545; /* Color rojo */
            margin-bottom: 20px;
        }

        h2 {
            font-size: 36px;
            color: #dc3545; /* Color rojo */
            margin-top: 50px;
            margin-bottom: 20px;
            padding: 20px;
            border-radius: 10px;
            background-color: #fff; /* Color de fondo blanco */
            display: inline-block;
        }

        .return-button {
            display: block;
            text-align: center;
            margin-top: 20px;
            margin-bottom: 50px;
            padding: 10px 20px;
            background-color: #dc3545; /* Color rojo */
            color: #fff; /* Color de texto */
            border: none;
            border-radius: 5px;
            text-decoration: none;
            font-weight: bold;
            font-size: 20px;
            transition: background-color 0.3s;
        }

        .return-button:hover {
            background-color: #c82333; /* Cambio de color al pasar el mouse */
        }

    </style>
</head>
<body>
    <h2>
        Felicidades por su compra en Pastelería UPN "<b><%= ObjP.getNombres()%> <%=ObjP.getApellidos()%></b>". ¡Vuelva pronto!
    </h2>
    <img src="slogan.png" alt="Slogan Image"style="width: 200px;">
    <a href="cancelar.jsp" class="return-button">REGRESAR A LA PÁGINA PRINCIPAL</a>
</body>
</html>
