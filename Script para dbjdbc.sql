drop database dbjdbc;

create database dbjdbc;

use dbjdbc;

drop table  if exists persona;
create table persona(
	idpersona int not null auto_increment primary key,
    nombre varchar (30) not null,
	apellido varchar (30) not null
    );
    
insert into persona
(nombre,apellido)
values ("Juan","Ramirez"),("Sara","Brunos"),("Noelia","Tripel"),("Misael","Salem"),("Romina","Suarez");

alter table persona
add column direccion varchar(60) after apellido,
add column pais varchar (50) not null;

update persona
set direccion= "Rivadavia";

create table pais(
	paisid int primary key auto_increment,
    nombre varchar(60)
    );

drop table if exists persona; 

create table persona(
	personaid int primary key auto_increment,
    nombre varchar(30) not null,
    apellido varchar(30) not null,
    domicilio varchar(50) not null,
    paisid int,
    foreign key(paisid) references pais(paisid)
    );
    
    update persona
    set domicilio = "Rivadavia";

create table domicilio(
	domicilioId int primary key auto_increment, 
    calle varchar(40) not null, 
	nro int, 
    personaid int,
    foreign key(personaid) references persona(personaid)
    );
		
insert into pais (nombre)
values ("Brasil"),("Alemania"),("Angola"),("Francia"),("Irlanda");

select * from persona;

create table direccion(
	iddireccion int not null primary key auto_increment,
    calle varchar (50) not null,
    nro int not null,
    idcodigo int not null
    );
    
create table codigopostal(
	idcodigo int not null primary key auto_increment,
    codpostal varchar (8)
    );
    
alter table direccion
add constraint dircp foreign key (idcodigo) references codigopostal (idcodigo);


SELECT iddireccion, calle, nro, direccion.idcodigo, codigopostal.codpostal
FROM direccion
inner join codigopostal on direccion.idcodigo = codigopostal.codpostal    
ORDER BY iddireccion;
                                
insert into codigopostal (codpostal)
values ("c1407krt"),("c1414wed"),("c1416usw"),("c1414azd"),("c1405kty"),("c1409mir");
    
select * from direccion;

alter table persona
drop column domicilio;



