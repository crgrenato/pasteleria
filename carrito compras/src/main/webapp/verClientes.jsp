	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="modelo.Clientes" %>
<%@ page import="controller.CarritoBD" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ver Clientes</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
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
        .btn-danger {
            background-color: #dc3545;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 5px 10px;
            font-size: 14px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .btn-danger:hover {
            background-color: #c82333;
        }
        .alert-success {
            margin-top: 20px;
            padding: 10px;
            border-radius: 5px;
            background-color: #d4edda;
            color: #155724;
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
        <h1 class="mt-5">Clientes</h1>
        <form action="agregarCliente.jsp" method="post">
		    <button type="submit" class="btn btn-success" name="agregarCliente"><i class="fas fa-plus"></i> Agregar</button>
	    </form>
        <table class="table mt-3">
            <thead>
                <tr>
                    <th>ID Cliente</th>
                    <th>Apellidos</th>
                    <th>Nombres</th>
                    <th>Dirección</th>
                    <th>Fecha de Nacimiento</th>
                    <th>Sexo</th>
                    <th>Correo</th>
                    <th>Tipo de Usuario</th>
                    <th>Acciones</th> <!-- Nueva columna para el botón de eliminar -->
                </tr>
            </thead>
            <tbody>
                <% 
                    CarritoBD carritoBD = new CarritoBD();
                    List<Clientes> listaClientes = carritoBD.ListarClientes();
                    for (Clientes cliente : listaClientes) {
                %>
                <tr>
                    <td><%= cliente.getIdCliente() %></td>
                    <td><%= cliente.getApellidos() %></td>
                    <td><%= cliente.getNombres() %></td>
                    <td><%= cliente.getDireccion() %></td>
                    <td><%= cliente.getFechaNacimiento() %></td>
                    <td><%= cliente.getSexo() %></td>
                    <td><%= cliente.getCorreo() %></td>
                    <td><%= cliente.getTipoUsuario() %></td>
                    <td>
	                  <div class="d-flex">
	                   <form action="editarCliente.jsp" class="mr-2 method="post">
			                <input type="hidden" name="idCliente" value="<%= cliente.getIdCliente() %>">
			                <button type="submit" class="btn btn-warning btn-sm" name="editarCliente"><i class="fas fa-edit"></i> Editar</button> <!-- Botón de tipo submit con ícono de editar -->
			            </form>
			            <form action="eliminarCliente.jsp" method="post" onsubmit="return confirm('¿Estás seguro de que deseas eliminar este usuario?');"> <!-- Formulario para eliminar cliente -->
			                <input type="hidden" name="idCliente" value="<%= cliente.getIdCliente() %>"> <!-- Campo oculto para enviar el ID del cliente -->
			                <button type="submit" class="btn btn-danger" name="eliminarCliente"><i class="fas fa-trash"></i> Eliminar</button> <!-- Botón de tipo submit con ícono de eliminar -->
			            </form>
			        </div>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <!-- Mostrar mensaje de eliminación exitosa si existe -->
        <% if (request.getAttribute("eliminacionExitosa") != null) { %>
            <div class="alert alert-success" role="alert">
                Usuario eliminado satisfactoriamente.
            </div>
        <% } %>
    </div>
</body>
</html>