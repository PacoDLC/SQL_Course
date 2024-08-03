-- Más funciones SQL

-- Funcion INSERT

-- Inserta tres nuevos registros en la tabla 'alumnos' con los nombres 'Pedro Jerez', 'María Antonieta' y 'Pablo Neruda'.
INSERT INTO alumnos (Alumno_Nombre) VALUES ('Pedro Jerez'),('María Antonieta'),('Pablo Neruda');

-- Inserta tres nuevos registros en la tabla 'productos' con las descripciones y colores especificados.
INSERT 
	INTO productos (Prod_Descripcion, Prod_Color) 
		VALUES 
			('Mi Producto 2', 'Mi Color 2'),
			('Mi Producto 3', 'Mi Color 3'),
			('Mi Producto 4', 'Mi Color 1');
		
-- Funcion UPDATE

/* Actualiza los registros en la tabla 'productos' donde 'Prod_Id' es mayor que 6993,
estableciendo 'Prod_Descripcion' a 'Descripcion Modificada', 'Prod_Status' a 0, 
y 'Prod_CompraSuspendida' a 1.*/
UPDATE productos p 
SET p.Prod_Descripcion = 'Descripcion Modificada',
	 p.Prod_Status = 0,
	 p.Prod_CompraSuspendida = 1
WHERE p.Prod_Id > 6993;

-- Funcion DELETE

-- Elimina los registros en la tabla 'productos' donde 'Prod_Id' es mayor que 6989.
DELETE FROM productos p WHERE p.Prod_Id > 6989;

/* Sintáxis de las funciones INSERT, UPDATE y DELETE en SQL */

INSERT INTO <tabla> (<campos>) VALUES (<valores>);
UPDATE <tabla> SET <campo> = <valor> WHERE <condcion o condiciones>;
DELETE FROM <tabla> WHERE <condicion o condiciones>;