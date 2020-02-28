-- BORRA LA BASE DE DATOS 
drop database if exists facturacion;

-- CREA LA BASE DE DATOS 
create database facturacion;

-- DEFINIMOS QUE BASE DE DATOS VAMOS A USAR
use facturacion;


/* -- INSTRUCCIONES PARA CREAR TABLAS

CREATE TABLE <nombre de la tabla> 							-- LO QUE ESTÁ ENTRE <> SON CAMPOS OBLIGATORIOS

<nombre de columna> <tipo(cant max de caracteres)> [not null] 	-- LO QUE ESTÁ ENTRE [] ES OPCIONAL	(NOT NULL HACE REFERENCIA A QUE ESA COLUMNA NO PUEDE TENER LUGARES VACIOS)

PRIMARY KEY <(nombre de columna,[nombre de columna],...)	-- DEFINIMOS LA CLAVE PRIMARIA. UNA ES OBLIGATORIA, SE PUEDEN PONER MÁS OPCIONALES

CONSTRAINT <nombre> FOREIGN KEY <(campo de la tabla)> REFERENCES <nombre de la base de datos referida.nombre de la tabla (nombre de la columna)>   -- DEFINIMOS CLAVES EXTERNAS
[ON DELETE NO ACTION]        
[ON UPDATE NO ACTION]

*/

-- CREAMOS LA TABLA FACTURASCABECERA

CREATE table if not exists facturasCabecera(
nro int not null,  
cliente varchar(50) not null,
direccion varchar(50), -- varchar es una string variable 
fecha date,
cuit varchar(13),
primary key(nro) -- definicion de clave primaria
);


-- CREAMOS LA TABLA ITEMS

CREATE TABLE if not exists `items` (
  `nro` int(11) NOT NULL,
  `mercaderia` varchar(45) NOT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `precioUnitario` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`nro`,`mercaderia`),
  CONSTRAINT `ItemFact` FOREIGN KEY (`nro`) REFERENCES `facturascabecera` (`nro`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- CREAMOS LA TABLA CLIENTES

CREATE TABLE if not exists clientes (
codigo int NOT NULL AUTO_INCREMENT,
nombre varchar(50) not null,
apellido varchar (50) not null,
cuit varchar(11) not null,
direccion varchar (200),
PRIMARY KEY (codigo)
);


-- CREAMOS LA TABLA PROVINCIA
DROP TABLE IF EXISTS provincia;
CREATE TABLE `provincia` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;



/* -- INSTRUCCIONES PARA CREAR FILAS

INSERT into <nombre de la tabla>
[lista de columnas] -- es opcional si no ponemos esto, el programa asume que vamos a usar todas las columnas y pide los valores de todos
values <lista de columnas>

*/

INSERT INTO clientes
values (1, "Ricardo", "perez", "2245678462", "Gurruchaga 567");

INSERT INTO clientes
values (2,"Felipe", "Colombo", "3644565533", "Aguirre 334");

INSERT INTO clientes
values (3, "Matias", "Dorrego","057295740", "Av. Corrientes 5000");

INSERT INTO clientes
values (4, "Agustin", "lorenzati","3635245533", "Tinogasta 3581");

INSERT INTO provincia
(descripcion)
value("Buenos Aires"),("Catamarca"),("Chaco"),("Chubut"),("Cordoba"),("Corrientes"),("Entre Rios"),("Formosa"),("Jujuy"),("La Pampa"),("La Rioja"),("Mendoza"),("Misiones"),("Neuquén"),("Rio Negro"),("San Juan"),("San Luis"),("Salta"),("Santa Cruz"),("Santa Fe"),("Santiago del Estero"),("Tucuman"),("Tierra del Fuego");

INSERT INTO clientes
(nombre,apellido,cuit,direccion)
values ("ricardo", "perez", "2245678462", "Gurruchaga 567"),("ricardo", "perez", "2245678462", "Gurruchaga 567"),("ricardo", "perez", "2245678462", "Gurruchaga 567");



/* MODIFICACION DE DATOS 

UPDATE <nombre de la tabla>

SET <lista de columna = valor nuevo para esa columna>

WHERE [condiciones para especificar que filas quiero modificar]  -- SI NO AGREGO ESTA LINEA, SE MODIFICAN TODAS LAS FILAS

*/

UPDATE clientes
SET direccion = "Cuenca 3440"
WHERE nombre = "Matias" and apellido = "Dorrego";   --  ACA USAMOS UNA CONDICION "Y"


/* BORRADO DE DATOS

DELETE FROM <nombre de la tabla>
WHERE <condicion>

DELETE FROM <nombre de la tabla>										
WHERE <columna> IN (3,4,5);				-- CON "IN" BORRAMOS VARIOS CAMPOS A LA VEZ

DELETE FROM <nombre de la tabla>
WHERE <columna> NOT IN (3,4,5) 			-- CON EL "NOT IN" BORRAMOS TODAS LAS LINEAS EXCEPTO LAS QUE ESCRIBAMOS


Ej:
DELETE FROM provincia
WHERE codigo = 4;

*/

/* MODIFICACION DE TABLAS

ALTER TABLE <nombre de la tabla>

*/

ALTER TABLE provincia
AUTO_INCREMENT = 1;						-- LA COLUMNA QUE TENGA NUMERACION AUTOMATICA COMENZARÁ DESDE EL NUMERO 1

ALTER TABLE `facturacion`.`clientes` 
AUTO_INCREMENT = 100 ,
CHANGE COLUMN `codigo` `codigo` INT(11) NOT NULL AUTO_INCREMENT ;	-- CAMBIAMOS LOS ATRIBUTOS DE LA TABLA "codigo"


--


-- AGREGAMOS UNA COLUMNA A LA TABLA CLIENTES

ALTER TABLE `facturacion`.`clientes` 
ADD COLUMN `codProvincia` INT AFTER `direccion`,
ADD INDEX `cliProv_idx` (`codProvincia` ASC),
ADD CONSTRAINT `cliProv` FOREIGN KEY (`codProvincia`) REFERENCES `facturacion`.`provincia` (`codigo`);   	-- RELACIONAMOS LA NUEVA COPLUMNA CON LA TABLA PROVINCIA

UPDATE clientes
SET codProvincia = 1;			-- AGREGAMOS UNA VALOR EN LA COLUMNA PROVINCIA DE TODAS LAS LINEAS

UPDATE clientes
SET codProvincia = 2
WHERE codigo = 2  OR codigo = 3;    				--  ACA USAMOS UNA CONDICION "O" PARA MODIFICAR SOLO ALGUNAS LINEAS. ABAJO OTRAS VARIANTES

/* (VARIANTES PARA MODIFICAR VARIAS LINEAS)

WHERE codigo >1 and codigo <4

WHERE codigo in (2,3)

WHERE codigo between 2 and 3

  */

-- AGREGAMOS CLIENTES INCLUYENDO LA NUEVA COLUMNA CODPROVINCIA
INSERT INTO clientes
(nombre,apellido,cuit,direccion,codProvincia)
values ("José", "Martinez", "2045678462", "Gurruchaga 567",3),
("ricardo", "perez", "2245678462", "Gurruchaga 567",4),
("ricardo", "perez", "2245678462", "Gurruchaga 567",5);

INSERT INTO clientes
(nombre,apellido,cuit,direccion,codProvincia)
values ("mario", "perez", "2245678462", "Gurruchaga 567",20);

-- MODIFICAMOS EL CUIT DE TODOS LOS CLIENTES QUE TENEMOS PORQUE VAMOS A HACER QUE LOS VALORES DE ESA COLUMNA NO SE REPITAN

UPDATE `facturacion`.`clientes` SET `cuit` = '20255898462' WHERE (`codigo` = '1');
UPDATE `facturacion`.`clientes` SET `cuit` = '30644565533' WHERE (`codigo` = '2');
UPDATE `facturacion`.`clientes` SET `cuit` = '20057295740' WHERE (`codigo` = '3');
UPDATE `facturacion`.`clientes` SET `cuit` = '30635245533' WHERE (`codigo` = '4');
UPDATE `facturacion`.`clientes` SET `cuit` = '20245679632' WHERE (`codigo` = '5');
UPDATE `facturacion`.`clientes` SET `cuit` = '27245678462' WHERE (`codigo` = '6');
UPDATE `facturacion`.`clientes` SET `cuit` = '20325678462' WHERE (`codigo` = '7');
UPDATE `facturacion`.`clientes` SET `cuit` = '27245678461' WHERE (`codigo` = '100');
UPDATE `facturacion`.`clientes` SET `cuit` = '20245678463' WHERE (`codigo` = '101');
UPDATE `facturacion`.`clientes` SET `cuit` = '20245678464' WHERE (`codigo` = '102');
UPDATE `facturacion`.`clientes` SET `cuit` = '20335678462' WHERE (`codigo` = '103');

-- LA COLUMNA CUIT AHORA PASA A SER DE UNIQUE INDEX
ALTER TABLE `facturacion`.`clientes` 
ADD UNIQUE INDEX `cuit_UNIQUE` (`cuit` ASC);


-- TENIA REPETIDAS LA PROVINCIAS 3 VECES CADA UNA
select *
from provincia
where codigo >46;

-- BORRAMOS DATOS CON UNA SENTENCIA QUE ME PERMITE DESHACER LOS CAMBIOS!!
START TRANSACTION;				-- CON ESTE COMANDO, PUEDO HACER CUALQUIER CAMBIO EN LA DB Y NO VAN A HACERSE PERMANANTE HASTA QUE NO ESCRIBA "COMMIT".  					
DELETE FROM provincia
WHERE codigo>46;
COMMIT;							-- UNA VEZ SEGURO QUE QUIERO HACER LOS CAMBIOS ESCRIBO "COMMIT Y LO QUE HICE DESDE "START TRANSACTION" QUEDA PERMANENTE. 
				-- SI EN VEZ DE GUARAR LOS CAMBIOS QUIERO VOLVER A COMO ESTABA ANTES EN VEZ DE COMMIT VA "ROLLBACK"


-- CREAMOS LA TABLA PAIS
drop table if exists pais;
CREATE TABLE `pais` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

-- AGREGAMOS DATOS A LA TABLA PAIS
INSERT INTO pais
(descripcion)
value ("Argentina"),("Bolivia"),("Brasil"),("Chile"),("Colombia"),("Ecuador"),("Guyana"),("Guayana Fr"),("Paraguay"),("Peru"),("Surinam"),("Uruguay"),("Venezuela");

-- AGREGAMOS LA COLUMNA PAIS A LA TABLA PROVINCIA
ALTER TABLE `facturacion`.`provincia` 
ADD COLUMN `pais` INT AFTER `descripcion`,
ADD INDEX `provPais_idx` (`pais` ASC),
ADD CONSTRAINT `prov_pais`
FOREIGN KEY (`pais`)  REFERENCES `facturacion`.`pais` (`codigo`);
  
UPDATE provincia
SET pais = 1;

-- AGREGO ESTADOS DE VENEZUELA
INSERT INTO provincia
(descripcion,pais)
VALUE("Anzoátegui",13),("Bolivar",13),("Lara",13),("Miranda",13);



/*  COMO VISUALIZAR LOS DATOS DE LAS DIFERENTES TABLAS

SELECT <nombre de columna>[,nombre de columna, ...] 	-- ESCRIBIMOS * SI QUEREMOS VER TODAS LAS COLUMNAS, SINO ESCRIBIMOS EL/LOS NOMBRE/S DE LAS COLUMNA QUE QUIERO VER
FROM <nombre de tabla>
WHERE  <condiciones>
ORDER BY <lista de columnas>
*/

select *
from clientes ;

select *
from provincia;

select*
from pais;

-- PARA VER SOLO DETERMINADAS COLUMNAS
select codigo, nombre 
from clientes
order by direccion desc ,apellido;

-- PARA VER TODAS LAS COLUMNAS DE LINEAS QUE CUMPLAN CIERTA CONDICION
select *
from clientes 
where codigo >1 ; 

-- PODEMOS MOSTRAR EL PRIMER CARACTER DE UNA COLUMNA (DESDE LA DERECHA O LA IZQUIERDA), Y PODEMOS DARLE UN TITULO A LA COLUMNA CON "AS"
select left (nombre,1) as 'primer letra del nombre'
from clientes ;
 
-- SELECT LEFT<(columna,cant de caracteres)>,SELECT RIGHT<(columna,cant de caracteres)>,<columna>,<columna> as 'nombre que quiera mostrar' -- TRAEMOS LOS DATOS QUE QUERAMOS 
select left(nombre,1), right(nombre,1), nombre, codigo as 'codigo de cliente' 
from clientes ; 


-- SI QUIERO VISUALIZAR DATOS DE DIFERENTES TABLAS RELACIONADAS

select*
from clientes
inner join provincia
on clientes.codProvincia = provincia.codigo;

select descripcion,nombre,apellido,cuit,direccion
from clientes
inner join provincia
on clientes.codProvincia = provincia.codigo
order by descripcion;

select *
from provincia as prv
inner join pais as p
	on prv.pais = p.codigo;
    
    
-- QUEDO DE TAREA VER POR QUÉ LA SIGUIENTE VISUALIZACION NO FUNCIONA
select descripcion,pais,nombre,apellido,cuit,direccion
from clientes
inner join provincia
on clientes.codProvincia = provincia.codigo
inner join pais
on provincia.pais = pais.descripcion
order by descripcion;

