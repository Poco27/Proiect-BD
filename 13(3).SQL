-- Actualizare promoțională a prețurilor pentru produsele din categoria 'Electronice'
-- care au vânzări sub media categoriei (reducere 15%)
UPDATE PRODUS
SET pret = pret * 0.85
WHERE id_categorie = (
    SELECT id_categorie 
    FROM CATEGORIE 
    WHERE nume_categorie = 'Electronice'
)
AND id_produs IN (
    SELECT p.id_produs
    FROM PRODUS p
    LEFT JOIN DETALII_COMANDA dc ON p.id_produs = dc.id_produs
    WHERE p.id_categorie = (
        SELECT id_categorie 
        FROM CATEGORIE 
        WHERE nume_categorie = 'Electronice'
    )
    GROUP BY p.id_produs
    HAVING NVL(SUM(dc.cantitate), 0) < (
        SELECT AVG(sums.suma_cantitati)
        FROM (
            SELECT SUM(dc2.cantitate) as suma_cantitati
            FROM PRODUS p2
            LEFT JOIN DETALII_COMANDA dc2 ON p2.id_produs = dc2.id_produs
            WHERE p2.id_categorie = (
                SELECT id_categorie 
                FROM CATEGORIE 
                WHERE nume_categorie = 'Electronice'
            )
            GROUP BY p2.id_produs
        ) sums
    )
);