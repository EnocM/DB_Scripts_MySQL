drop database if exists prueba;

create database prueba;

use prueba;   -- PROFESOR SAADY PACHECHO   saadypacheco@gmail.com   1154574097

drop table if exists persona;
create table if not exists persona(
	idpersona int not null auto_increment primary key,
    nombre varchar(40) not null,
    apellido varchar(40) not null,
    fechanacimiento date not null,
    idnacionalidad int not null,
    idcalle int not null,
    idnumero int not null,
        -- xxxx aca va el peso
    idsexo int not null
 --   primary key (idpersona)			SI NO ESPECIFICAMOS LA PK EN SU PROPIA LINEA LO ESPECIFICAMOS ACA
);

drop table if exists sexo;
create table if not exists sexo(
	idsexo int not null auto_increment primary key,
    descripcion varchar (10)
    );
    
drop table if exists nacionalidad;
create table if not exists nacionalidad(
	idnacionalidad int not null auto_increment primary key,
    descripcion varchar (40) not null
);

drop table if exists dircalle;
create table dircalle(
	idcalle int (10) auto_increment primary key,
    descripcion varchar(50) not null
    );




alter table persona
add constraint persnac foreign key (idnacionalidad) references nacionalidad (idnacionalidad);

alter table persona
add constraint perssex foreign key (idsexo) references sexo (idsexo);

alter table persona
add constraint prscalle foreign key (idcalle) references dircalle (idcalle);




insert into sexo
(descripcion)
value ("Femenino"),("Masculino");

insert into nacionalidad
(descripcion)
value ("Argentina"),("Bolivia"),("Brasil"),("Chile"),("Colombia"),("Ecuador"),("Guyana"),("Guayana Fr"),("Paraguay"),("Peru"),("Surinam"),("Uruguay"),("Venezuela");

insert into dircalle
(descripcion)
value ("Juan B. Justo"),("Psje. Cañuelas"),("Thames"),("Serrano"),("Gurruchaga"),("Acevedo"),("Malabia"),("Canning"),("Corrientes"),("Camargo"),("Padilla"),("Murillo"),("Muñecas"),("Martinez Rosas"),("Warnes");

insert into persona
(nombre,apellido,fechanacimiento,idnacionalidad,idcalle,idnumero,idsexo)
values ("Florencia","Gonzalo",'1995-06-15',1,1,2933,1),("Matias","Contiagini",'1987-07-19',3,4,308,2),
("Carlos","Drago",'1990-01-01',13,8,111,2),("Mariana","Lucena",'1998-05-05',13,8,2405,1);




select * from sexo;

select * from nacionalidad;

select * from dircalle;

select nombre as Nombre,apellido as Apellido,(sexo.descripcion) as 'Sexo del DNI',fechanacimiento as 'Fecha de nacimiento',
(dircalle.descripcion) as Calle,(idnumero) as Número,(nacionalidad.descripcion) as Pais
from persona
inner join nacionalidad
on persona.idnacionalidad = nacionalidad.idnacionalidad
inner join sexo
on persona.idsexo = sexo.idsexo
inner join dircalle
on persona.idcalle = dircalle.idcalle;


