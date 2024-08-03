-- Insertar en la tabla 'productos' un registro
INSERT productos (Prod_Id, Prod_Descripcion, Prod_Color, Prod_ProvId) VALUES (6991, 'Mi Producto 6991', 'Mi Color 6991', 9);

-- Hacer un Bulk Insert en la tabla 'productos'
INSERT productos (Prod_Descripcion, Prod_Color) 
VALUES
	('Mi Producto 01', 'Mi Color 01'),
	('Mi Producto 02', 'Mi Color 02'),
	('Mi Producto 03', 'Mi Color 03'),
	('Mi Producto 04', 'Mi Color 04'),
	('Mi Producto 05', 'Mi Color 05');
	
-- Modificar el estado de la tabla 'clientes' y asignarle un "0"
UPDATE clientes cl
SET cl.Cli_Estado = 0;

-- Asignarle "1" al estado de la tabla 'clientes', del cliente ID número 10
UPDATE clientes cl
SET cl.Cli_Estado = 1
WHERE cl.Cli_Id = 10;

-- Asignarle "1" al estado de la tabla 'clientes' de los clientes 6,20,54 y 56
UPDATE clientes cl
SET cl.Cli_Estado = 1
WHERE cl.Cli_Id IN (6, 20, 54, 56);

-- Sumarle al producto 6989, 100 en el campo Prod_Precio
UPDATE productos p
SET p.Prod_Precio = p.Prod_Precio + 100
WHERE p.Prod_Id = 6989;

-- Borrar de la tabla 'clientes', el ID número 10
DELETE FROM clientes cl WHERE cl.Cli_Id = 10;

-- Borrar todos lo registros de la tabla 'productos' cuyo proveedor comience con la letra "A"
DELETE p FROM productos p
	JOIN proveedores pro ON p.Prod_ProvId = pro.Prov_Id
	WHERE pro.Prov_Nombre LIKE 'A%';
	
SELECT COUNT(*) registros FROM productos;

-- Traer las fechas, números de facturas y monto total de mis ventas

SELECT v.Ventas_Fecha, v.Ventas_NroFactura, v.Ventas_Total FROM ventas v;

-- Traer los ID de productos, cantidad y precio de mi detalle de ventas de los registros donde el precio se mayor a 0

SELECT 
	vd.VD_Id, 
	vd.VD_Cantidad, 
	vd.VD_Precio 
FROM 
	ventas_detalle vd
WHERE 
	vd.VD_Precio > 0;
	
-- Traer el total vendido por fecha de factura

SELECT v.Ventas_Fecha AS Fecha, SUM(v.Ventas_Total) AS 'Total Vendido' 
FROM ventas v
GROUP BY v.Ventas_Fecha;

-- Traer el total vendido por año y mes de factura

SELECT 
	YEAR(v.Ventas_Fecha) AS Año,
	MONTH(v.Ventas_Fecha) AS Mes,
	SUM(v.Ventas_Total) AS 'Total Vendido'
FROM ventas v
GROUP BY Año, Mes;

-- Traer los productos de la tabla productos que pertenezcan al proveedor 62

SELECT * FROM productos p WHERE p.Prod_ProvId = 62;

-- Traer la lista de productos vendidos (solo su ID) sin repeticiones y con total vendido por cada uno

SELECT
	vd.VD_ProdId AS Producto,
	SUM((vd.VD_Precio * vd.VD_Cantidad)) AS Total
FROM ventas_detalle vd
GROUP BY Producto;

-- Traer fecha de factura, numero de factura, ID del cliente, nombre de cliente y monto total vendido

SELECT v.Ventas_Fecha, v.Ventas_NroFactura, v.Ventas_CliId, c.Cli_RazonSocial, v.Ventas_Total
FROM ventas v
	JOIN clientes c ON v.Ventas_CliId = c.Cli_Id;
	
/* Traer fecha de factura, numero de factura, ID de producto, descripcion de producto, ID de proveedor, Nombre de
proveedor, cantidad, precio unitario y parcial (cantidad precio) */

SELECT 
	v.Ventas_Fecha AS Fecha,
	v.Ventas_NroFactura AS Factura,
	vd.VD_ProdId AS Código,
	p.Prod_Descripcion AS Descripción,
	vd.VD_Cantidad AS Cantidad,
	vd.VD_Precio AS 'Precio Unitario',
	pr.Prov_Id AS 'Código de Proveedor',
	pr.Prov_Nombre AS Nombre,
	(vd.VD_Cantidad * vd.VD_Precio) AS Parcial
FROM ventas v
	JOIN ventas_detalle vd ON vd.VD_VentasId = v.Ventas_Id
	JOIN productos p ON vd.VD_ProdId = p.Prod_Id
	JOIN proveedores pr ON p.Prod_ProvId = pr.Prov_Id;
	
/* Traer todos los productos que hayan sido vendidos entre el 14/01/2018 y el 16/01/2018 (sin repetir) y calculando 
la cantidad de unidades vendidas*/

SELECT
	p.Prod_Id AS Código,
	p.Prod_Descripcion AS Descripción,
	SUM(vd.VD_Cantidad) AS 'Unidades Vendidas'
FROM productos p
	JOIN ventas_detalle vd ON p.Prod_Id = vd.VD_ProdId
	JOIN ventas v ON v.Ventas_Id = vd.VD_VentasId
WHERE v.Ventas_Fecha BETWEEN '2018-01-14' AND '2018-01-16'
GROUP BY Código;

SELECT Código, Descripción, UnidVend AS 'Unidades Vendidas'
FROM
	(
	SELECT
		p.Prod_Id AS Código,
		p.Prod_Descripcion AS Descripción,
		SUM(vd.VD_Cantidad) AS UnidVend
	FROM productos p
		JOIN ventas_detalle vd ON p.Prod_Id = vd.VD_ProdId
		JOIN ventas v ON v.Ventas_Id = vd.VD_VentasId
	WHERE v.Ventas_Fecha BETWEEN '2018-01-14' AND '2018-01-16'
	GROUP BY Código
	) AS SUBCONSULTA
ORDER BY UnidVend DESC;

-- Traer todos los artículos cuya descripción comience con la palabra "SUBTERRANEO"

SELECT 
	p.Prod_Id AS Código,
	p.Prod_Descripcion AS Descripción
FROM productos p
WHERE p.Prod_Descripcion LIKE 'SUBTERRANEO%';

-- Traer todos los artículos que en su descripción o color o nombre de proveedor tenga el string "FERRO"

SELECT
	p.Prod_Id AS Código,
	p.Prod_Descripcion AS Descripción,
	p.Prod_Color AS Color,
	pr.Prov_Nombre AS Proveedor
FROM productos p
	JOIN proveedores pr ON p.Prod_ProvId = pr.Prov_Id
WHERE
	CONCAT(p.Prod_Descripcion, p.Prod_Color, pr.Prov_Nombre) LIKE '%FERRO%';
	
-- Traer todos lo artículos cuya descripcion tenga el string "CINTA" y que tengan ventas realizadas

SELECT 
	p.Prod_Id AS Código,
	p.Prod_Descripcion AS Descripción
FROM productos p
	JOIN ventas_detalle vd ON p.Prod_Id = vd.VD_ProdId
WHERE p.Prod_Descripcion LIKE '%CINTA%'
GROUP BY p.Prod_Id;

SELECT 
	p.Prod_Id AS Código,
	p.Prod_Descripcion AS Descripción
FROM productos p
WHERE p.Prod_Id IN (SELECT DISTINCTROW(vd.VD_ProdId) FROM ventas_detalle vd)
	AND p.Prod_Descripcion LIKE '%CINTA%';
	
-- Traer la cantidad de productos que han sido vendidos

SELECT
	COUNT(DISTINCT(vd.VD_ProdId)) AS Cantidad
FROM ventas_detalle vd;

/* Traer el total vendido de los productos que fueron vendidos entre el 02/01/2018 y el 10/01/2018 y cuyo proveedor
se encuentre entre el 2 y el 100 */

SELECT  
	SUM((vd.VD_Precio * vd.VD_Cantidad)) AS 'Total Vendido'
FROM ventas_detalle vd
	JOIN productos p ON vd.VD_ProdId = p.Prod_Id
	JOIN ventas v ON v.Ventas_Id = vd.VD_VentasId
WHERE (v.Ventas_Fecha BETWEEN '2018-01-02' AND '2018-01-10')
	AND (p.Prod_ProvId BETWEEN 2 AND 100);
	
/* Traer la factura de valor máximo, que haya tenido en sus items vendidos, el producto 656 */

SELECT MAX(v.Ventas_Total) AS 'Valor Máximo' 
FROM ventas v
	JOIN ventas_detalle vd ON vd.VD_VentasId = v.Ventas_Id
WHERE vd.VD_ProdId = 656;

SELECT MAX(v.Ventas_Total) AS 'Valor Máximo' 
FROM ventas v
	JOIN ventas_detalle vd ON vd.VD_VentasId = v.Ventas_Id AND vd.VD_ProdId = 656;
	
-- Esportar una consulta

SELECT p.Prod_Id, p.Prod_Descripcion, p.Prod_ProvId 
FROM productos p
	JOIN proveedores pr ON p.Prod_ProvId = pr.Prov_Id;
	
/* Para exportar una consulta primero ejecutamos el script de la consulta para porteriormente hacer click derecho
sobre una de las casillas cualesquiera de la consulta. Seleccionamos "Exportar filas de la cuadrícula" y elegimos
el fromato y la ruta dónde se guardara la consulta exportada.*/

-- Guardar una consulta

/* Seleccionamos el ícono de caset arriba "Guardar SQL en un archivo. Seleccionamos el nombre del archivo así como
ruta dónde se va a guardar" */