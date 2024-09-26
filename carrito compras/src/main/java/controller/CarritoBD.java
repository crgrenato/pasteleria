package controller;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import modelo.Categorias;
import modelo.Clientes;
import modelo.Detalle;
import modelo.Productos;
import modelo.Ventas;

public class CarritoBD {
    // Campos o atributos
    private String Driver = "com.mysql.cj.jdbc.Driver";
    private String URL = "jdbc:mysql://localhost:3306/tienda2024";
    private String Usuario = "root";
    private String Password = "Ariana#2002";

    private Connection Cn;
    private Statement Cmd;
    private CallableStatement Stmt;
    private ResultSet Rs;

    private List<Categorias> ListaC;
    private List<Productos> ListaP;

    // Método Constructor
    public CarritoBD() {
        try {
            Class.forName(Driver);
            Cn = DriverManager.getConnection(URL, Usuario, Password);
        } catch (Exception e) {
            System.out.println("ERROR EN LA CONEXION:" + e.getMessage());
        }
    }

    // Método ListarCategorias
    public List<Categorias> ListarCategorias(){
        String SQL = "CALL ListarCategorias()";
        ListaC = new ArrayList<Categorias>();
        try {
            Stmt = Cn.prepareCall(SQL);
            Rs = Stmt.executeQuery();
            while(Rs.next()) {
                ListaC.add(new Categorias(Rs.getString("IdCategoria"), 
                                    Rs.getString("Descripcion"),
                                    Rs.getString("Imagen"),
                                    Rs.getString("Estado").charAt(0)));
            }
            Rs.close();
        } catch (Exception e) {
            System.out.println("ERROR EN CARGA DE TABLA CATEGORIAS :" + e.getMessage());
        }
        return ListaC;
    }

 	// Método ListarProductos
	public List<Productos> ListarProductos(String IdCat){
		String SQL = "CALL ListarProductosXCategoria(?)";
		ListaP = new ArrayList<Productos>();
		try {
				Stmt = Cn.prepareCall(SQL);
				Stmt.setString(1, IdCat);
				Rs = Stmt.executeQuery();
				while(Rs.next()) {
					ListaP.add(new Productos(Rs.getString("IdProducto"), 
											Rs.getString("IdCategoria"),
											Rs.getString("Descripcion"),
											Rs.getDouble("PrecioUnidad"),
											Rs.getInt("Stock"),
											Rs.getString("Imagen"),
											Rs.getString("Estado").charAt(0)));
				}
				Rs.close();
		} catch (Exception e) {
				System.out.println("ERROR EN CARGA DE TABLA PRODUCTOS :" + e.getMessage());
		}
		return ListaP;
	}
    
    
 // Método ListarProductos2
    public List<Productos> ListarProductos2(){
        String SQL = "CALL ListarProductos()"; // Llama al procedimiento almacenado sin pasar un parámetro
        ListaP = new ArrayList<Productos>();
        try {
            Stmt = Cn.prepareCall(SQL);
            Rs = Stmt.executeQuery();
            while(Rs.next()) {
                ListaP.add(new Productos(
                    Rs.getString("IdProducto"), 
                    Rs.getString("IdCategoria"),
                    Rs.getString("Descripcion"),
                    Rs.getDouble("PrecioUnidad"),
                    Rs.getInt("Stock"),
                    Rs.getString("Imagen"),
                    Rs.getString("Estado").charAt(0)
                ));
            }
            Rs.close();
        } catch (Exception e) {
            System.out.println("ERROR EN CARGA DE TABLA PRODUCTOS :" + e.getMessage());
        }
        return ListaP;
    }

    	// Método InfoProducto
	public Productos InfoProducto(String IdPro) {
		String SQL = "CALL InfoProducto(?)";
		Productos ObjP = null;
		try {
				Stmt = Cn.prepareCall(SQL);
				Stmt.setString(1, IdPro);
				Rs = Stmt.executeQuery();
				if(Rs.next()) {
					ObjP = new Productos(Rs.getString("IdProducto"), 
										Rs.getString("IdCategoria"),
										Rs.getString("Descripcion"),
										Rs.getDouble("PrecioUnidad"),
										Rs.getInt("Stock"),
										Rs.getString("Imagen"),
										Rs.getString("Estado").charAt(0));
				}
				Rs.close();
		} catch (Exception e) {
			System.out.println("ERROR EN CARGA DE TABLA PRODUCTOS :" + e.getMessage());
		}
		return ObjP;
	}

    // Método para listar clientes
    public List<Clientes> ListarClientes() {
        String SQL = "SELECT * FROM Clientes";
        List<Clientes> listaClientes = new ArrayList<>();
        try {
            Cmd = Cn.createStatement();
            Rs = Cmd.executeQuery(SQL);
            while(Rs.next()) {
                Clientes cliente = new Clientes(
                    Rs.getString("IdCliente"),
                    Rs.getString("Apellidos"),
                    Rs.getString("Nombres"),
                    Rs.getString("Direccion"),
                    Rs.getString("FechaNacimiento"),
                    Rs.getString("Sexo").charAt(0),
                    Rs.getString("Correo"),
                    Rs.getString("Password"),
                    Rs.getString("Estado").charAt(0),
                    Rs.getString("TipoUsuario")
                );
                listaClientes.add(cliente);
            }
            Rs.close();
        } catch (Exception e) {
            System.out.println("ERROR AL OBTENER CLIENTES: " + e.getMessage());
        }
        return listaClientes;
    }

    // Validar IdUsuario y Password
    public boolean VerificaUsuario(String IdCliente,String Password)
    { 
        boolean estado = false;
        String SQL = "SELECT * FROM Clientes WHERE IdCliente='"+ IdCliente+"' AND Password='"+Password+"'";
        try {
            this.Cmd = this.Cn.createStatement();
            this.Rs = this.Cmd.executeQuery(SQL);
            if(this.Rs.next()){
                estado = true;
            }
        } catch (Exception e) {
            System.out.println("***ERROR:"+e.getMessage());
        }
        return estado;
    }
    
    // Devolver Informacion de Cliente
    public Clientes InfoCliente(String IdCliente)
    { 
        Clientes ObjP = null;      
        try {
            // Establece el nombre del SP a invocar
            Stmt = Cn.prepareCall("CALL InfoCliente(?)");
            // Asigna el valor del unico parametro del SP
            Stmt.setString(1, IdCliente);
            // Ejecuta el SP y almacena los resultados
            Rs = Stmt.executeQuery();
            // Si recupero filas guardalo en un objeto de tipo Clientes
            if(Rs.next()){
                ObjP = new Clientes(
                    Rs.getString("IdCliente"),
                    Rs.getString("Apellidos"),
                    Rs.getString("Nombres"),
                    Rs.getString("Direccion"),
                    Rs.getString("FechaNacimiento"),
                    Rs.getString("Sexo").charAt(0),
                    Rs.getString("Correo"),
                    Rs.getString("Password"),
                    Rs.getString("Estado").charAt(0),
                    Rs.getString("TipoUsuario")
                );
            }

        } catch (Exception e) {
            System.out.println("***ERROR:"+e.getMessage());
        }
        return ObjP;  
    }

    // Metodo para insertar filas en la tabla ventas
    public void InsertarVenta(Ventas ObjV)
    {
        try {
            Stmt = this.Cn.prepareCall("CALL InsertaVenta(?,?,?,?,?)");
            Stmt.setString(1, ObjV.getIdVenta());
            Stmt.setString(2, ObjV.getIdCliente());
            Stmt.setString(3, ObjV.getFechaVenta());
            Stmt.setDouble(4, ObjV.getMontoTotal());
            Stmt.setString(5, ObjV.getEstado()+"");
            Stmt.executeUpdate(); // INSERT, DELETE o UPDATE
        } catch (Exception e) {
            System.out.println("***ERROR:"+e.getMessage());        
        }
    }
    
    // Método para insertar filas en la tabla detalle y actualizar el stock de productos
    public void InsertarDetalle(Detalle ObjD) {
        try {
            // Insertar detalles de la venta
            Stmt = this.Cn.prepareCall("CALL InsertaDetalle(?,?,?,?,?)");
            Stmt.setString(1, ObjD.getIdVenta());
            Stmt.setString(2, ObjD.getIdProducto());
            Stmt.setInt(3, ObjD.getCantidad());
            Stmt.setDouble(4, ObjD.getPrecioUnidad());
            Stmt.setString(5, ObjD.getEstado()+"");
            Stmt.executeUpdate();

            // Actualizar el stock del producto
            Stmt = this.Cn.prepareCall("UPDATE Productos SET Stock = Stock - ? WHERE IdProducto = ?");
            Stmt.setInt(1, ObjD.getCantidad());
            Stmt.setString(2, ObjD.getIdProducto());
            Stmt.executeUpdate();
        } catch (Exception e) {
            System.out.println("***ERROR:"+e.getMessage());  
        }
    }
    
    // Metodo para devolver el numero de filas de un tabla
    public int NumeroFilas(String NombreTabla)
    { 
        int filas = 0;
        String SQL = "SELECT Count(*) FROM "+NombreTabla;
        try {
            this.Cmd = this.Cn.createStatement();
            this.Rs = this.Cmd.executeQuery(SQL);
            if(this.Rs.next()){
                filas = Rs.getInt(1);
            }
        } catch (Exception e) {
           System.out.println("***ERROR:"+e.getMessage());   
        }
        return filas;  
    }
    
 // Método para listar todas las ventas
    public List<Ventas> ListarVentas() {
        String SQL = "SELECT * FROM Ventas";
        List<Ventas> listaVentas = new ArrayList<>();
        try {
            Cmd = Cn.createStatement();
            Rs = Cmd.executeQuery(SQL);
            while(Rs.next()) {
                Ventas venta = new Ventas(
                    Rs.getString("IdVenta"),
                    Rs.getString("IdCliente"),
                    Rs.getString("FechaVenta"),
                    Rs.getDouble("MontoTotal"),
                    Rs.getString("Estado").charAt(0)
                );
                listaVentas.add(venta);
            }
            Rs.close();
        } catch (Exception e) {
            System.out.println("ERROR AL OBTENER VENTAS: " + e.getMessage());
        }
        return listaVentas;
    }

    // Método para eliminar un cliente y sus registros relacionados
    public boolean eliminarClienteYRegistros(String idCliente) {
        boolean eliminado = false;
        try {
            // Eliminar registros relacionados con el cliente en otras tablas
            eliminarRegistrosCliente(idCliente);
            
            // Eliminar el cliente de la tabla Clientes
            String SQL = "DELETE FROM Clientes WHERE IdCliente = ?";
            PreparedStatement pstmt = Cn.prepareStatement(SQL);
            pstmt.setString(1, idCliente);
            int rowsAffected = pstmt.executeUpdate();
            
            // Verificar si se eliminó correctamente
            if (rowsAffected > 0) {
                eliminado = true;
            }
        } catch (SQLException e) {
            System.out.println("Error al eliminar cliente y registros: " + e.getMessage());
        }
        return eliminado;
    }
 // Método para actualizar los datos de un cliente en la base de datos
    public boolean ActualizarCliente(Clientes clienteEditado) {
        String SQL = "UPDATE Clientes SET Apellidos = ?, Nombres = ?, Direccion = ?, FechaNacimiento = ?, Sexo = ?, Correo = ?, TipoUsuario = ? WHERE IdCliente = ?";
        try {
            PreparedStatement pstmt = Cn.prepareStatement(SQL);
            pstmt.setString(1, clienteEditado.getApellidos());
            pstmt.setString(2, clienteEditado.getNombres());
            pstmt.setString(3, clienteEditado.getDireccion());
            pstmt.setString(4, clienteEditado.getFechaNacimiento());
            pstmt.setString(5, String.valueOf(clienteEditado.getSexo())); // Convertir char a String
            pstmt.setString(6, clienteEditado.getCorreo());
            pstmt.setString(7, clienteEditado.getTipoUsuario());
            pstmt.setString(8, clienteEditado.getIdCliente());
            
            int rowsAffected = pstmt.executeUpdate();
            
            if (rowsAffected > 0) {
                return true; // La actualización fue exitosa
            }
        } catch (SQLException e) {
            System.out.println("Error al actualizar cliente: " + e.getMessage());
        }
        return false; // La actualización no fue exitosa
    }

    

    // Método privado para eliminar registros relacionados con el cliente en otras tablas
    private void eliminarRegistrosCliente(String idCliente) throws SQLException {
        // Aquí debes incluir la lógica para eliminar registros relacionados con el cliente en otras tablas
        // Por ejemplo, podrías ejecutar consultas SQL para eliminar registros en las tablas Detalle, Ventas, etc.
        // Recuerda adaptar esta lógica según la estructura de tu base de datos y la relación entre tablas.
    }
}
