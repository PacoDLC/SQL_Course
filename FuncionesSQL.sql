-- Funciones SQL

/* -------------------------------------------------------------------------------------------------------------- */

SELECT 
	p.Prod_Id, -- Selecciona la columna 'Prod_Id' de la tabla 'productos' con alias 'p'.
	p.Prod_Descripcion,  -- Selecciona la columna 'Prod_Descripcion' de la tabla 'productos' con alias 'p'.
	/* Utiliza la función IF para comprobar el valor de 'Prod_Status'. Si 'Prod_Status' es 1, devuelve 'Habilitado'; 
	de lo contrario, devuelve 'Deshabilitado'. El resultado se presenta bajo la columna alias 'Estado'. */
	IF(Prod_Status = 1, 'Habilitado', 'Deshabilitado') AS Estado
FROM productos p; -- Especifica la tabla 'productos' con alias 'p'.

SELECT 
	p.Prod_Id, 
	p.Prod_Descripcion,
	/* Si el valor de 'Prod_Status' en la tabla 'p' es igual a 1, se devuelve el texto 'Habilitado'.
   En caso contrario, se devuelve el texto 'Deshabilitado'.
   El resultado de esta expresión se presenta bajo la columna alias 'Estado'. */
	CASE WHEN p.Prod_Status = 1 THEN 'Habilitado' ELSE 'Deshabilitado' END AS Estado
FROM productos p;

SELECT
	p.Prod_Id, p.Prod_Descripcion,
	CASE p.Prod_Status -- Inicia una expresión CASE para evaluar 'Prod_Status' en la tabla 'productos' con alias 'p'.
		WHEN 0 THEN 'Deshabilitado' -- Si 'Prod_Status' es 0, devuelve 'Deshabilitado'
		WHEN 1 THEN 'Habilitado' -- Si 'Prod_Status' es 1, devuelve 'Habilitado'.
		ELSE 'Desconocido' -- Si 'Prod_Status' no es 0 ni 1, devuelve 'Desconocido'.
	END AS Estado -- Termina la expresión CASE y asigna un alias 'Estado' a la columna resultante.
FROM productos p; -- Especifica la tabla 'productos' con alias 'p'.

SELECT
	p.Prod_Id, p.Prod_Descripcion,
	CASE p.Prod_Status
		WHEN 0 THEN 'Deshabilitado'
		/* -- Si la condición es 1, calcula la suma de VD_Cantidad de ventas_detalle donde VD_ProdId coincide 
		con Prod_Id de la tabla p; si no hay coincidencias, devuelve 0. */
		WHEN 1 THEN IFNULL((SELECT SUM(vd.VD_Cantidad) FROM ventas_detalle vd WHERE vd.VD_ProdId = p.Prod_Id), 0)
		ELSE 'Desconocido'
	END AS Estado
FROM productos p;

SELECT 
	p.Prod_Id, p.Prod_Descripcion,
	CASE SUBSTR(p.Prod_Descripcion, 1, 1) -- Inicia una expresión CASE para evaluar el primer carácter de 'Prod_Descripcion'.
		WHEN 'A' THEN 'Letra A' -- Si el primer carácter es 'A', devuelve 'Letra A'.
		WHEN 'B' THEN 'Letra B' -- Si el primer carácter es 'B', devuelve 'Letra B'.
		ELSE 'Otra Letra jsjs' 
	END AS Ejercicio -- Termina la expresión CASE y asigna un alias 'Ejercicio' a la columna resultante.
FROM productos p;

/* -------------------------------------------------------------------------------------------------------------- */

SELECT CURRENT_DATE; -- Selecciona la fecha actual del sistema.
SELECT CURRENT_TIME; -- Selecciona la hora actual del sistema.
SELECT CURRENT_TIMESTAMP; -- Selecciona la fecha y la hora actuales del sistema.
SELECT DATABASE(); -- Selecciona el nombre de la base de datos actual.
SELECT CURRENT_USER; -- Selecciona el usuario actual de la base de datos.
SELECT DATEDIFF(CURRENT_DATE,'2024-01-01') AS 'Dias desde el comienzo de año'; -- Calcula la diferencia en días entre la fecha actual y el 1 de enero de 2024, y le asigna un alias 'Dias desde el comienzo de año'.
SELECT DATEDIFF(CURRENT_DATE, v.Ventas_Fecha) AS 'Antiguedad den días', v.Ventas_NroFactura FROM ventas v; -- Calcula la diferencia en días entre la fecha actual y la fecha de la venta, y le asigna un alias 'Antiguedad en días', además selecciona el número de factura de la tabla 'ventas' con alias 'v'.
SELECT DAYOFWEEK(CURRENT_DATE) AS 'Dia de la Semana'; -- Selecciona el día de la semana correspondiente a la fecha actual y le asigna un alias 'Dia de la Semana'.

SELECT ADDDATE(CURRENT_DATE(),15); -- Añade 15 días a la fecha actual del sistema.
SELECT CURRENT_TIMESTAMP(), ADDTIME(CURRENT_TIMESTAMP(), '00:15:00'); -- Selecciona la fecha y hora actuales del sistema y añade 15 minutos a la hora actual.
SELECT CAST('2023-06-25' AS DATE); -- Convierte una cadena de texto que representa una fecha ('2023-06-25') en un tipo de dato DATE
SELECT CAST(12345 AS CHAR); -- Convierte un número entero (12345) en una cadena de texto (tipo de dato CHAR).
SELECT ADDDATE(CAST('2023-06-25' AS DATE), 10); -- Añade 10 días a una fecha específica ('2023-06-25') después de convertirla a un tipo de dato DATE.
SELECT p.Prod_Id, p.Prod_Descripcion, CHAR_LENGTH(p.Prod_Descripcion) AS Largo FROM productos p; -- Selecciona el ID del producto (Prod_Id), la descripción del producto (Prod_Descripcion) y la longitud de la descripción del producto (CHAR_LENGTH) con un alias 'Largo' de la tabla 'productos' con alias 'p'.

SELECT COMPRESS(p.Prod_Descripcion) AS Comprimido FROM productos p; -- Comprime la descripción del producto (Prod_Descripcion) y la muestra con el alias 'Comprimido' de la tabla 'productos' con alias 'p'.
SELECT UNCOMPRESS(COMPRESS(p.Prod_Descripcion)) AS Original FROM productos p; -- Descomprime la descripción del producto previamente comprimida (Prod_Descripcion) y la muestra con el alias 'Original' de la tabla 'productos' con alias 'p'.
SELECT CONCAT("(", p.Prod_Id, ") ", p.Prod_Descripcion, " ", p.Prod_Color) AS Descripcion FROM productos p; -- Concatenar el ID del producto (Prod_Id) entre paréntesis, la descripción del producto (Prod_Descripcion) y el color del producto (Prod_Color) en una sola cadena con un alias 'Descripcion' de la tabla 'productos' con alias 'p'.
SELECT CONCAT_WS(" ", "(", p.Prod_Id, ") ", p.Prod_Descripcion, p.Prod_Color) AS Descripcion FROM productos p; -- Concatenar el ID del producto (Prod_Id) entre paréntesis, la descripción del producto (Prod_Descripcion) y el color del producto (Prod_Color) con espacios entre ellos, usando CONCAT_WS, con un alias 'Descripcion' de la tabla 'productos' con alias 'p'.
SELECT CONV("10", 10, 2); -- Convierte la cadena '10' del sistema numérico decimal (base 10) al sistema numérico binario (base 2).
SELECT CONV("A", 16, 10); -- Convierte la cadena 'A' del sistema numérico hexadecimal (base 16) al sistema numérico decimal (base 10).
SELECT DATE_ADD(CURRENT_DATE, INTERVAL 10 YEAR); -- Añade 10 años a la fecha actual del sistema.
SELECT DATE_SUB(CURRENT_DATE, INTERVAL 10 DAY ); -- Resta 10 días a la fecha actual del sistema y muestra la nueva fecha.

SELECT DATE_FORMAT('2023-08-21', '%w');
SELECT DATE_FORMAT('2023-08-21', '%W');
SELECT DATE_FORMAT('2023-08-21', '%m');
SELECT DATE_FORMAT('2023-08-21', '%M');
SELECT DATE_FORMAT('2023-08-21', '%y');
SELECT DATE_FORMAT('2023-08-21', '%Y');

-- Parámetros de la función DATE_FORMAT()
/*
%Y: Año de 4 digitos
%y: Año de 2 digitos
%m: Mes (00,...,12)
%d: Dia del mes (00,...,31)
%H: Horas (00,...,23)
%i: Minutos (00,...,59)
%s: Segundos (00,...,59)
%p: AM o PM
%W: Nombre del día en inglés (Sunday,...,Saturday)
*/