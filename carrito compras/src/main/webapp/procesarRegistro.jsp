<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Procesar Registro</title>
</head>
<body>
    <h1>Procesar Registro</h1>
    <%!
        // Método para establecer la conexión con la base de datos
        private Connection getConnection() throws SQLException {
            String url = "jdbc:mysql://localhost:3306/tienda2024";
            String username = "root";
            String password = "Ariana#2002";
            return DriverManager.getConnection(url, username, password);
        }

        // Método para generar un nuevo IdCliente automático
        private String generarIdCliente() throws SQLException {
            Connection con = getConnection();
            String query = "SELECT MAX(IdCliente) AS maxId FROM Clientes";
            PreparedStatement pstmt = con.prepareStatement(query);
            ResultSet rs = pstmt.executeQuery();
            String lastId = null;
            if (rs.next()) {
                lastId = rs.getString("maxId");
            }
            pstmt.close();
            con.close();

            // Generar el nuevo IdCliente
            if (lastId == null) {
                return "CLI00001"; // Si no hay clientes en la base de datos
            } else {
                int num = Integer.parseInt(lastId.substring(3)) + 1;
                return "CLI" + String.format("%05d", num);
            }
        }
    %>
    <% 
        // Procesar los datos del formulario
        String idCliente = generarIdCliente();
        String nombres = request.getParameter("nombres");
        String apellidos = request.getParameter("apellidos");
        String direccion = request.getParameter("direccion");
        String fechaNacimiento = request.getParameter("fechaNacimiento");
        String sexo = request.getParameter("sexo");
        String correo = request.getParameter("correo");
        String password = request.getParameter("password");
        String tipoUsuario = request.getParameter("tipoUsuario");

        // Validar que todos los campos del formulario hayan sido completados
        if (nombres != null && apellidos != null && direccion != null && fechaNacimiento != null && sexo != null && correo != null && password != null && tipoUsuario != null) {
            try {
                // Establecer conexión con la base de datos
                Connection con = getConnection();

                // Preparar la consulta SQL para insertar el nuevo cliente
                String query = "INSERT INTO Clientes (IdCliente, Apellidos, Nombres, Direccion, FechaNacimiento, Sexo, Correo, Password, Estado,TipoUsuario) VALUES (?, ?, ?, ?, ?, ?, ?, ?, '1',?)";
                PreparedStatement pstmt = con.prepareStatement(query);
                pstmt.setString(1, idCliente);
                pstmt.setString(2, apellidos);
                pstmt.setString(3, nombres);
                pstmt.setString(4, direccion);
                pstmt.setString(5, fechaNacimiento);
                pstmt.setString(6, sexo);
                pstmt.setString(7, correo);
                pstmt.setString(8, password);
                pstmt.setString(9, tipoUsuario);

                // Ejecutar la consulta
                int rowsAffected = pstmt.executeUpdate();

                // Cerrar la conexión y el PreparedStatement
                pstmt.close();
                con.close();

                // Redirigir 
                if (rowsAffected > 0) {
                    response.sendRedirect("iniciarsesion.jsp");
                } else {
                    out.println("Error al registrar el cliente.");
                }
            } catch (SQLException e) {
                out.println("Error de base de datos: " + e.getMessage());
            }
        } else {
            out.println("Todos los campos son requeridos.");
        }
    %>
</body>
</html>
