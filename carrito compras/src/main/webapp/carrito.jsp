<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page session="true" %>
<%@ page import="modelo.*" %>
<%@ page import="controller.CarritoBD" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Confirmacion de Compra</title>
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

        .card {
            margin: 10px;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s ease-in-out;
            max-width: 250px; /* Ancho máximo de la tarjeta */
        }

        .card:hover {
            transform: translateY(-5px); /* Efecto al acercarse */
        }

        .card img {
            width: 100%;
            height: auto;
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
        }

        .card-body {
            padding: 10px;
            text-align: center;
        }

        .btn {
            color: #fff; /* Color de texto */
            background-color: #dc3545; /* Color de fondo */
            border: none;
            padding: 8px 16px;
            border-radius: 5px;
            text-decoration: none;
            transition: background-color 0.3s;
            margin-top: 10px; /* Espaciado superior */
        }

        .btn:hover {
            background-color: #c82333; /* Cambio de color al pasar el mouse */
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

        .return-link {
            display: inline-block;
            margin: 10px;
            text-decoration: none;
            color: #fff;
            background-color: #dc3545; /* Color de fondo */
            padding: 8px 16px;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        .return-link:hover {
            background-color: #c82333; /* Cambio de color al pasar el mouse */
        }

        /* Estilos de la tabla */
        .table {
            width: 100%;
            border-collapse: collapse;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
        }

        .table th, .table td {
            border: 1px solid #dee2e6;
            padding: 10px;
            text-align: center;
        }

        .thead-dark {
            background-color: #343a40;
            color: white;
        }
    </style>
</head>
<body>
<h1 class="title">Detalle de Compra</h1>
<%
    try {
            // Enlaces del carrito
            String enlace1 = "<a href=index.jsp class='return-link'>Seguir Comprando</a>";
            String enlace2 = "<a href=cancelar.jsp class='return-link'>Cancelar Compra</a>";      
            String enlace3 = "<a href=logeo.jsp class='return-link'>Pagar Compra</a>";                  
            // Variable de la clase BD
            CarritoBD ObjBD = new CarritoBD();
            // Recuperando los valores del formulario
            String IdPro = (String)request.getParameter("txtid");
            int Cant =  Integer.parseInt(request.getParameter("txtcan"));
            // Agregar los valores del formulario a un objeto de tipo carrito
            carrito ObjC = new carrito(IdPro, Cant);
            // Variable para acceder a la sesion del proyecto web
            HttpSession MiSesion = request.getSession();
            // Declarar un ArrayList de tipo carrito
            ArrayList<carrito> Lista = null;
            // Recuperando los elementos almacenados en la sesion
            Lista = (ArrayList<carrito>)MiSesion.getAttribute("cesto");
            // Verificar si logro recuperar valores de la sesion
            if(Lista == null){
                Lista = new ArrayList<carrito>();
                Lista.add(ObjC);
            }else{
                // Si ya existen elementos en la lista
                boolean encontrado = false;
                for(int i = 0; i < Lista.size();i++){
                    carrito Obj = new carrito();
                    Obj = Lista.get(i);
                    if(Obj.getIdProducto().equalsIgnoreCase(IdPro)){
                        encontrado = true;
                        Obj.setCantidad(Obj.getCantidad()+Cant);
                        Lista.set(i, Obj);
                        break;
                    }
                }    
                // Si no encontro el producto a�adirlo al cesto
                if(!encontrado && Cant!=0){
                    Lista.add(ObjC);
                }
            }
            // Actualizar el valor de la sesion
            if(Cant!=0)MiSesion.setAttribute("cesto", Lista);
            //	MiSesion.removeAttribute("cesto"); ==> Eliminar un elemento de la sesion
            // Construir la factura
            String tabla = "<table class='table table-striped'>";
                tabla+= "<thead class='thead-dark'>";
                tabla += "<tr>";
                tabla += "<th scope='col'>Item</th>";
                tabla += "<th scope='col'>IdProducto</th>";
                tabla += "<th scope='col'>Descripcion</th>";
                tabla += "<th scope='col'>Imagen</th>";
                tabla += "<th scope='col'>Precio</th>";
                tabla += "<th scope='col'>Cantidad</th>";
                tabla += "<th scope='col'>Sub-Total</th>";
                tabla += "<th scope='col'>Opciones</th>";
                tabla += "</tr>";
                tabla += "</thead>";
                double Total = 0; int i;
                // Recorrer todos los productos de Lista
                for(i = 0; i < Lista.size(); i++){
                    Productos Obj = new Productos();
                    // Recuperar la informacion de cada producto del cesto
                    Obj = ObjBD.InfoProducto(Lista.get(i).getIdProducto());
                    String enlace = "suprimir.jsp?id="+Obj.getIdProducto();
                    double Precio = Obj.getPrecioUnidad();
                    int Cantidad = Lista.get(i).getCantidad();
                    double SubTotal = Precio * Cantidad;
                    Total += SubTotal;
                    tabla += "<tr>";
                        tabla += "<td>"+(i+1)+"</td>";
                        tabla += "<td>"+Obj.getIdProducto()+"</td>";
                        tabla += "<td>"+Obj.getDescripcion()+"</td>";
                        tabla += "<td><img src=img/"+Obj.getImagen()+
                                " width=50 height=50></td>";
                        tabla += "<td>"+Precio+"</td>";
                        tabla += "<td>"+Cantidad+"</td>";
                        tabla += "<td>"+SubTotal+"</td>";
                        tabla += "<td><a href="+enlace+" class='btn btn-danger' role='button'>Suprimir</a></td>";
                    tabla +="</tr>";
                }
                tabla += "<tr bgcolor=#343a40><th colspan=6>TOTAL GENERAL</th><th>"+Total+"</th><th></th></tr>";
                tabla += "<tr><td colspan=8 align=center>" + enlace1 + enlace2 + enlace3 + "</td></tr>";
            tabla += "</table>";
            out.print(tabla);
            // Guardar valores en sesion
            MiSesion.setAttribute("numarticulos", i);
            MiSesion.setAttribute("total", Total);
        } finally {            
            out.close();
        }
%>
</body>
</html>
