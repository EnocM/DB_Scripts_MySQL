drop database if exists dbhibernate;

create database dbhibernate;

use dbhibernate;

create table persona(
	idpersona int not null auto_increment primary key,
    nombre varchar (20) not null,
    apellido varchar (20) not null,
    direccion varchar(40) not null
    );

