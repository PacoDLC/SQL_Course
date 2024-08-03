-- Disparador NombreMayuscula
/* Al insertar un registro en el campo Alumno_Nombre de la tabla alumnos, el disparador NombreMayuscula se ejectuta
automáticamente para cambiar todos lo caracteres del nuevo registro a letra MÁYUSCULAS */
INSERT INTO alumnos (Alumno_Id, Alumno_Nombre)
	VALUES (0, 'mariana');
	
-- Disparador ventas_before_insert
INSERT INTO ventas (Ventas_Fecha, Ventas_NroFactura, Ventas_Total)
VALUES ('2019-03-04', 158, -156.58);