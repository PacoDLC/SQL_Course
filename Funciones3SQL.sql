-- Más Funciones en SQL

-- Actualizar una fecha con las función ADDDATE()
SELECT v.Ventas_Fecha AS Fecha, ADDDATE(Ventas_Fecha,30) AS 'Fecha de Vencimiento' FROM ventas v;

-- Encriptar valores de datos con la función AES_ENCRYPT()
SELECT p.Prod_Descripcion, AES_ENCRYPT(p.Prod_Descripcion, 'Masters del Desarrollo') AS EncryptValues 
FROM productos p;

-- Desencriptar usando AES_DECRYPT()
SELECT p.Prod_Descripcion, AES_DECRYPT(AES_ENCRYPT(p.Prod_Descripcion, 'Masters del Desarrollo'), 'Masters del Desarrollo') AS DescryptValues
FROM productos p;

/* Más funciones de encriptación y desencriptación en:
https://dev.mysql.com/doc/refman/5.7/en/encryption-functions.html */

-- Captura la longitud de caracteres con la función LENGTH()
SELECT p.Prod_Descripcion, LENGTH(p.Prod_Descripcion) FROM productos p;

-- Funcion COMPRESS() para comprimir datos
SELECT COMPRESS(p.Prod_Descripcion) AS Comprimido FROM productos p;

-- Funcion UNCOMPRESS() para descomprimir datos
SELECT UNCOMPRESS(COMPRESS(p.Prod_Descripcion)) AS Descomprimido FROM productos p;

-- Funciones CONCCAT() y CONCAT_WS()
SELECT CONCAT(p.Prod_Descripcion, p.Prod_Color) AS Descripción FROM productos p;
SELECT CONCAT_WS(" ", p.Prod_Descripcion, p.Prod_Color, p.Prod_Precio) AS Descripción FROM productos p;

-- Convertir tipos de datos con la función CONVERT()
SELECT CONVERT("2020-01-2018", DATE) AS Fecha FROM productos p;

-- Obtener la diferencia en días entre fechas con la función DATEDIFF() y la función NOW() para la fecha actual
SELECT DATEDIFF(v.Ventas_Fecha, NOW()) AS Intervalo FROM ventas v;

-- Funcion DATEFROMAT() para formatear fechas a variables tipo String
SELECT DATE_FORMAT(v.Ventas_Fecha, "%Y / %m / %d") AS "Fecha de Venta" FROM ventas v;