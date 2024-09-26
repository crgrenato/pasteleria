<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="modelo.Clientes" %>
<%@ page import="controller.CarritoBD" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar Cliente</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #fce4ec; /* Color de fondo */
        }
        .container {
            margin-top: 50px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .btn-primary {
            margin-right: 10px;
        }
    </style>
    <script>
        function validarFormulario() {
            var apellidos = document.getElementById("apellidos").value.trim();
            var nombres = document.getElementById("nombres").value.trim();
            var direccion = document.getElementById("direccion").value.trim();
            var fechaNacimiento = document.getElementById("fechaNacimiento").value.trim();
            var correo = document.getElementById("correo").value.trim();

            if (apellidos === '' || nombres === '' || direccion === '' || fechaNacimiento === '' || correo === '') {
                alert('Por favor, completa todos los campos del formulario.');
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <div class="container">
        <h1 class="mt-5">Editar Cliente</h1>
        <form action="guardarEdicionCliente.jsp" method="post" onsubmit="return validarFormulario()">
            <div class="form-group">
                <label for="idCliente">ID Cliente:</label>
                <input type="text" class="form-control" id="idCliente" name="idCliente" value="<%= request.getParameter("idCliente") %>" readonly>
            </div>
            <div class="form-group">
                <label for="apellidos">Apellidos:</label>
                <input type="text" class="form-control" id="apellidos" name="apellidos" value="<%= (request.getParameter("apellidos") != null) ? request.getParameter("apellidos") : "" %>">
            </div>
            <div class="form-group">
                <label for="nombres">Nombres:</label>
                <input type="text" class="form-control" id="nombres" name="nombres" value="<%= (request.getParameter("nombres") != null) ? request.getParameter("nombres") : "" %>">
            </div>
            <div class="form-group">
                <label for="direccion">Dirección:</label>
                <input type="text" class="form-control" id="direccion" name="direccion" value="<%= (request.getParameter("direccion") != null) ? request.getParameter("direccion") : "" %>">
            </div>
            <div class="form-group">
                <label for="fechaNacimiento">Fecha de Nacimiento:</label>
                <input type="date" class="form-control" id="fechaNacimiento" name="fechaNacimiento" value="<%= (request.getParameter("fechaNacimiento") != null) ? request.getParameter("fechaNacimiento") : "" %>">
            </div>
            <div class="form-group">
                <label for="sexo">Sexo:</label>
                <select class="form-control" id="sexo" name="sexo">
                    <option value="M" <%= (request.getParameter("sexo") != null && request.getParameter("sexo").equals("M")) ? "selected" : "" %>>Masculino</option>
                    <option value="F" <%= (request.getParameter("sexo") != null && request.getParameter("sexo").equals("F")) ? "selected" : "" %>>Femenino</option>
                </select>
            </div>
            <div class="form-group">
                <label for="correo">Correo Electrónico:</label>
                <input type="email" class="form-control" id="correo" name="correo" value="<%= (request.getParameter("correo") != null) ? request.getParameter("correo") : "" %>">
            </div>
            <div class="form-group">
                <label for="tipoUsuario">Tipo de Usuario:</label>
                <select class="form-control" id="tipoUsuario" name="tipoUsuario">
                    <option value="user" <%= (request.getParameter("tipoUsuario") != null && request.getParameter("tipoUsuario").equals("user")) ? "selected" : "" %>>Cliente</option>
                    <option value="admin" <%= (request.getParameter("tipoUsuario") != null && request.getParameter("tipoUsuario").equals("admin")) ? "selected" : "" %>>Administrador</option>
                </select>
            </div>

            <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Guardar Cambios</button>
            <a href="verClientes.jsp" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Volver</a>
        </form>
    </div>
</body>
</html>
