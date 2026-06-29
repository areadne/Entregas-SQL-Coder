-- Consulta 1 — Resumen ejecutivo mensual Total facturado, cantidad de pedidos y ticket promedio, agrupados por mes. 
-- Calculá el total como cantidad * precio_unitario. Usá alias descriptivos en español y agrupá por mes con EXTRACT(MONTH FROM fecha_venta).

SELECT * FROM ventas

SELECT 
	MONTH(fecha_venta) AS Mes,
	SUM(cantidad * precio_unitario) as Total_facturado,
	COUNT(id_venta) as Cantidad_de_pedidos,
	AVG(precio_unitario * cantidad) as Ticket_promedio
FROM 
	ventas
GROUP BY 
	MONTH(fecha_venta);


-- Consulta 2 — Ranking de productos Top 5 de id_producto por total facturado, mostrando las unidades vendidas (SUM(cantidad)) 
-- y el total generado. Usá GROUP BY id_producto, ORDER BY y limitá el resultado a 5.

SELECT TOP 5 
	id_producto, 
	SUM(cantidad) as Total_cantidad, 
	SUM(precio_unitario) as Total_compra 
FROM 
	ventas
GROUP BY 
	id_producto
ORDER BY 
	Total_cantidad DESC

-- Consulta 3 — Clientes recurrentes id_cliente que hayan realizado más de un pedido, mostrando la cantidad de pedidos 
-- y el total gastado. Usá GROUP BY id_cliente y HAVING COUNT(*) > 1.

SELECT * FROM ventas;

SELECT 
	id_cliente, 
	COUNT(id_venta) as Ventas_totales_cliente, 
	SUM(cantidad) as Cantidad_total_productos, 
	SUM(precio_unitario) as Suma_precio_unitario,
	SUM(cantidad) * SUM(precio_unitario) as Venta_total
FROM 
	ventas
GROUP BY 
	id_cliente
HAVING 
	COUNT(*) > 1

--Consulta 4 — Meses por encima/por debajo del promedio Total facturado por mes, con una columna adicional que etiquete con 
-- CASE WHEN si ese mes quedó 'Por encima' o 'Por debajo' del promedio mensual general.


SELECT 
	MONTH(fecha_venta) AS Mes,
	SUM(cantidad * precio_unitario) AS Total_facturado,
	COUNT(id_venta) AS Cantidad_de_pedidos,
	AVG(precio_unitario) AS Ticket_promedio,
	CASE
		WHEN SUM(cantidad * precio_unitario) > AVG(precio_unitario * cantidad) THEN 'Por encima'
		WHEN SUM(cantidad * precio_unitario) < AVG(precio_unitario * cantidad) THEN 'Por debajo'
		ELSE 'Revisar'
	END as Analisis
FROM 
	ventas
GROUP BY 
	MONTH(fecha_venta);