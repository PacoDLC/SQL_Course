-- Subconsultas en SQL

SELECT <lista de campos> FROM <tablas> WHERE <condicion>;

/* Selecciona el ID del producto, la descripción, y el color de la tabla 'productos'.
Además, calcula las 'Total Unidades Vendidas' y el 'Total Ventas Dinero' 
para cada producto sumando las cantidades y precios correspondientes 
de la tabla 'ventas_detalle' que coinciden con el 'Prod_Id' del producto. */
SELECT p.Prod_Id,
		 p.Prod_Descripcion,
		 p.Prod_Color,
		 (SELECT SUM(vd.VD_Cantidad) FROM ventas_detalle vd WHERE vd.VD_ProdId = p.Prod_Id) AS 'Total Unidades Vendidas',
		 (SELECT SUM(vd.VD_Precio) FROM ventas_detalle vd WHERE vd.VD_ProdId = p.Prod_Id) AS 'Total Ventas Dinero'
FROM productos p;

/* Selecciona el ID del producto, la descripción y el color de la tabla 'productos'.
Además, calcula la cantidad de unidades vendidas de la tabla 'ventas_detalle' 
para cada producto cuyo 'Prod_Id' coincida con 'VD_ProdID' y tenga más de 100 unidades vendidas. */
SELECT p.Prod_Id, p.Prod_Descripcion, p.Prod_Color,
	(SELECT COUNT(VD_Cantidad) unidades FROM ventas_detalle WHERE p.Prod_Id = VD_ProdID) 'Unidades Vendidas'
	FROM productos p
		JOIN
			(SELECT VD_ProdId, COUNT(VD_Cantidad) unidades FROM ventas_detalle
				GROUP BY VD_ProdId) v ON p.Prod_Id = v.VD_ProdId AND v.unidades > 100;