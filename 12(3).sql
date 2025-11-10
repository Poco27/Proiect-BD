--Cerință: Identificați produsele care se află în top 3 în fiecare categorie după valoarea totală a vânzărilor, cu detaliere a stocului rămas.
-- Elemente utilizate:
-- a) Subcerere sincronizată cu 3 tabele (PRODUS, DETALII_COMANDA, CATEGORIE)
-- d) DECODE pentru afișare status stoc
-- e) Funcții pe șiruri (UPPER, SUBSTR)

SELECT 
    p.nume AS produs,
    UPPER(SUBSTR(c.nume_categorie, 1, 3)) AS cod_categorie,
    SUM(dc.cantitate * dc.pret_unitar) AS valoare_totala,
    s.cantitate_disponibila,
    DECODE(
        SIGN(s.cantitate_disponibila - 10),
        1, 'Suficient',
        0, 'Limita',
        -1, 'Necesită reaprovizionare'
    ) AS status_stoc
FROM 
    PRODUS p
JOIN 
    CATEGORIE c ON p.id_categorie = c.id_categorie
JOIN 
    DETALII_COMANDA dc ON p.id_produs = dc.id_produs
JOIN 
    STOC s ON p.id_produs = s.id_produs
WHERE 
    p.id_produs IN (
        SELECT id_produs FROM (
            SELECT 
                p.id_produs,
                RANK() OVER (PARTITION BY p.id_categorie ORDER BY SUM(dc.cantitate * dc.pret_unitar) DESC) AS rang
            FROM 
                PRODUS p
            JOIN 
                DETALII_COMANDA dc ON p.id_produs = dc.id_produs
            GROUP BY 
                p.id_produs, p.id_categorie
        ) 
        WHERE rang <= 3
    )
GROUP BY 
    p.nume, c.nume_categorie, s.cantitate_disponibila
ORDER BY 
    c.nume_categorie, valoare_totala DESC;