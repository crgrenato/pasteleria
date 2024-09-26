<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="controller.CarritoBD" %>
<%@ page import="modelo.Clientes" %>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LOGIN</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<!-- Agrega Bootstrap Icons en lugar de Font Awesome -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css" rel="stylesheet">
<style>
    /* Estilo personalizado para el color de fondo rosa suave */
    body {
        background-image: url('fondo.jpg'); /* Ruta relativa a la imagen de fondo */
        background-size: cover; /* Ajustar la imagen de fondo al tamaño de la ventana del navegador */
    }
    

    /* Estilo personalizado para el botón rosado suave */
    .btn-pink {
        color: #fff;
        background-color: #ffc0cb;
        border-color:  #d9acb5;
    }

    .btn-pink:hover {
        background-color: #ffa7b9;
        border-color: #ffa7b9;
    }

     /* Estilo para el rectángulo con bordes curvos alrededor del texto */
    .carrito-titulo {
        background-color: #c8e0ff; /* Color celeste suave */
        padding: 8px 8px; /* Espaciado interno */
        border-radius: 18px; /* Bordes curvos */
        text-align: center; /* Alineación del texto */
        margin-bottom: 20px; /* Espacio inferior */
        font-family: 'EngraversGothic BT', sans-serif; /* Utilizar la fuente "Great Vibes" */
        font-size: 60px; /* Tamaño de la fuente */
        font-weight: bold; /* Negrita */
        color:  #542c34; /* Cambiar el color del texto a rosa */
    }

    /* Estilo para la tabla con bordes redondeados */
    .card {
        border-radius: 20px; /* Bordes redondeados */
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* Sombra ligera */
    }
    
    /* Estilo para la imagen */
    .slogan-img {
        width: 150px; /* Ancho de la imagen */
        height: auto; /* Altura automática */
        pointer-events: none; /* Bloquear la interacción con la imagen */
    }
    
    /* Estilo para el contenedor principal */
    .custom-container {
        width: 800px; /* Ancho del contenedor */
        height: 600px; /* Alto del contenedor */
        margin: 50px auto; /* Margen superior e inferior automático, centrando horizontalmente */
        padding: 20px; /* Espaciado interno */
    }
    a#registrarse-link {
    color: #673ab7;
    font-weight: bold;
    text-decoration: none; /* Eliminamos el subrayado predeterminado */
    }

    a#registrarse-link:hover {
    text-decoration: underline; /* Añadimos el subrayado al pasar el mouse */
    }
    
    
</style>
</head>
<body>
<%
    String errorMessage = "";
    if (request.getMethod().equals("POST")){
        
        String idCliente = request.getParameter("idCliente");
        String password = request.getParameter("password");
        String tipoUsuario = request.getParameter("tipousuario");
        
        CarritoBD carritoBD = new CarritoBD();
        boolean usuarioValido = carritoBD.VerificaUsuario(idCliente, password);
        Clientes ObjP = carritoBD.InfoCliente(idCliente);
        
        if(usuarioValido) {
            // Si las credenciales son válidas, obtener información del cliente
            Clientes cliente = carritoBD.InfoCliente(idCliente);
            
            // Crear una sesión y guardar la información del cliente
            HttpSession sesion = request.getSession();
            session.setAttribute("idCliente", idCliente);
            
            if (ObjP.getTipoUsuario().equals("user")) {
                response.sendRedirect("index.jsp");
            } else if (ObjP.getTipoUsuario().equals("admin")) {
                response.sendRedirect("admin.jsp");
            } else {
                // Si el tipo de usuario no es válido, mostrar un mensaje de error
                errorMessage = "Tipo de usuario inválido.";
            }
        } else {
            // Si las credenciales no son válidas, mostrar un mensaje de error
            errorMessage = "El ID de cliente o contraseña es incorrecto.";
        }
    }
%>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card">
                <div class="carrito-titulo">
                    <img src="slogan.png" alt="Slogan"class="slogan-img">
                    <h1>INICIO DE SESION</h1>
                    
                </div>
                <div class="card-body text-center"> <!-- Agregamos la clase text-center -->
                    <% if (!errorMessage.isEmpty()) { %>
                        <div class="alert alert-danger" role="alert">
                            <%= errorMessage %>
                        </div>
                    <% } %>
                    <form action="" method="post">
                        <div class="mb-3">
                            <label for="idCliente" class="form-label">ID Asignado:</label>
                            <input type="text" class="form-control" id="idCliente" name="idCliente" required>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Password:</label>
                            <div class="input-group"> <!-- Agregamos un grupo de entrada de Bootstrap -->
                                <input type="password" class="form-control" id="password" name="password" required>
                                <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                                    <i id="eyeIcon" class="bi bi-eye"></i> <!-- Icono de ojo -->
                                </button>
                            </div>
                        </div>
                        <!-- Utilizamos la clase personalizada btn-pink para el botón -->
                        <button type="submit" class="btn btn-pink">Ingresar</button>                       
                    </form>
                </div>
                <div class="card-footer text-center">                  
                    <p>Aun no tengo cuenta <a href="registrar.jsp" style="color: #673ab7; font-weight: bold; text-decoration: none;">REGISTRARSE</a></p>
                    
                </div>
                
            </div>
        </div>
    </div>
</div>

<!-- Agregamos el script para mostrar y ocultar la contraseña -->
<script>
    const togglePassword = document.querySelector('#togglePassword');
    const password = document.querySelector('#password');
    const eyeIcon = document.querySelector('#eyeIcon'); // Seleccionamos el icono del ojo

    togglePassword.addEventListener('click', function (e) {
        // Cambia el tipo de entrada de la contraseña para mostrar u ocultar
        const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
        password.setAttribute('type', type);
        // Cambia el icono del ojo entre abierto y cerrado
        if (type === 'password') {
            eyeIcon.classList.remove('bi-eye-slash'); // Quitamos la clase de ojo cerrado
            eyeIcon.classList.add('bi-eye'); // Añadimos la clase de ojo abierto
        } else {
            eyeIcon.classList.remove('bi-eye'); // Quitamos la clase de ojo abierto
            eyeIcon.classList.add('bi-eye-slash'); // Añadimos la clase de ojo cerrado
        }
    });
</script>
</body>
</html>
