---------------------------------------
-- Base de datos : tienda2024
-- Autor : Renato Gomez
---------------------------------------
create DATABASE tienda2024;
use tienda2024;

-- Tabla : Categorias
DROP TABLE IF EXISTS Categorias;
CREATE TABLE Categorias(
    IdCategoria CHAR(6) NOT NULL,
    Descripcion VARCHAR(50) NOT NULL,
    Imagen VARCHAR(50) NOT NULL,
    Estado CHAR(1) NOT NULL,
    PRIMARY KEY (IdCategoria),
    CHECK(Estado IN ('0','1'))
);

-- Insertar filas en la tabla Categorias
INSERT INTO Categorias VALUES('CAT001','CATERING','catering.jpg','1');
INSERT INTO Categorias VALUES('CAT002','TORTAS','tortas.jpg','1');
INSERT INTO Categorias VALUES('CAT003','PORCIONES','porciones.jpg','1');
INSERT INTO Categorias VALUES('CAT004','HELADOS','helados.jpg','1');
INSERT INTO Categorias VALUES('CAT005','DESAYUNOS','desayunos.jpg','1');
INSERT INTO Categorias VALUES('CAT006','BEBIDAS','bebidas.jpg','1');

-- Tabla : Productos
DROP TABLE IF EXISTS Productos;
CREATE TABLE Productos(
    IdProducto CHAR(8) NOT NULL,
    IdCategoria CHAR(6) NOT NULL,
    Descripcion VARCHAR(50) NOT NULL,
    PrecioUnidad DECIMAL NOT NULL,
    Stock INT NOT NULL,
    Imagen VARCHAR(50) NOT NULL,
    Estado CHAR(1) NOT NULL,
    PRIMARY KEY(IdProducto),
    FOREIGN KEY(IdCategoria) REFERENCES Categorias(IdCategoria),
    CHECK(PrecioUnidad > 0),
    CHECK(Stock > 0),
    CHECK(Estado IN ('0','1'))
);

-- Insertar filas en la tabla Productos
INSERT INTO Productos VALUES('PRO00001','CAT001','Petipollo Box',
60,100,'petipollo.jpg','1');
INSERT INTO Productos VALUES('PRO00002','CAT001','Crossanints Box',
60,100,'crossaints.jpg','1');
INSERT INTO Productos VALUES('PRO00003','CAT001','Box Reunidos',
150,100,'boxreunidos.jpg','1');
INSERT INTO Productos VALUES('PRO00004','CAT001','Alfajores Box',
60,100,'alfajores.jpg','1');

INSERT INTO Productos VALUES('PRO00005','CAT002','Torta de Chocolate',
45,100,'torta_de_chocolate.jpg','1');
INSERT INTO Productos VALUES('PRO00006','CAT002','Red Velvet',
45,100,'red_velvet.jpg','1');
INSERT INTO Productos VALUES('PRO00007','CAT002','Carrot Cake',
50,100,'carrot_cake.jpg','1');
INSERT INTO Productos VALUES('PRO00008','CAT002','Blue Velvet',
50,100,'blue_velvet.jpg','1');

INSERT INTO Productos VALUES('PRO00009','CAT003','Porcion Torta de Chocolate',
12,100,'porcion_tortadechocolate.jpg','1');
INSERT INTO Productos VALUES('PRO00010','CAT003','Porcion Red Velvet',
13,100,'red_velvet_porcion.jpg','1');
INSERT INTO Productos VALUES('PRO00011','CAT003','Porcion Carrot Cake',
15,100,'porcion_carrotcake.jpg','1');
INSERT INTO Productos VALUES('PRO00012','CAT003','Porcion Blue Velvet',
13,100,'porcion_blue_velvet.jpg','1');

-- CATEGORIAS HELADOS / DESAYUNOS / BEBIDAS

INSERT INTO Productos VALUES('PRO00013','CAT004','Helado Chocolate Amoroso',
20,100,'helado_choco_amoroso.jpg','1');
INSERT INTO Productos VALUES('PRO00014','CAT004','Helado Fresa Coqueta',
23,100,'helado_fresa_coqueta.jpg','1');
INSERT INTO Productos VALUES('PRO00015','CAT004','Helado Mango Travieso',
22,100,'helado_mango_travieso.jpg','1');
INSERT INTO Productos VALUES('PRO00016','CAT004','Helado Vainilla Codiciada',
20,100,'helado_vainilla_codiciada.jpg','1');

INSERT INTO Productos VALUES('PRO00017','CAT005','Combo Mayo Desayuno',
20,100,'combo_verano_desayuno.jpg','1');
INSERT INTO Productos VALUES('PRO00018','CAT005','Ensalada De Frutas',
13,100,'ensalada_de_frutas.jpg','1');
INSERT INTO Productos VALUES('PRO00019','CAT005','Tostadas Francesas',
18,100,'tostadas_francesas.jpg','1');
INSERT INTO Productos VALUES('PRO00020','CAT005','Tostos De Palta',
15,100,'toston-de-palta.jpg','1');

INSERT INTO Productos VALUES('PRO00021','CAT006','Limonada Frozen',
12,100,'limonada_frozen.jpg','1');
INSERT INTO Productos VALUES('PRO00022','CAT006','Limonada Frutos Rojos',
12,100,'limonade_de_frutos_rojos.jpg','1');
INSERT INTO Productos VALUES('PRO00023','CAT006','Limonada De Maracuya',
9,100,'limonade_de_maracuya.jpg','1');
INSERT INTO Productos VALUES('PRO00024','CAT006','Purple Limonade',
13,100,'purple_limonade.jpg','1');

-- Tabla : Clientes
DROP TABLE IF EXISTS Clientes;
CREATE TABLE Clientes(
    IdCliente CHAR(8) NOT NULL,
    Apellidos VARCHAR(50) NOT NULL,
    Nombres VARCHAR(50) NOT NULL,
    Direccion VARCHAR(50) NOT NULL,
    FechaNacimiento DATE NOT NULL,
    Sexo CHAR(1) NOT NULL,
    Correo VARCHAR(50) NOT NULL,
    Password VARCHAR(50) NOT NULL,
    Estado CHAR(1) NOT NULL,
    TipoUsuario VARCHAR(10) NOT NULL,
    PRIMARY KEY(IdCliente),
    CHECK(Sexo IN ('M','F')),
    CHECK(Estado IN ('0','1')),
    CHECK(TipoUsuario IN ('user', 'admin'))
);

INSERT INTO Clientes VALUES('CLI00001','RIVERA RIOS','JUAN CARLOS',
'AV.LIMA 1234-CERCADO','1990-05-01','M','jrivera@gmail.com','1234','1','user');
INSERT INTO Clientes VALUES('CLI00002','TORRES DURAN','CLAUDIA',
'AV.PRIMAVERA 1234-SURCO','1991-07-11','F','ctorres@gmail.com','1234','1','user');
INSERT INTO Clientes VALUES('CLI00003','VILLAR RAMOS','WALTER ISMAEL',
'AV.ARENALES 1525-LINCE','1989-12-01','M','wvillar@gmail.com','1234','1','user');
INSERT INTO Clientes VALUES('CLI00004','GOMEZ NIEVES','CHRISTIAN RENATO',
'AV.LIMA 1234-LIMA','2001-05-12','M','renatog@gmail.com','1234','1','admin');
INSERT INTO Clientes VALUES('CLI00005','ODICIO RONDAN','ARIANA',
'AV.TINGO MARIA 1234-BREÑA','2002-08-30','F','arianao@gmail.com','1234','1','admin');

SELECT * FROM Clientes;

-- Tabla : Ventas
DROP TABLE IF EXISTS Ventas;
CREATE TABLE Ventas(
    IdVenta CHAR(10) NOT NULL,
    IdCliente CHAR(8) NOT NULL,
    FechaVenta DATE NOT NULL,
    MontoTotal DECIMAL NOT NULL,
    Estado CHAR(1) NOT NULL,
    PRIMARY KEY(IdCliente,IdVenta),
    CHECK(MontoTotal > 0),

    CHECK(Estado IN ('0','1'))
);

-- Tabla : Detalle
DROP TABLE IF EXISTS Detalle;
CREATE TABLE Detalle(
    IdVenta CHAR(10) NOT NULL,
    IdProducto CHAR(8) NOT NULL,
    Cantidad INT NOT NULL,
    PrecioUnidad DECIMAL NOT NULL,
    Estado CHAR(1) NOT NULL,
    PRIMARY KEY(IdVenta, IdProducto),
    CHECK(Cantidad > 0),
    CHECK(PrecioUnidad >0),
    CHECK(Estado IN ('0','1'))
);

CREATE INDEX idx_idventa ON Ventas(IdVenta);
-- PROCEDIMIENTOS ALMACENADOS

-- Store Procedure : 	ListarCategorias
drop procedure if exists ListarCategorias;
DELIMITER @@
CREATE PROCEDURE ListarCategorias()
BEGIN
	SELECT * FROM Categorias;
END @@
DELIMITER ;

CALL ListarCategorias();

-- Store ´rocedure : InfoProducto
drop procedure if exists InfoProducto;
delimiter @@
CREATE PROCEDURE InfoProducto(iDProd CHAR(8))
BEGIN
	SELECT * FROM Productos Where IdProducto=IdProd;
END @@
delimiter ;

CALL InfoProducto('PRO00003');

-- Store Procedure : ListarProductos
DROP PROCEDURE IF EXISTS ListarProductos;
DELIMITER @@
CREATE PROCEDURE ListarProductos()
BEGIN
    SELECT * FROM Productos;
END @@
DELIMITER;

-- Llamada al procedimiento almacenado
CALL ListarProductos()

-- Store Procedure : ListarProductosXCategoria
DROP PROCEDURE IF EXISTS ListarProductosXCategoria;
DELIMITER //
CREATE PROCEDURE ListarProductosXCategoria(IdCat CHAR(6))
BEGIN
    SELECT * FROM Productos
    WHERE IdCategoria = IdCat;
END //
DELIMITER;

CALL ListarProductosXCategoria('CAT001');

-- Store Procedure : InfoCliente
DROP PROCEDURE IF EXISTS InfoCliente;
DELIMITER @@
CREATE PROCEDURE InfoCliente(IdCli CHAR(8))
BEGIN
    SELECT * FROM Clientes
    WHERE IdCliente = IdCli;
END @@
DELIMITER;

CALL InfoCliente('CLI00005');

-- Store Procedure : InsertaVenta
DROP PROCEDURE IF EXISTS InsertaVenta;
DELIMITER @@
CREATE PROCEDURE InsertaVenta(
    IdVenta CHAR(10),
    IdCliente CHAR(8),
    FechaVenta DATE,
    MontoTotal DECIMAL,
    Estado CHAR(1)
)
BEGIN
    INSERT INTO Ventas VALUES(IdVenta,IdCliente,FechaVenta,MontoTotal,Estado);
END @@
DELIMITER;

-- Store Procedure : InsertaDetalle
DROP PROCEDURE InsertaDetalle;
DELIMITER @@
CREATE PROCEDURE InsertaDetalle(
    IdVenta CHAR(10),
    IdProducto CHAR(8),
    Cantidad INT,
    PrecioUnidad DECIMAL,
    Estado CHAR(1)
)
BEGIN
    INSERT INTO Detalle VALUES(IdVenta,IdProducto,Cantidad,PrecioUnidad,Estado);
END @@
DELIMITER ;

-- Store Procedure : SuprimirDetalle
drop procedure if exists SuprimirDetalle;
delimiter @@
create procedure SuprimirDetalle(Id CHAR(10),
	IdProd CHAR(8),Cant int, PrecUni decimal(10,0), Est CHAR(1))
begin
	delete from detalle where IdVenta = Id;
end @@
delimiter ;
SELECT *FROM clientes;
SELECT * FROM ventas;
SELECT * FROM detalle;