--Cerință: Identificați clienții care au cheltuit peste media totală a tuturor clienților, afișând detaliile lor și suma totală cheltuită, ordonați descrescător după valoarea totală.
-- Elemente utilizate:
-- a) Subcerere sincronizată cu 3 tabele (CLIENT, COMANDA, PLATA)
-- d) Ordonare și funcția NVL
-- c) Grupări de date și filtrare la nivel de grupuri

WITH CheltuieliClienti AS (
    SELECT 
        c.id_client,
        c.nume,
        NVL(SUM(p.valoare), 0) AS total_cheltuit
    FROM 
        CLIENT c
    LEFT JOIN 
        COMANDA co ON c.id_client = co.id_client
    LEFT JOIN 
        PLATA p ON co.id_comanda = p.id_comanda
    GROUP BY 
        c.id_client, c.nume
)
SELECT 
    id_client,
    nume,
    total_cheltuit
FROM 
    CheltuieliClienti
WHERE 
    total_cheltuit > (SELECT AVG(total_cheltuit) FROM CheltuieliClienti)
ORDER BY 
    total_cheltuit DESC;