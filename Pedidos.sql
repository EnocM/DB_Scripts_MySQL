drop database if exists Pedidos;

create database Pedidos;

use Pedidos;

create table Cliente(
	idpersona int not null auto_increment primary key,
    nombre varchar(40) not null,
    dni int not null,
    idorden int not null
    );
    
create table Orden(
	idorden int not null auto_increment primary key,
	creacion date not null,
    envio date not null,
    iditem int not null
    );
    
create table DetalleOrden(
	iditem  int not null auto_increment primary key,
    precioUnitario float not null,
    cantidad int not null,
    idNotebook int not null
    );
    
create table Notebook(
	idNotebook  int not null auto_increment primary key,
    marca varchar(30) not null,
    modelo varchar (30),
    procesador varchar(30) not null,
    tamañoDisco float not null
    );

    
alter table Cliente
add constraint cliOrd foreign key (idorden) references Orden (idorden);

alter table Orden
add constraint OrdDet foreign key (iditem) references DetalleOrden (iditem);

alter table DetalleOrden
add constraint DetNote foreign key (idNotebook) references Notebook (idNotebook);

    

    
