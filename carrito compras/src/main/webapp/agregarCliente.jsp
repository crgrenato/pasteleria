<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registro de Cliente</title>
    <!-- Agregar Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Estilos personalizados -->
    <style>
        /* Estilo para el contenedor principal */
        /* Estilo personalizado para el color de fondo rosa */
        body {
            background-color: #fce4ec; /* Color de fondo rosa */
        }

        /* Estilo para la tarjeta de registro */
        .card {
            background-color: #f8bbd0; /* Color celeste suave */
            padding: 30px; /* Espaciado interno */
            border-radius: 15px; /* Bordes curvos */
            box-shadow: 0px 0px 15px 0px rgba(0,0,0,0.1); /* Sombra */
        }

        /* Estilo para el título */
        .card-header h1 {
            font-size: 36px; /* Tamaño de la fuente */
            color: #673ab7; /* Color del texto */
            text-align: center; /* Alineación del texto */
            margin-bottom: 30px; /* Espaciado inferior */
        }

        /* Estilo para los campos de entrada */
        .form-group label {
            font-weight: bold; /* Negrita */
            color: #673ab7; /* Color del texto */
        }

        /* Estilo para el botón de registrar */
        .btn-register {
            background-color: #ff4081; /* Color de fondo rosa */
            border-color: #ff4081; /* Color del borde rosa */
            color: #fff; /* Color del texto blanco */
            border-radius: 5px; /* Bordes curvos */
            font-size: 20px; /* Tamaño de la fuente */
            font-weight: bold; /* Negrita */
            width: 100%; /* Ancho del botón */
            margin-top: 20px; /* Espaciado superior */
        }

        .btn-register:hover {
            background-color: #f50057; /* Color de fondo rosa oscuro al pasar el mouse */
            border-color: #f50057; /* Color del borde rosa oscuro al pasar el mouse */
        }

        /* Estilo para el enlace de inicio de sesión */
        .login-link {
            text-align: center; /* Alineación del texto */
            margin-top: 20px; /* Espaciado superior */
        }

        .login-link a {
            color: #512da8; /* Color del enlace */
            font-weight: bold; /* Negrita */
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">
                        <h1 class="text-center">Registro de Cliente</h1>
                    </div>
                    <div class="card-body">
                        <%
                            // Establecer la conexión a la base de datos
                            String url = "jdbc:mysql://localhost:3306/tienda2024";
                            String usuario = "root";
                            String password = "Ariana#2002";
                            Connection conexion = null;
                            Statement consulta = null;
                            ResultSet resultado = null;

                            try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                conexion = DriverManager.getConnection(url, usuario, password);
                                consulta = conexion.createStatement();

                                // Consulta para obtener el último ID Cliente registrado
                                String sql = "SELECT IdCliente FROM Clientes ORDER BY IdCliente DESC LIMIT 1";
                                resultado = consulta.executeQuery(sql);
                                String ultimoIdCliente = "";
                                if (resultado.next()) {
                                    ultimoIdCliente = resultado.getString("IdCliente");
                                }

                                // Incrementar el ID Cliente
                                int ultimoNumero = Integer.parseInt(ultimoIdCliente.substring(3));
                                int nuevoNumero = ultimoNumero + 1;
                                String nuevoIdCliente = String.format("CLI%05d", nuevoNumero);
                        %>

                        <form method="post" action="procesarRegistro2.jsp">
                            <div class="form-group">
                                <label for="idCliente">ID Asignado:</label>
                                <input type="text" class="form-control" id="idCliente" name="idCliente" value="<%= nuevoIdCliente %>" readonly>
                            </div>
                            <div class="form-group">
                                <label for="apellidos">Apellidos:</label>
                                <input type="text" class="form-control" id="apellidos" name="apellidos" required>
                            </div>
                            <div class="form-group">
                                <label for="nombres">Nombres:</label>
                                <input type="text" class="form-control" id="nombres" name="nombres" required>
                            </div>
                            <div class="form-group">
                                <label for="direccion">Dirección:</label>
                                <input type="text" class="form-control" id="direccion" name="direccion" required>
                            </div>
                            <div class="form-group">
                                <label for="fechaNacimiento">Fecha de Nacimiento:</label>
                                <input type="date" class="form-control" id="fechaNacimiento" name="fechaNacimiento" required>
                            </div>
                            <div class="form-group">
                                <label for="sexo">Sexo:</label>
                                <select class="form-control" id="sexo" name="sexo" required>
                                    <option value="M">Masculino</option>
                                    <option value="F">Femenino</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="correo">Correo Electrónico:</label>
                                <input type="email" class="form-control" id="correo" name="correo" required>
                            </div>
                            <div class="form-group">
                                <label for="password">Contraseña:</label>
                                <input type="password" class="form-control" id="password" name="password" required>
                            </div>
                             <div class="form-group">
                                <label for="tipoUsuario">Tipo de Usuario:</label>
                                <select class="form-control" id="tipoUsuario" name="tipoUsuario" required>
                                    <option value="user">Cliente</option>
                                    <option value="admin">Administrador</option>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-primary btn-register">Registrar</button>
                        </form>
                        <%
                            } catch (Exception e) {
                                e.printStackTrace();
                            } finally {
                                // Cerrar la conexión y liberar recursos
                                try {
                                    if (resultado != null) resultado.close();
                                    if (consulta != null) consulta.close();
                                    if (conexion != null) conexion.close();
                                } catch (SQLException ex) {
                                    ex.printStackTrace();
                                }
                            }
                        %>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
