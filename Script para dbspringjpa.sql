drop database if exists dbspringjpa;

create database dbspringjpa;

use dbspringjpa;

create table personas(
	idpersona int not null primary key auto_increment,
    nombre varchar(20) not null,
    apellido varchar(40),
    direccion varchar(60)
    );


create table pais(
	idpais int auto_increment not null primary key,
    pais varchar(40)
    );

insert into pais (pais)
values ("Argentina"),("Brasil"),("Colombia"),("Uruguay"),("Paraguay"),("Ecuador");

alter table personas
add idpais int not null;

alter table personas
add constraint perspais foreign key (idpais) references pais(idpais);

insert into personas (nombre,apellido,direccion)
values ("Claudio","Medina","Villegas 2056",1),("Gisele","Suarez","Serrano 250",1),("Jose","Cruz","Corrientes 5678",2);


select * from personas;

select * from pais;
select * from personas;


CREATE TABLE `usuarios` (
  `idusuario` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(40) NOT NULL,
  `password` varchar(60) NOT NULL,
  `email` varchar(60) NOT NULL,
  `habilitado` int,
  `fechaIngreso` date,
  PRIMARY KEY (`idusuario`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `roles` (
  `idrol` int(11) NOT NULL AUTO_INCREMENT,
  `rol` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`idrol`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `usuarioroles` (
  `idusuario` int(11) NOT NULL,
  `idrol` int (11) NOT NULL,
  UNIQUE KEY `Usuario_Rol_UNIQUE` (`idusuario`,`idrol`),
  KEY `fk_Usuarios1_idx` (`idusuario`),
  KEY `fk_Roles1_idx` (`idrol`),
  CONSTRAINT `fk_Usuarios1` FOREIGN KEY (`idusuario`) REFERENCES `usuarios` (`idusuario`),
  CONSTRAINT `fk_Perfiles1` FOREIGN KEY (`idrol`) REFERENCES `roles` (`idrol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


INSERT INTO roles
VALUES (1, 'administrador');

INSERT INTO roles
VALUES (2, 'editor');

insert into roles
values (3,'visitante');

select * from roles;

select * from usuarios;
select * from usuarioroles;
