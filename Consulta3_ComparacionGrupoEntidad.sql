-- Consulta 3 - Comparación entre grupos de entidades
-- Muestra la morosidad de bancos públicos, privados y del sistema total en el último dato,
-- evidenciando su convergencia.

-- Nota de calidad de datos: durante la preparación de esta consulta se detectó que las 204 filas
-- correspondientes a "Bancos privados" en HECHOS_GrupoEntidad tenían el campo id_grupo vacío —
-- un error sistemático, no aleatorio, que hacía que un INNER JOIN excluyera silenciosamente ese
-- grupo del resultado sin arrojar ningún error. Se corrigió completando el id_grupo faltante
-- (id_grupo = 2) tras confirmar que las fechas de esas filas coinciden exactamente con las de
-- los otros dos grupos.

SELECT
    g.grupo_entidad,
    h.Tasa_de_morosidad
FROM HECHOS_GrupoEntidad h
JOIN DIM_GrupoEntidad g ON h.id_grupo = g.id_grupo
WHERE h.Fecha = (SELECT MAX(Fecha) FROM HECHOS_GrupoEntidad)
ORDER BY h.Tasa_de_morosidad DESC;

-- Resultado: los tres grupos aparecen prácticamente empatados en torno al 7%,
-- confirmando la transversalidad del riesgo.
--   Bancos privados        7,02%
--   Sistema financiero total  6,99%
--   Bancos públicos         6,89%
