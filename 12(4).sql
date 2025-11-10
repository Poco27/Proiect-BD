-- Cerință: Lista clienților cu numărul de comenzi și suma cheltuită, ordonată descrescător
-- Elemente utilizate conform cerinței:
-- a) Subcerere sincronizată implicita (JOIN între CLIENT, COMANDA, PLATA - 3 tabele)
-- c) Grupări de date (GROUP BY) și funcții grup (COUNT, SUM)
-- d) Ordonare (ORDER BY) și funcția NVL
-- e) Funcție pe șiruri (concatenație implicită în SELECT)

SELECT 
    c.id_client,
    c.nume AS nume_client,
    c.email,
    COUNT(co.id_comanda) AS numar_comenzi,
    NVL(SUM(p.valoare), 0) AS suma_totala_cheltuita
FROM 
    CLIENT c
LEFT JOIN 
    COMANDA co ON c.id_client = co.id_client
LEFT JOIN 
    PLATA p ON co.id_comanda = p.id_comanda
GROUP BY 
    c.id_client, c.nume, c.email
ORDER BY 
    suma_totala_cheltuita DESC;