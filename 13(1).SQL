-- Actualizează stocul pentru produsele comandate în luna curentă
-- Scade cantitatea comandată din stocul disponibil
UPDATE STOC s
SET cantitate_disponibila = cantitate_disponibila - (
    SELECT SUM(dc.cantitate)
    FROM DETALII_COMANDA dc
    JOIN COMANDA co ON dc.id_comanda = co.id_comanda
    WHERE dc.id_produs = s.id_produs
    AND EXTRACT(MONTH FROM co.data) = EXTRACT(MONTH FROM SYSDATE)
    AND EXTRACT(YEAR FROM co.data) = EXTRACT(YEAR FROM SYSDATE)
)
WHERE EXISTS (
    SELECT 1
    FROM DETALII_COMANDA dc
    JOIN COMANDA co ON dc.id_comanda = co.id_comanda
    WHERE dc.id_produs = s.id_produs
    AND EXTRACT(MONTH FROM co.data) = EXTRACT(MONTH FROM SYSDATE)
    AND EXTRACT(YEAR FROM co.data) = EXTRACT(YEAR FROM SYSDATE)
);