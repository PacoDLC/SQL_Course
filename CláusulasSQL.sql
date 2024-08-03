-- Selecciona todos los productos de la Tabla 'productos'
SELECT * FROM productos;

-- Selecciona el ID, descripción y precio de los productos de la Tabla 'productos'
SELECT Prod_ID, Prod_Descripcion, Prod_Precio FROM productos;

/*
Selecciona el ID, descripción y precio de los productos de la Tabla 'productos' cuyo precio 
'Prod_Precio' es mayor a 0 o cuyo 'Prod_ProvID' sea mayor a 10 y menor a 50
*/
SELECT p.Prod_ID, p.Prod_Descripcion, p.Prod_Precio, p.Prod_ProvId FROM productos p 
WHERE Prod_Precio > 0 OR (Prod_ProvID > 10 AND Prod_ProvID < 50);

/*
Selecciona todas las columnas de la tabla 'ventas' (alias 'v') donde la fecha de venta 
(Ventas_Fecha) es posterior al 2 de enero de 2018 y anterior al 4 de enero de 2018
*/
SELECT * FROM ventas v WHERE v.Ventas_Fecha > '2018-01-02' AND v.Ventas_Fecha < '2018-01-04';

/*
Selecciona todas las columnas de la tabla 'ventas' (alias 'v') donde el año de la fecha de venta 
(Ventas_Fecha) es 2018
*/
SELECT * FROM ventas v WHERE YEAR(v.Ventas_Fecha) = 2018;

/*
Selecciona todas las columnas de la tabla 'ventas' (alias 'v') donde la fecha de venta 
(Ventas_Fecha) está entre el 1 de enero de 2018 y el 3 de enero de 2018, inclusive
*/
SELECT * FROM ventas v WHERE v.Ventas_Fecha BETWEEN '2018-01-01' AND '2018-01-03';

/*
Selecciona todas las columnas de la tabla 'ventas_detalle' (alias 'vd') donde el ID del 
producto (VD_ProdID) es igual a 1128
*/
SELECT * FROM ventas_detalle vd WHERE vd.VD_ProdID = 1128;

-- Unión de Tablas con cláusula "WHERE"

/*
Selecciona información de ventas, clientes, productos y proveedores, incluyendo
número de factura, ID del cliente, razón social del cliente, fecha de venta, ID y descripción del producto,
ID y nombre del proveedor, para ventas con ID de cliente mayor que 1, 
uniendo las tablas 'ventas', 'clientes', 'ventas_detalle', 'productos' y 'proveedores',
y ordena los resultados por fecha de venta en orden descendente y descripción del producto.
*/
SELECT v.Ventas_NroFactura, v.Ventas_CliId, c.Cli_RazonSocial, v.Ventas_Fecha, vd.VD_ProdId,
p.Prod_Descripcion, pr.Prov_Id, pr.Prov_Nombre
FROM ventas v, clientes c, ventas_detalle vd, productos p, proveedores pr
WHERE v.Ventas_CliId = c.Cli_Id AND v.Ventas_CliId > 1 AND vd.VD_VentasId = v.Ventas_Id 
      AND vd.VD_ProdId = p.Prod_Id AND p.Prod_ProvId = pr.Prov_Id
ORDER BY v.Ventas_Fecha DESC, Prod_Descripcion;

-- Funciones SUM, COUNT, MAX AVG y MIN

SELECT COUNT(*) AS registros FROM ventas v WHERE v.Ventas_Fecha = '2018-01-02';
SELECT SUM(v.Ventas_Total) AS total FROM ventas v WHERE YEAR(v.Ventas_Fecha) = 2018 AND MONTH(v.Ventas_Fecha) = 01;
SELECT MIN(v.Ventas_Total) AS total FROM ventas v WHERE YEAR(v.Ventas_Fecha) = 2018 AND MONTH(v.Ventas_Fecha) = 01;
SELECT MAX(v.Ventas_Total) AS total FROM ventas v WHERE YEAR(v.Ventas_Fecha) = 2018 AND MONTH(v.Ventas_Fecha) = 01;
SELECT AVG(v.Ventas_Total) AS total FROM ventas v WHERE YEAR(v.Ventas_Fecha) = 2018 AND MONTH(v.Ventas_Fecha) = 01;

-- Clausula GROUP BY

-- Agrupar ventas por código de producto y obtener cantidad de veces que se ha vendido
SELECT vd.VD_ProdId, p.Prod_Descripcion, COUNT(*) AS ventas FROM ventas_detalle vd, productos p
WHERE p.Prod_Id = vd.VD_ProdId
GROUP BY vd.VD_ProdId;

SELECT YEAR(v.Ventas_Fecha) AS año, MONTH(v.Ventas_Fecha) AS mes, SUM(v.Ventas_Total) AS total FROM ventas v
GROUP BY año, mes;

-- Clausula Having

SELECT YEAR(v.Ventas_Fecha) AS año, MONTH(v.Ventas_Fecha) AS mes, SUM(v.Ventas_Total) AS total FROM ventas v
GROUP BY año, mes
HAVING total > 1000000;

/*
Selecciona el ID y la descripción de productos, junto con la cantidad de ventas, de las tablas 'ventas_detalle' 
y 'productos', para productos con más de 100 ventas, agrupando por ID de producto y ordenando las ventas en 
orden descendente.
*/
SELECT vd.VD_ProdId, p.Prod_Descripcion, COUNT(*) AS ventas FROM ventas_detalle vd, productos p
WHERE p.Prod_Id = vd.VD_ProdId
GROUP BY vd.VD_ProdId HAVING ventas > 100
ORDER BY ventas DESC;

-- Clausula IN/NOT IN

/*Este es un ejemplo con condiciones anidadas (poco práctico)*/
SELECT * FROM productos p WHERE p.Prod_Id = 4 OR p.Prod_Id = 8 OR p.Prod_Id = 10 OR p.Prod_Id = 16;

SELECT * FROM productos p WHERE p.Prod_Id IN (4,8,10,16);
SELECT * FROM productos p WHERE p.Prod_Id NOT IN (4,8,10,16);

/*
Selecciona la lista de productos que no se han vendido
-- Selecciona filas únicas basadas en todas las columnas de la tabla 'ventas_detalle' y devuelve el campo VD_ProdId
-- renombrado como 'producto'. DISTINCTROW asegura que no haya duplicados considerando todas las columnas de la tabla.
*/

SELECT DISTINCTROW(vd.VD_ProdId) AS producto FROM ventas_detalle vd;

SELECT * FROM productos p WHERE p.Prod_Id NOT IN (SELECT DISTINCTROW(vd.VD_ProdId) AS producto FROM ventas_detalle vd);

SELECT * FROM clientes c WHERE c.Cli_Id NOT IN (SELECT DISTINCTROW(v.Ventas_CliId) FROM ventas v);

-- Cláusula LIKE con comodines
/*
-- Selecciona las columnas Prod_Id, Prod_Descripcion, Prod_Color y Prod_Precio de la tabla 'productos',
-- donde la concatenación de los valores de las columnas Prod_Descripcion y Prod_Color contiene la cadena 'NEGRO'.
*/
SELECT p.Prod_Id, p.Prod_Descripcion, p.Prod_Color, p.Prod_Precio FROM productos p
WHERE CONCAT(p.Prod_Descripcion, p.Prod_Color) LIKE "%NEGRO%";

-- Cláusula JOIN para unión de Tablas

-- Selecciona el número de factura de la venta, ID del cliente, nombre del cliente, ID del producto,
-- y descripción del producto.
SELECT v.Ventas_NroFactura, c.Cli_Id, c.Cli_RazonSocial, p.Prod_Id, p.Prod_Descripcion FROM productos p
	-- Realiza una unión (join) con la tabla 'ventas_detalle' usando el ID del producto.
	-- Solo incluye los registros donde el costo del producto (VD_Costo) es mayor a 10.
	JOIN ventas_detalle vd ON vd.VD_ProdId = p.Prod_Id AND vd.VD_Costo > 10
	-- Realiza una unión (join) con la tabla 'proveedores' usando el ID del proveedor.
	-- Solo incluye los registros donde el estado del proveedor (Prov_Satus) es igual a 1.
	JOIN proveedores pr ON pr.Prov_Id = p.Prod_Id AND pr.Prov_Satus = 1
	-- Realiza una unión (join) con la tabla 'ventas' usando el ID de la venta.
	-- Solo incluye las ventas que ocurrieron entre el 22 de enero de 2018 y el 24 de enero de 2018.
	JOIN ventas v ON vd.VD_VentasId = v.Ventas_Id AND v.Ventas_Fecha BETWEEN '2018-01-22' AND '2018-01-24'
	-- Realiza una unión (join) con la tabla 'clientes' usando el ID del cliente.
	JOIN clientes c ON v.Ventas_CliId = c.Cli_Id;
	
-- Cláusulas LEFT JOIN & RIGHT JOIN

SELECT p.Prod_Id, p.Prod_Descripcion, SUM(vd.VD_Cantidad) AS 'Unidades Vendidas', vd.VD_ProdId FROM productos p
	LEFT JOIN ventas_detalle vd ON p.Prod_Id = vd.VD_ProdId
GROUP BY p.Prod_Id
ORDER BY p.Prod_Id;

SELECT p.Prod_Id, p.Prod_Descripcion, SUM(vd.VD_Cantidad) AS 'Unidades Vendidas', vd.VD_ProdId FROM productos p
	RIGHT JOIN ventas_detalle vd ON p.Prod_Id = vd.VD_ProdId
GROUP BY vd.VD_ProdId
ORDER BY vd.VD_ProdId;