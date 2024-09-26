package modelo;

public class Ventas {
private String IdVenta;
private String IdCliente;
private String FechaVenta;
private double MontoTotal;
private char Estado;
public Ventas(String idVenta, String idCliente, String fechaVenta, double montoTotal, char estado) {
	super();
	IdVenta = idVenta;
	IdCliente = idCliente;
	FechaVenta = fechaVenta;
	MontoTotal = montoTotal;
	Estado = estado;
}
public Ventas() {
	
}
public String getIdVenta() {
	return IdVenta;
}
public void setIdVenta(String idVenta) {
	IdVenta = idVenta;
}
public String getIdCliente() {
	return IdCliente;
}
public void setIdCliente(String idCliente) {
	IdCliente = idCliente;
}
public String getFechaVenta() {
	return FechaVenta;
}
public void setFechaVenta(String fechaVenta) {
	FechaVenta = fechaVenta;
}
public double getMontoTotal() {
	return MontoTotal;
}
public void setMontoTotal(double montoTotal) {
	MontoTotal = montoTotal;
}
public char getEstado() {
	return Estado;
}
public void setEstado(char estado) {
	Estado = estado;
}


}
