package modelo;

public class Detalle {
 private String IdVenta;
 private String IdProducto;
 private int Cantidad;
 private double PrecioUnidad;
 private char Estado;
public Detalle(String idVenta, String idProducto, int cantidad, double precioUnidad, char estado) {
	super();
	IdVenta = idVenta;
	IdProducto = idProducto;
	Cantidad = cantidad;
	PrecioUnidad = precioUnidad;
	Estado = estado;
}
public Detalle() {
	
}
public String getIdVenta() {
	return IdVenta;
}
public void setIdVenta(String idVenta) {
	IdVenta = idVenta;
}
public String getIdProducto() {
	return IdProducto;
}
public void setIdProducto(String idProducto) {
	IdProducto = idProducto;
}
public int getCantidad() {
	return Cantidad;
}
public void setCantidad(int cantidad) {
	Cantidad = cantidad;
}
public double getPrecioUnidad() {
	return PrecioUnidad;
}
public void setPrecioUnidad(double precioUnidad) {
	PrecioUnidad = precioUnidad;
}
public char getEstado() {
	return Estado;
}
public void setEstado(char estado) {
	Estado = estado;
}
 
}
