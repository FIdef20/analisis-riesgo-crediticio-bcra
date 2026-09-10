SELECT 
    s.sector,
    YEAR(h.Fecha) AS Anio,
    AVG(h.Tasa_de_morosidad) AS Morosidad_Promedio
FROM HECHOS_Riesgo h
JOIN DIM_Sector s ON h.id_sector = s.id_sector
WHERE YEAR(h.Fecha) >= 2023
GROUP BY s.sector, YEAR(h.Fecha)
ORDER BY s.sector, Anio;