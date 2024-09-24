# 📊 Temas 
- [Objetivo](#objetivo)
- [Equipo](#equipo)
- [Herramientas](#herramientas)
- [Lenguajes](#lenguajes)
- [Procesamiento y análisis](#procesamiento-y-análisis)
- [Análisis exploratorio](#análisis-exploratorio)
- [Resultados](#resultados)
- [Conclusiones](#conclusiones)
- [Recomendaciones](#recomendaciones)
- [Enlaces](#enlaces)

## Objetivo
Diseñar e implementar un sistema ETL eficiente que permita a Superstore gestionar grandes volúmenes de datos dispersos, optimizando el almacenamiento y la estructura de los datos para facilitar su análisis. A través de la creación de un sistema jerárquico con tablas de hechos y dimensiones.

## Equipo
Jaqueline Mera

## Herramientas
- Google BigQuery
- Google Colab
- Google Looker Studio

## Lenguajes
- SQL
- Python

## Procesamiento y análisis

### Conectar/importar datos a otras herramientas
- Se han importado los datos de Superstore a una tabla dentro del ambiente de BigQuery.

### Identificar y manejar valores nulos
- Se identificaron valores nulos a través de comandos SQL, `COUNTIF` y `IS NULL`. No se encontraron nulos.

### Identificar y manejar valores duplicados
- Se han buscado valores duplicados utilizando comandos SQL, `COUNT`, `GROUP BY` y `HAVING`. No se encontraron duplicados en las transacciones (por row). Sin embargo, se identificó que `order_id` se repite en diferentes clientes (`customer_id`), por lo que no se puede considerar `order_id` como identificador único por orden.

### Identificar y manejar datos discrepantes en variables categóricas
- Se han buscado datos discrepantes en variables categóricas utilizando comandos SQL, como `SELECT DISTINCT`. No se encontraron datos discrepantes, y la tabla mantiene congruencia en el formato de las columnas categóricas.

### Identificar y manejar datos discrepantes en variables numéricas
- Se han buscado datos discrepantes en variables numéricas utilizando comandos SQL, como `COUNT`, `ARRAY_AGG`, `SAFE_CAST`. No se encontraron datos discrepantes, y la tabla mantiene congruencia en el formato de las columnas numéricas (`INTEGER` o `FLOAT`).

### Comprobar y cambiar tipo de dato
- Se cambió el tipo de dato de las columnas `order_date` y `ship_date` de formato `TIMESTAMP` a formato `DATE`.

### Buscar datos de otras fuentes
- Se realizó web scraping para extraer información de sitios web. Este proceso se llevó a cabo en Google Colab utilizando el paquete `Beautiful Soup` de Python. La tabla obtenida es la lista de cadenas de supermercados multinacionales de Wikipedia. [Lista de supermercados](https://en.wikipedia.org/wiki/List_of_supermarket_chains).

### Diseñar estructura de la base de datos
- El diseño de la estructura de la base de datos partió del diccionario de datos para identificar entidades, atributos y relaciones. El diagrama se construyó en dbdiagram.io.

#### Tabla de hechos (sales_superstore)
- Contiene los datos transaccionales clave para el análisis de ventas en la Superstore, registrando información sobre cada venta realizada. Incluye detalles como el cliente (`customer_id`), el producto (`product_id`), el mercado (`market_id`), la cantidad de productos comprados, el total de ventas, descuentos aplicados, beneficios obtenidos, costos de envío y el año de la transacción.

#### Dimensión de órden (dim_order)
- Incluye información detallada sobre los pedidos, como fechas de pedido y envío, modo de envío, ciudad y región. Incluye `order_id` y `customer_id`, a partir de los cuales se genera el ID único de `ticket_id`.

#### Dimensión de cliente (dim_customer)
- Describe a los clientes, con datos como su nombre y segmento de mercado.

#### Dimensión de productos (dim_product)
- Proporciona detalles de los productos, como nombre, categoría y subcategoría.

#### Dimensión de mercado (dim_market)
- Contiene información geográfica de los mercados, incluyendo estado, país y mercado asignado.

## Crear estructura de la base de datos
- En el entorno de BigQuery, se generaron las tablas de hechos y dimensiones previamente mencionadas. Se utilizaron comandos SQL como `CREATE OR REPLACE TABLE`. A continuación se mencionan los detalles de cada tabla:

- **Tabla dim_order**: La tabla contiene 25,754 órdenes, es decir, eventos de compra. Para esta tabla se construyó el `ticket_id` que se deriva de `order_id` y `customer_id`. Además, las columnas de `order_date` y `ship_date` cambian de tipo de dato de `TIMESTAMP` a `DATE`.  
- **Tabla dim_customer**: La tabla contiene 4,873 clientes.
- **Tabla dim_product**: La tabla identifica 10,768 productos, que se dividen en 3 categorías y 17 subcategorías.
- **Tabla dim_market**: La tabla identifica 1,126 estados donde se encuentra Superstore. Se construyó el `market_id` a partir de la concatenación de estado y país.
- **Tabla hechos (sales_superstore)**: La tabla contiene 51,290 transacciones.
- **Tabla competencia**: Contiene 374 compañías multinacionales que fungen alrededor del mundo como cadenas de supermercado. Se le asignó un `competence_id`, que es un número incremental más el nombre de la compañía.

Para ver la construcción de las tablas de hechos y dimensiones:

## Programar actualizaciones de tabla

#### Estrategia General de Actualización

- **Actualización de tablas de dimensiones primero, hechos después**: Primero se actualizan las tablas de dimensiones (`dim_order`, `dim_customer`, `dim_product`, `dim_market`), ya que las tablas de hechos dependen de las dimensiones para sus relaciones. Esto asegura que cualquier nueva información o cambio en los datos de referencia (como clientes o productos) esté disponible antes de cargar los datos en la tabla de hechos.
  
- **Actualización incremental**: Implementar cargas incrementales tanto para las dimensiones como para los hechos. Esto significa que solo se cargarán los nuevos registros o aquellos que han cambiado desde la última actualización, en lugar de recargar toda la tabla, lo cual es más eficiente en términos de tiempo y recursos.
  
- **Detección de cambios**: Usar técnicas de CDC (Change Data Capture) o marcas de tiempo para detectar cambios y actualizar únicamente los registros modificados. Esto puede implementarse fácilmente en BigQuery utilizando consultas basadas en `MERGE` o `INSERT` con `WHERE NOT EXISTS`.

## Esquema de Actualización para cada Tabla

1. **Tabla de Dimensiones: dim_order**  
   - Frecuencia de actualización: Diaria.  
   - Proceso: Cargar nuevos pedidos y actualizar los existentes en base al `ticket_id`.  
   - Estrategia: 
     - Verifica si ya existe un registro con el mismo `ticket_id`.
     - Si no existe, inserta el nuevo registro.
     - Si existe, actualiza los valores.

2. **Tabla de Dimensiones: dim_customer**  
   - Frecuencia de actualización: Diaria.
   - Proceso: Actualizar los datos de los clientes y sus segmentos si se ha modificado la información.
   - Estrategia: Verificar si el `customer_id` ya existe y realizar actualizaciones si es necesario.

3. **Tabla de Dimensiones: dim_product**  
   - Frecuencia de actualización: Semanal o mensual.
   - Proceso: Cargar nuevos productos o actualizaciones de productos existentes.
   - Estrategia: Carga incremental basada en el `product_id`.

4. **Tabla de Dimensiones: dim_market**  
   - Frecuencia de actualización: Semanal o mensual.
   - Proceso: Similar a las otras tablas de dimensiones, se cargan los nuevos mercados o se actualizan los existentes.
   - Estrategia: Carga incremental basada en `market_id`.

5. **Tabla de Hechos: tabla_hechos**  
   - Frecuencia de actualización: Diaria.
   - Proceso: Se debe cargar solo la nueva información de ventas. La actualización debe incluir ventas adicionales o correcciones a las transacciones pasadas.
   - Estrategia: Carga incremental basada en el `ticket_id` para insertar nuevas ventas y actualizar las existentes.

### Secuencia recomendada de actualización:
1. Actualizar `dim_market` (si hay cambios en los mercados).
2. Actualizar `dim_customer` (para incluir nuevos clientes).
3. Actualizar `dim_product` (para nuevos productos o categorías).
4. Actualizar `dim_order` (para los nuevos pedidos).
5. Actualizar `tabla_hechos` (las transacciones o ventas).

Este proceso garantiza que las dimensiones estén actualizadas antes de que se realicen las nuevas inserciones en la tabla de hechos, manteniendo la integridad referencial.

## Propuesta de Pipelines para la actualización de datos
- **Pipeline en GCP (Google Cloud Platform)**:
  - Cloud Storage (Ingesta de datos crudos) → Dataproc (Procesamiento de datos) → BigQuery (Modelado de hechos y dimensiones) → Looker Studio (Visualización) → Cloud Composer (Orquestación/Automatización).
  
- **Pipeline Open Source**:
  - Hadoop HDFS (Ingesta de datos crudos) → Apache Spark (Procesamiento) → Hive (Modelado de hechos y dimensiones) → Tableau* (Visualización) → Airflow (Orquestación/Automatización).

*Imagen 2. Propuesta de Pipeline. Hecha en Lucidchart.*

**Nota**: La automatización con Cloud Composer/Apache Airflow debe orquestar la actualización de cada tabla en el orden correcto.

### Unir tablas
Se creó una tabla para el análisis exploratorio a partir de las tablas de hechos y dimensiones utilizando comandos SQL, como `LEFT JOIN`.

