-- Consulta 1 — Resumen ejecutivo mensual Total facturado, cantidad de pedidos y ticket promedio, agrupados por mes. 
-- Calculá el total como cantidad * precio_unitario. Usá alias descriptivos en español y agrupá por mes con EXTRACT(MONTH FROM fecha_venta).

SELECT 
    EXTRACT(MONTH FROM fecha_venta) AS Mes,
    SUM(cantidad * precio_unitario) AS Total_facturado,
    COUNT(id_venta) AS Cantidad_de_pedidos,
    SUM(cantidad * precio_unitario) / COUNT(id_venta) AS Ticket_promedio
FROM 
    ventas
GROUP BY 
    EXTRACT(MONTH FROM fecha_venta);

-- Consulta 2 — Ranking de productos Top 5 de id_producto por total facturado, mostrando las unidades vendidas (SUM(cantidad)) 
-- y el total generado. Usá GROUP BY id_producto, ORDER BY y limitá el resultado a 5.

SELECT
	id_producto, 
	SUM(cantidad) as Total_cantidad, 
	SUM(precio_unitario) as Total_compra 
FROM 
	ventas
GROUP BY 
	id_producto
ORDER BY 
	Total_cantidad DESC
LIMIT 5;

-- Consulta 3 — Clientes recurrentes id_cliente que hayan realizado más de un pedido, mostrando la cantidad de pedidos 
-- y el total gastado. Usá GROUP BY id_cliente y HAVING COUNT(*) > 1.

SELECT 
	id_cliente, 
	COUNT(id_venta) as Ventas_totales_cliente, 
	SUM(cantidad) as Cantidad_total_productos, 
	SUM(precio_unitario) as Suma_precio_unitario,
	SUM(cantidad * precio_unitario) as Venta_total
FROM 
	ventas
GROUP BY 
	id_cliente
HAVING 
	COUNT(*) > 1;

--Consulta 4 — Meses por encima/por debajo del promedio Total facturado por mes, con una columna adicional que etiquete con 
-- CASE WHEN si ese mes quedó 'Por encima' o 'Por debajo' del promedio mensual general.


WITH ResumenMensual AS (
    -- 1. Primero agrupamos por mes y obtenemos los totales limpios
    SELECT 
        MONTH(fecha_venta) AS Mes,
        SUM(cantidad * precio_unitario) AS Total_facturado,
        COUNT(id_venta) AS Cantidad_de_pedidos,
        -- Ticket promedio real: Total facturado / cantidad de pedidos del mes
        SUM(cantidad * precio_unitario) / COUNT(id_venta) AS Ticket_promedio
    FROM 
        ventas
    GROUP BY 
        MONTH(fecha_venta)
),
PromedioGeneral AS (
    -- 2. Subconsulta para obtener el promedio mensual general de TODA la tabla
    SELECT AVG(Total_facturado) AS Promedio_Mensual_Global
    FROM ResumenMensual
)
-- 3. Consulta final donde se integra la comparación con el CASE WHEN
SELECT 
    r.Mes,
    r.Total_facturado,
    r.Cantidad_de_pedidos,
    r.Ticket_promedio,
    CASE
        WHEN r.Total_facturado > p.Promedio_Mensual_Global THEN 'Por encima'
        WHEN r.Total_facturado < p.Promedio_Mensual_Global THEN 'Por debajo'
        ELSE 'Igual al promedio'
    END AS Analisis
FROM 
    ResumenMensual r
CROSS JOIN 
    PromedioGeneral p;

-- Hallazgos
-- 1. Cada cliente ha hecho al menos dos compras. Son clientes recurrentes. Se podrian obtener sus datos de correos y correr campañas de marketing con productos para incentivar la compra.

-- 2. El mouse inalambrico es el producto con más compras en el mes 3.

-- 3. El total facturado el mes 3 está por encimad el ticket promedio, sin embargo, falta información de más meses para hacer un análisis más robusto.
