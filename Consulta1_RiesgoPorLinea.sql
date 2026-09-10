SELECT 
    s.sector,
    l.linea_credito,
    h.Tasa_de_morosidad,
    h.Cartera_en_riesgo_millones
FROM HECHOS_Riesgo h
JOIN DIM_Sector s ON h.id_sector = s.id_sector
JOIN DIM_LineaCredito l ON h.id_linea = l.id_linea
WHERE h.Fecha = '2026-04-01'
ORDER BY h.Cartera_en_riesgo_millones DESC;