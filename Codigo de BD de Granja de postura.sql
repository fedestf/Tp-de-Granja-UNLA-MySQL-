drop schema if exists granja;

create schema granja;

use granja;


drop table if exists cantidad;
create table cantidad(
	idCantidad int not null auto_increment,
	cantidad int,
primary key(idCantidad)
);


drop table if exists domicilio;
create table domicilio(
	idDomicilio int not null auto_increment,
	calle varchar(45),
	numero int,
	localidad varchar(45),
	provincia varchar(45),
primary key(idDomicilio)
);


drop table if exists cabaña;
create table cabaña(
	cuit int not null auto_increment,
	razonSocial varchar(45),
	domicilio_idDomicilio int,
primary key(cuit),
foreign key (domicilio_idDomicilio) references domicilio (idDomicilio)
    on delete no action
    on update no action
);


drop table if exists genetica;
create table genetica(
	idGenetica varchar(5) not null,
	nombre varchar(45),
	cabaña_cuit int,
primary key (idGenetica),
	foreign key (cabaña_cuit) references cabaña (cuit)
    on delete no action
    on update no action
);


drop table if exists plantel;
create table plantel(
	idPlantel varchar(5) not null,
	nombre varchar(45),
	edadEntrada int,
	fechaEntrada date,
	genetica_idGenetica varchar(5) not null, 
primary key(idPlantel),
foreign key (genetica_idGenetica) references genetica(idGenetica) 
    on delete no action
    on update no action
);


drop table if exists galpon;
create table galpon(
	idGalpon int not null auto_increment,
    cantidad int,
	plantel_idPlantel varchar(5),
primary key(idGalpon),
foreign key (plantel_idPlantel) references plantel (idPlantel) 
    on delete no action
    on update no action
);


drop table if exists informe;
create table informe(
	idInforme int not null auto_increment,
	fecha date,
	cantHuevos int,
	cantMuertas int,
	tipoAlimento varchar(5),
	cantAlimento int,
	novedades varchar(80),
	galpon_idGalpon int,
primary key (idInforme),
foreign key (galpon_idGalpon) references galpon (idGalpon)
    on delete no action
    on update no action
);


drop table if exists cliente;
create table cliente(
	idCliente int not null auto_increment,
	nombre varchar(45),
	domicilio_idDomicilio int,
primary key (idCliente),
foreign key (domicilio_idDomicilio) references domicilio (idDomicilio)
    on delete no action
    on update no action
);


drop table if exists factura;
create table factura(
	idFactura int not null auto_increment,
	fecha date,
	cabaña_cuit int,
primary key (idFactura),
foreign key (cabaña_cuit) references cabaña (cuit)
    on delete no action
    on update no action
);


drop table if exists producto;
create table producto(
	idProducto varchar(5) not null,
	nombre varchar(45),
	precio float,
	cantidad_idCantidad int,
primary key (idProducto),
foreign key (cantidad_idCantidad) references cantidad (idCantidad)
    on delete no action
    on update no action
);


drop table if exists producto_has_Factura;
create table producto_has_Factura(
	producto_idProducto varchar(5) not null,
	factura_idFactura int not null,
foreign key (producto_idProducto) references producto (idproducto),
foreign key (factura_idFactura) references factura (idFactura)
);


