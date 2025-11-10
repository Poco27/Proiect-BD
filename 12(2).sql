--Cerință: Afișați vânzările pe categorii de produse, pe luni, cu detaliere a numărului de produse vândute și valoarea totală, doar pentru categoriile cu vânzări peste media pe categorii.
-- Elemente utilizate:
-- b) Subcerere nesincronizată în FROM
-- c) Grupări și filtrare la nivel de grupuri cu HAVING
-- e) Funcții pe date (EXTRACT, TO_CHAR) și CASE
-- f) Bloc WITH

WITH VanzariCategorii AS (
    SELECT 
        cat.nume_categorie,
        TO_CHAR(co.data, 'YYYY-MM') AS luna,
        SUM(dc.cantitate) AS nr_produse,
        SUM(dc.cantitate * dc.pret_unitar) AS valoare_totala
    FROM 
        CATEGORIE cat
    JOIN 
        PRODUS p ON cat.id_categorie = p.id_categorie
    JOIN 
        DETALII_COMANDA dc ON p.id_produs = dc.id_produs
    JOIN 
        COMANDA co ON dc.id_comanda = co.id_comanda
    GROUP BY 
        cat.nume_categorie, TO_CHAR(co.data, 'YYYY-MM')
)
SELECT 
    nume_categorie,
    luna,
    nr_produse,
    valoare_totala,
    CASE 
        WHEN valoare_totala > 1000 THEN 'Ridicat'
        WHEN valoare_totala > 500 THEN 'Mediu'
        ELSE 'Scăzut'
    END AS nivel_vanzi
FROM 
    VanzariCategorii
WHERE 
    nume_categorie IN (
        SELECT nume_categorie 
        FROM VanzariCategorii 
        GROUP BY nume_categorie 
        HAVING SUM(valoare_totala) > (SELECT AVG(valoare_totala) FROM VanzariCategorii)
    )
ORDER BY 
    nume_categorie, luna;
SELECT
p.nume,
co.id_comanda,
FROM PRODUS p
JOIN COMANDA co on 
