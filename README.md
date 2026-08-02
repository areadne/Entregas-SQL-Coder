# RetailPro — Base de Datos Relacional y Análisis de Datos

¡Bienvenido al repositorio del proyecto **RetailPro**! 

Este proyecto contiene el diseño, implementación y scripts de consulta para simular el sistema de gestión de una tienda minorista (*retail*). Aquí se centraliza la información sobre ventas, clientes, inventario y proveedores en un modelo estructurado y fácil de consultar.

---

## Conceptos Clave (Para principiantes en SQL)

Si estás dando tus primeros pasos en el mundo de las bases de datos, estos conceptos te ayudarán a entender la estructura:

* **Base de Datos Relacional:** Es un sistema digital donde la información se organiza en listas interconectadas (tablas).
* **Tabla:** Una lista estructurada con filas (registros) y columnas (atributos), similar a una hoja de cálculo.
* **Clave Primaria / Primary Key (PK):** Un identificador único para cada fila de una tabla (como el RUT o DNI de una persona). Asegura que no existan registros duplicados.
* **Clave Foránea / Foreign Key (FK):** Un campo que conecta una tabla con otra. Por ejemplo, en la tabla de *Ventas* guardamos el ID del *Cliente* para vincular la compra sin repetir toda su información personal.

---

## Estructura de la Base de Datos (Tablas y Atributos)

El modelo **RetailPro** se compone de 6 tablas principales diseñadas para registrar la operación comercial:

```text
       [ Categoria ] ──────1:N─────> [ Producto ] <─────1:N────── [ Proveedor ]
                                          │
                                         1:N
                                          │
 [ Cliente ] ──────1:N─────> [ Ventas ] ──┴── 1:N ───> [ Detalle_Venta ]

```

**Detalle y Atributos de las Tablas
**1. clientes
Descripción: Información personal y de contacto de los compradores.

Atributos:

id_cliente (PK): Identificador único del cliente (ej: 1, 2, 3).

nombre y apellido: Nombre completo.

email: Correo electrónico.

telefono: Número de contacto.

direccion: Dirección de despacho.

fecha_registro: Fecha de alta en el sistema.

2. categorias
Descripción: Clasificación general del catálogo de productos.

Atributos:

id_categoria (PK): Identificador de la categoría.

nombre_categoria: Nombre de la sección (ej: Electrónica, Ropa, Hogar).

descripcion: Detalle de lo que abarca la categoría.

3. proveedores
Descripción: Registro de empresas que suministran los productos.

Atributos:

id_proveedor (PK): Identificador del proveedor.

nombre_proveedor: Nombre de la empresa distribuidora.

contacto: Nombre de la persona de contacto.

telefono y email: Vías de comunicación comercial.

4. productos
Descripción: Catálogo de artículos disponibles y control de inventario.

Atributos:

id_producto (PK): Código del producto.

nombre_producto: Descripción comercial del artículo.

precio: Precio de venta unitario.

stock: Cantidad disponible en bodega.

id_categoria (FK): Categoría a la que pertenece el producto.

id_proveedor (FK): Proveedor que surte el producto.

5. ventas
Descripción: Encabezado general de cada transacción realizada.

Atributos:

id_venta (PK): Número único de comprobante/boleta.

fecha_venta: Fecha y hora de la transacción.

total: Monto final cobrado.

metodo_pago: Forma de pago (Efectivo, Tarjeta, Transferencia).

id_cliente (FK): Cliente que realizó la compra.

6. detalle_ventas
Descripción: Desglose individual de productos incluidos en cada venta.

Atributos:

id_detalle (PK): Identificador único de la línea de detalle.

id_venta (FK): Venta a la que pertenece la línea.

id_producto (FK): Producto comprado.

cantidad: Unidades adquiridas.

precio_unitario: Precio aplicado al momento de la venta.

subtotal: Cálculo de cantidad × precio_unitario.

Estructura del Repositorio
Plaintext
Entregas-SQL-Coder/
├── README.md
├── scripts/
│   ├── 01_schema_creation.sql      # Creación de la base de datos y tablas (DDL)
│   ├── 02_data_insertion.sql       # Inserción de datos de prueba (DML)
│   ├── 03_views.sql                # Vistas analíticas de negocio
│   ├── 04_functions.sql            # Funciones personalizadas
│   ├── 05_stored_procedures.sql    # Procedimientos almacenados
│   └── 06_triggers.sql             # Triggers de auditoría y control
└── docs/
    └── entity_relationship_diagram.png # Diagrama Entidad-Relación (DER)


**Guía de Ejecución de Scripts (Paso a Paso)**
Para poner en marcha la base de datos en tu entorno local (ej. MySQL Workbench o DBeaver), sigue este orden secuencial.

¿Por qué el orden importa? En bases de datos relacionales existen dependencias. No puedes insertar datos en una tabla que no existe, ni vincular una venta a un cliente si la tabla de clientes no se ha creado primero.

Paso 1: Clonar el repositorio
Bash
git clone [https://github.com/areadne/Entregas-SQL-Coder.git](https://github.com/areadne/Entregas-SQL-Coder.git)
cd Entregas-SQL-Coder
Paso 2: Ejecutar los archivos en orden estricto
01_schema_creation.sql — Creación del Esquema y Tablas

¿Qué hace?: Crea la base de datos RetailPro y construye las tablas vacías definiendo sus columnas y relaciones (PK y FK).

02_data_insertion.sql — Población de Datos

¿Qué hace?: Inserta los registros de prueba (clientes, categorías, productos, proveedores y ventas) para dar vida a la base de datos.

03_views.sql — Creación de Vistas

¿Qué hace?: Guarda consultas complejas predefinidas (ej. total de ventas por cliente o productos con poco stock) para consultarlas fácilmente.

04_functions.sql y 05_stored_procedures.sql — Lógica Reutilizable

¿Qué hace?: Compila cálculos automáticos (como el cálculo de impuestos/descuentos) y procesos repetitivos que se pueden invocar cuando se necesiten.

06_triggers.sql — Automatización de Tareas

¿Qué hace?: Configura acciones automáticas que se ejecutan solas (por ejemplo, descontar el stock del producto cada vez que se inserta una fila en detalle_ventas).

**Vistas y Reportes Disponibles
**Una vez ejecutados los scripts, puedes consultar reportes listos para análisis:

vw_ventas_por_cliente: Muestra el historial acumulado de compras por usuario.

vw_top_productos: Presenta los artículos más vendidos.

vw_alertas_inventario: Filtra los productos con bajo stock que necesitan reabastecimiento.

👤 Autora
Areadne Ochoa
