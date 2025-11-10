-- Șterge clienții care nu au plasat nicio comandă în ultimele 12 luni
DELETE FROM PLATA
WHERE id_comanda IN (
    SELECT co.id_comanda
    FROM COMANDA co
    WHERE co.id_client IN (
        SELECT c.id_client
        FROM CLIENT c
        WHERE c.id_client NOT IN (
            SELECT DISTINCT co2.id_client
            FROM COMANDA co2
            WHERE co2.data >= ADD_MONTHS(SYSDATE, -12)
        )
        AND c.data_inregistrare < ADD_MONTHS(SYSDATE, -12)
    )
);

DELETE FROM DETALII_COMANDA
WHERE id_comanda IN (
    SELECT co.id_comanda
    FROM COMANDA co
    WHERE co.id_client IN (
        SELECT c.id_client
        FROM CLIENT c
        WHERE c.id_client NOT IN (
            SELECT DISTINCT co2.id_client
            FROM COMANDA co2
            WHERE co2.data >= ADD_MONTHS(SYSDATE, -12)
        )
        AND c.data_inregistrare < ADD_MONTHS(SYSDATE, -12)
    )
);

DELETE FROM COMANDA
WHERE id_client IN (
    SELECT c.id_client
    FROM CLIENT c
    WHERE c.id_client NOT IN (
        SELECT DISTINCT co.id_client
        FROM COMANDA co
        WHERE co.data >= ADD_MONTHS(SYSDATE, -12)
    )
    AND c.data_inregistrare < ADD_MONTHS(SYSDATE, -12)
);

DELETE FROM CLIENT
WHERE id_client NOT IN (
    SELECT DISTINCT co.id_client
    FROM COMANDA co
    WHERE co.data >= ADD_MONTHS(SYSDATE, -12)
)
AND data_inregistrare < ADD_MONTHS(SYSDATE, -12);
