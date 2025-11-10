-- Cerință: Lista plăților cu detalii despre tipul de plată și statusul comenzii
-- Elemente utilizate:
-- d) Funcțiile NVL și DECODE în cadrul aceleiași cereri
-- e) Funcții pe șiruri de caractere (TO_CHAR pentru formatare)
-- e) Funcții pe date (TO_DATE pentru conversie)

SELECT 
    p.id_plata,
    c.nume AS client,
    TO_CHAR(p.data_plata, 'DD-MM-YYYY HH24:MI') AS data_ora_plata,
    p.valoare,

    DECODE(p.tip_plata,
        'card', 'Card bancar',
        'ramburs', 'Ramburs la livrare',
        'transfer', 'Transfer bancar',
        'Alta metoda') AS metoda_plata_descriere,
    NVL(co.status, 'Necunoscut') AS status_comanda,
    DECODE(NVL(co.status, 'Necunoscut'),
        'livrata', 'Comanda finalizata',
        'procesare', 'In curs de procesare',
        'anulata', 'Comanda anulata',
        'Necunoscut') AS status_comanda_descriere
FROM 
    PLATA p
JOIN 
    COMANDA co ON p.id_comanda = co.id_comanda
JOIN 
    CLIENT c ON co.id_client = c.id_client
ORDER BY 
    p.data_plata DESC;