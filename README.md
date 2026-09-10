# Riesgo de Cartera del Sistema Financiero Argentino (2002-2026)
### Un análisis del deterioro crediticio: de la crisis de la convertibilidad a la crisis de ingresos actual

## Resumen ejecutivo

Este análisis procesa el Anexo Estadístico del BCRA (2002-2026, 2.768 registros en 6 tablas) para responder **dónde se concentra hoy el riesgo de deterioro crediticio en Argentina**.

**Hallazgos principales:**

1. **El riesgo se concentra en los hogares, no en las empresas.** La morosidad ponderada de las familias alcanzó 12,1% frente a 3,3% en empresas — una brecha de 8,75 puntos porcentuales. Un z-score de 4,64 (p<0,0001) contra la distribución histórica 2010-2023 confirma que se trata de un cambio estructural, no una fluctuación normal.
2. **El riesgo está concentrado, no disperso.** Préstamos personales y tarjetas de crédito representan el 73,2% del riesgo de los hogares medido en pesos.
3. **El fenómeno es transversal al sistema.** Bancos públicos y privados convergen en ~7% de morosidad — a diferencia de la crisis de 2002, donde la banca pública se distanciaba de la privada por 5 puntos.
4. **Medir el riesgo exige ponderar por volumen.** El promedio simple (14,8%) sobreestima el riesgo real frente al ponderado (12,1%).

**Cartera total en riesgo del sistema: $10,77 billones.**

**Lectura de conjunto:** no es una crisis financiera al estilo 2002 — es la contracara crediticia de una crisis de ingresos de los hogares.

---

## Stack técnico

- **SQL Server** — modelado dimensional (esquema estrella) y consultas analíticas
- **Power Query** — transformación de datos ancho → largo (unpivot), limpieza y consolidación
- **DAX / Power BI** — medidas calculadas (morosidad ponderada) y dashboard interactivo
- **Estadística aplicada** — cálculo de z-score para validar significancia del hallazgo central

## Fuente de datos

Anexo Estadístico del Informe sobre Bancos, publicación mensual del **Banco Central de la República Argentina (BCRA)**, de acceso público. Serie completa diciembre 2002 – abril 2026.

## Proceso

1. **Transformación (Power Query):** el dato original viene en formato de reporte (bloques apilados, fechas como columnas) — no apto para análisis. Se aplicó unpivot y consolidación hasta llegar a un modelo tidy de 6 tablas.
2. **Modelado (SQL Server):** esquema estrella con 2 tablas de hechos (HECHOS_Riesgo, HECHOS_GrupoEntidad) y 4 dimensiones, con integridad referencial garantizada por claves foráneas.
3. **Métrica derivada:** `Cartera en riesgo = Saldo × Tasa de morosidad`, para medir el riesgo en pesos comprometidos y no solo como porcentaje.
4. **Control de calidad:** se detectó y corrigió un error sistemático — 204 filas de "Bancos privados" con `id_grupo` vacío, que un INNER JOIN excluía silenciosamente sin arrojar error. Se validó y corrigió cruzando fechas contra los otros grupos.
5. **Visualización (Power BI):** dashboard con KPIs destacados, jerarquía visual orientada al hallazgo, y segmentadores interactivos por año y sector.

## Contenido de este repositorio

- `dashboard.pbix` — dashboard interactivo de Power BI
- `queries.sql` — consultas SQL documentadas (ranking de riesgo por línea de crédito, evolución interanual, comparación entre grupos de entidades)
- `/capturas` — modelo de datos, EDA y vistas del dashboard

---

*Proyecto integrador final — Data Analytics, Coderhouse (calificación 95/100).*
