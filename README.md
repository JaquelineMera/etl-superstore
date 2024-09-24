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
- [Dashboard](#dashboard)

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
El proceso de los datos, tomo en cuenta cada una de las etapas de Sistema ETL (Extract, Transform y Load)
- Extracción: esta etapa consiste en recolectar datos de diferentes fuentes, como bases de datos, archivos o APIs.
- Ttransformación: implica convertir, limpiar y estructurar los datos según las reglas y necesidades del negocio.
- Carga: inserción de los datos transformados en un sistema de almacenamiento, como un data warehouse.

## Extracción 
El proceso de extracción para este proyecto se llevó a cabo a partir de la Flat table de Superstore, que tiene de origen un archivo csv además se realizó Web scraping para obtener información de sitios web sobre la competencia de Superstore.
### Web scraping: Buscar datos de otras fuentes
- Se realizó web scraping para extraer información de sitios web. Este proceso se llevó a cabo en Google Colab utilizando el paquete `Beautiful Soup` de Python. La tabla obtenida es la lista de cadenas de supermercados multinacionales de Wikipedia. [Lista de supermercados](https://en.wikipedia.org/wiki/List_of_supermarket_chains).

## Transformación
El proceso de Transformación consistió en el procesamiento y la limpieza de los datos.
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

## Diseño y Carga de la base de datos
A partir del diccionario de datos de Superstore se diseñó la estructura de la base de datos identificando entidades, atributos y relaciones. Mientras que en el proceso de carga se generaron las tablas de hechos y dimensiones en BigQuery, utilizando comandos SQL como `CREATE OR REPLACE TABLE`.

### Diseñar estructura de la base de datos
- El diseño de la estructura de la base de datos partió del diccionario de datos para identificar entidades, atributos y relaciones. El diagrama se construyó en dbdiagram.io.
![superstore](https://github.com/user-attachments/assets/722e13a0-f1f3-417e-ab9e-0ff7c0051102)
*Imagen 1. Propuesta de Diagrama estrella para Superstore. Hecha en dbdiagram.io.*
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

## Propuestas de Pipelines para la actualización de datos
Se proponen dos pipelines para la actualización de datos en Superstore.
Se proponen un pipeline en GCP, es decir con los servicios Google Cloud Plataform y un pipeline Open Sources. Ambos pipelines incluyen etapas de ingesta de donde se extraerá la información, una etapa de procesamiento, donde se transformará la data, y por último una etapa de carga donde se llevará a cabo el modelado de datos, está propuesta de pipeline también incluye la visualización, orquestación y automatización del mismo pipeline. 
- **Pipeline en GCP (Google Cloud Platform)**:
  - Cloud Storage (Ingesta de datos crudos) → Dataproc (Procesamiento de datos) → BigQuery (Modelado de hechos y dimensiones) → Looker Studio (Visualización) → Cloud Composer (Orquestación/Automatización).
  
- **Pipeline Open Source**:
  - Hadoop HDFS (Ingesta de datos crudos) → Apache Spark (Procesamiento) → Hive (Modelado de hechos y dimensiones) → Tableau* (Visualización) → Airflow (Orquestación/Automatización).
![Pipeline_GCP_OS](https://github.com/user-attachments/assets/57ab176f-bc96-4dad-b82c-aed51f2bf260)
*Imagen 2. Propuesta de Pipeline. Hecha en Lucidchart.*

**Nota**: La automatización con Cloud Composer/Apache Airflow debe orquestar la actualización de cada tabla en el orden correcto.

### Unir tablas
Se creó una tabla para el análisis exploratorio a partir de las tablas de hechos y dimensiones utilizando comandos SQL, como `LEFT JOIN`.

## Análisis exploratorio

- **Agrupar datos**: Se agruparon los datos según variables categóricas (Ventas y Ganancias) para identificar patrones y tendencias.
- **Visualizar las variables categóricas**: Se crearon gráficos (Ventas y Ganancias, por tipo de cliente, categoría, mercado y productos)para obtener una mejor comprensión de los datos.
- **Aplicar medidas de tendencia central y dispersión**: Se calcularon estadísticas como la media, mediana, rango y desviación estándar para Ventas, Ganancias, Costos de envío y Descuentos.
- **Visualizar distribución**: Se crearon diagramas de dispersión (Ventas vs Ganancias vs Costo de envío).
- **Visualizar el comportamiento de los datos a lo largo del tiempo**: Se crearon gráficos para observar datos a través de los años (Ventas y Ganancias).

**Nota**: Para observar el análisis exploratorio, revisar el Dashboard en los apartados EDA.

## Resultados

### Resultados Superstore
- **Ventas globales**:
  - Total de ventas: $12.6 millones con una ganancia de $1.5 millones, representando un margen de ganancia aproximado del 11.9%.
  - Transacciones: Se han registrado 51,290 transacciones con un ticket promedio de $245.88 y un promedio de 7 unidades vendidas por ticket (basado en 178,312 productos vendidos).

- **Segmentación**:
  - **Consumer**: Representa el mayor segmento, con el 51.7% de las ventas ($6.5 millones) y ganancias de $749.2 mil.
  - **Corporate**: Contribuye con el 30.1% de las ventas ($3.8 millones) y $441.2 mil de ganancias.
  - **Home Office**: Menor participación (18.2%) con $2.3 millones de ventas y $227 mil de ganancias.

- **Evolución temporal**:
  - Crecimiento constante: Las ventas aumentaron año tras año desde 2011 ($2.3M) hasta 2014 ($4.3M). Las ganancias también crecieron proporcionalmente, mostrando un buen control sobre los costos.
  - Costos de envío: Los costos de envío han crecido un 88% entre 2011 ($244.3K) y 2014 ($460.5K), lo que podría estar impactando las ganancias si no se gestionan adecuadamente.

- **Ventas por región**:
  - **APAC** lidera con $3.6 millones en ventas y $437.5 mil en ganancias, seguido por la **UE** y **EEUU**.
  - **LATAM** se destaca con $2.2 millones de ventas, pero sus ganancias ($221.6 mil) son más bajas que otras regiones, lo que podría sugerir márgenes menores.
  - **Canadá** es el mercado más pequeño con $66.9 mil en ventas y $17.8 mil de ganancias.

- **Ventas por categoría**:
  - **Technology** es la categoría con más ventas ($4.7 millones) y ganancias ($663.8 mil), mostrando su popularidad y rentabilidad.
  - **Office Supplies** y **Furniture** también son fuertes en ventas y ganancias, aunque **Furniture** tiene un margen de ganancia más bajo.

- **Subcategorías clave**:
  - **Phones** y **Copiers** son las subcategorías más vendidas, y **Copiers** tiene el mayor margen de ganancia ($258K).
  - **Chairs** también es una subcategoría destacada en ventas, pero su margen de ganancia es menor comparado con **Copiers** y **Phones**.

### Resultados del Pipeline de Actualización
En el proyecto de ETL para Superstore, se ha implementado un pipeline sólido que integra la ingesta, transformación y almacenamiento de datos con el uso eficiente de BigQuery para el manejo de tablas de hechos y dimensiones. El pipeline permite una actualización eficiente, utilizando cargas incrementales y procesos automatizados, minimizando la carga computacional y asegurando que solo los datos nuevos o modificados sean procesados.

## Conclusiones

### Conclusiones Superstore
- **Segmento Consumer como motor principal**: Este segmento genera más de la mitad de las ventas y ganancias, pero la proporción de ganancias (11.5%) es algo menor que en los otros segmentos, lo que sugiere oportunidades de mejora en eficiencia o precios.
- **Crecimiento sólido pero con aumento de costos**: El crecimiento de las ventas ha sido consistente, pero los costos de envío han aumentado significativamente. Se debe investigar cómo optimizar estos costos para mantener márgenes saludables.
- **Disparidades regionales**: APAC y la UE son los mercados más rentables, mientras que LATAM muestra un margen más bajo. Podría ser útil investigar factores locales que afectan las ganancias en LATAM.
- **Categorías tecnológicas dominantes**: Los productos de tecnología no solo son los más vendidos, sino que también tienen un margen alto. Sin embargo, otras categorías como muebles, aunque generan muchas ventas, tienen márgenes más bajos.

### Conclusión del Pipeline de Actualización
El pipeline asegura la integridad referencial al actualizar las dimensiones antes que los hechos, optimizando el rendimiento del proceso de carga. El diseño de cargas incrementales y automatización minimiza la carga computacional, asegurando que los datos estén listos para su análisis.

## Recomendaciones

### Recomendaciones Superstore
- **Optimización de costos de envío**: Considerar negociaciones con proveedores de logística o la implementación de estrategias de distribución más eficientes para reducir los costos de envío que han crecido considerablemente.
- **Revisar precios en LATAM**: Dado que las ventas son fuertes, pero las ganancias son relativamente bajas, podría ser recomendable ajustar los precios o reducir costos en LATAM para mejorar el margen.
- **Enfoque en subcategorías rentables**: Fortalecer las estrategias de ventas en subcategorías con altos márgenes, como **Copiers** y **Phones**, ya que ofrecen los mayores beneficios. Al mismo tiempo, se debe evaluar cómo mejorar el margen en otras subcategorías como **Chairs**.
- **Estrategias de fidelización en el segmento Consumer**: Dado que este segmento es el más grande, se puede considerar la implementación de programas de fidelización o personalización de ofertas para mantener el crecimiento de ventas y aumentar los márgenes de ganancia.

### Recomendaciones Pipeline
- **Automatización Completa del Pipeline**: Considera implementar Cloud Composer (Airflow) para la orquestación automática de todas las etapas del pipeline, programando actualizaciones diarias, semanales o mensuales según sea necesario.
- **Mejorar el Rendimiento con Particionamiento y Clustering**: Aprovecha el particionamiento en BigQuery, particionando la tabla de hechos por año o fechas de transacción para mejorar el rendimiento de consultas sobre grandes volúmenes de datos.
- **Monitoreo y Alertas**: Implementa un sistema de monitoreo y alertas para asegurar que las cargas y transformaciones de datos se ejecuten correctamente. Herramientas como Google Cloud Monitoring pueden detectar fallos en el pipeline y enviarte notificaciones.
- **Incrementar la Capacidad de Visualización**: Considera expandir el uso de Looker Studio o herramientas adicionales como Tableau si los análisis requieren visualizaciones más complejas.
- **Escalabilidad del Pipeline**: A medida que los volúmenes de datos crezcan, puedes explorar el uso de Dataflow para el procesamiento en streaming, lo que te permitirá manejar datos en tiempo real, adaptando el pipeline para análisis en vivo.
- **Optimización del Almacenamiento**: Revisa periódicamente las tablas de hechos y dimensiones para eliminar registros innecesarios o consolidar datos históricos, evitando que los costos de almacenamiento en BigQuery crezcan desproporcionadamente.

## Dashboard
[Ventas-Superstore](https://lookerstudio.google.com/reporting/031a155d-6e2f-442c-994d-9a260126ade3)

