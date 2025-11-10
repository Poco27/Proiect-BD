-- CATEGORIE
INSERT INTO CATEGORIE VALUES (1, 'Electronice');
INSERT INTO CATEGORIE VALUES (2, 'Haine');
INSERT INTO CATEGORIE VALUES (3, 'Carti');
INSERT INTO CATEGORIE VALUES (4, 'Jucarii');
INSERT INTO CATEGORIE VALUES (5, 'Electrocasnice');

-- CLIENT
INSERT INTO CLIENT VALUES (1, 'Popescu Ana', 'ana.popescu@email.com', 'parola1', TO_DATE('2024-01-10', 'YYYY-MM-DD'));
INSERT INTO CLIENT VALUES (2, 'Ionescu Mihai', 'mihai.ionescu@email.com', 'parola2', TO_DATE('2024-02-15', 'YYYY-MM-DD'));
INSERT INTO CLIENT VALUES (3, 'Stan Maria', 'maria.stan@email.com', 'parola3', TO_DATE('2024-03-20', 'YYYY-MM-DD'));
INSERT INTO CLIENT VALUES (4, 'Dumitru Vlad', 'vlad.dumitru@email.com', 'parola4', TO_DATE('2024-04-25', 'YYYY-MM-DD'));
INSERT INTO CLIENT VALUES (5, 'Georgescu Raluca', 'raluca.georgescu@email.com', 'parola5', TO_DATE('2024-05-30', 'YYYY-MM-DD'));

-- PRODUS
INSERT INTO PRODUS VALUES (1, 'Laptop Lenovo', 3500.00, 1, 'Laptop performant pentru birou');
INSERT INTO PRODUS VALUES (2, 'Rochie vara', 120.50, 2, 'Rochie din bumbac, marimea M');
INSERT INTO PRODUS VALUES (3, 'Harry Potter', 60.00, 3, 'Carte fantasy populara');
INSERT INTO PRODUS VALUES (4, 'Masinuta', 35.00, 4, 'Jucarie pentru copii peste 3 ani');
INSERT INTO PRODUS VALUES (5, 'Mixer Philips', 240.00, 5, 'Mixer de bucatarie cu 5 viteze');

-- COMANDA
INSERT INTO COMANDA VALUES (1, TO_DATE('2024-06-01', 'YYYY-MM-DD'), 1, 'Str. Lalelelor 5, Bucuresti', 'livrata');
INSERT INTO COMANDA VALUES (2, TO_DATE('2024-06-03', 'YYYY-MM-DD'), 2, 'Bd. Libertatii 10, Timisoara', 'procesare');
INSERT INTO COMANDA VALUES (3, TO_DATE('2024-06-05', 'YYYY-MM-DD'), 3, 'Str. Florilor 8, Cluj', 'anulata');
INSERT INTO COMANDA VALUES (4, TO_DATE('2024-06-07', 'YYYY-MM-DD'), 4, 'Aleea Teiului 18, Iasi', 'livrata');
INSERT INTO COMANDA VALUES (5, TO_DATE('2024-06-09', 'YYYY-MM-DD'), 5, 'Str. Zorilor 2, Constanta', 'procesare');

-- STOC
INSERT INTO STOC VALUES (1, 10);
INSERT INTO STOC VALUES (2, 22);
INSERT INTO STOC VALUES (3, 15);
INSERT INTO STOC VALUES (4, 30);
INSERT INTO STOC VALUES (5, 5);

-- PLATA
INSERT INTO PLATA VALUES (1, 1, 3500.00, TO_DATE('2024-06-01', 'YYYY-MM-DD'), 'card');
INSERT INTO PLATA VALUES (2, 2, 120.50, TO_DATE('2024-06-03', 'YYYY-MM-DD'), 'ramburs');
INSERT INTO PLATA VALUES (3, 3, 60.00, TO_DATE('2024-06-05', 'YYYY-MM-DD'), 'card');
INSERT INTO PLATA VALUES (4, 4, 35.00, TO_DATE('2024-06-07', 'YYYY-MM-DD'), 'card');
INSERT INTO PLATA VALUES (5, 5, 240.00, TO_DATE('2024-06-09', 'YYYY-MM-DD'), 'ramburs');

-- DETALII_COMANDA
INSERT INTO DETALII_COMANDA VALUES (1, 1, 1, 3500.00);
INSERT INTO DETALII_COMANDA VALUES (2, 2, 2, 120.50);
INSERT INTO DETALII_COMANDA VALUES (2, 3, 1, 60.00);
INSERT INTO DETALII_COMANDA VALUES (3, 3, 1, 60.00);
INSERT INTO DETALII_COMANDA VALUES (3, 4, 2, 35.00);
INSERT INTO DETALII_COMANDA VALUES (4, 4, 2, 35.00);
INSERT INTO DETALII_COMANDA VALUES (4, 5, 1, 240.00);
INSERT INTO DETALII_COMANDA VALUES (5, 1, 1, 3500.00);
INSERT INTO DETALII_COMANDA VALUES (5, 2, 1, 120.50);
INSERT INTO DETALII_COMANDA VALUES (5, 5, 1, 240.00);
INSERT INTO PRODUS (id_produs, nume, pret, id_categorie, descriere)
VALUES (
    (SELECT NVL(MAX(id_produs), 0) + 1 FROM PRODUS),  -- Generare ID automat
    'Tabletă Samsung Galaxy Tab A8', 
    1299.99, 
    (SELECT id_categorie FROM CATEGORIE WHERE nume_categorie = 'Electronice'), 
    'Tabletă 10.5", 4GB RAM, 64GB storage'
);


INSERT INTO STOC (id_produs, cantitate_disponibila)
VALUES (
    (SELECT MAX(id_produs) FROM PRODUS),  
    25                                   
);


INSERT INTO COMANDA (id_comanda, data, id_client, adresa_livrare, status)
VALUES (
    (SELECT NVL(MAX(id_comanda), 0) + 1 FROM COMANDA),
    SYSDATE,
    (SELECT id_client FROM CLIENT WHERE ROWNUM = 1), 
    'Str. Exemplu nr. 1, București',
    'procesare'
);


INSERT INTO DETALII_COMANDA (id_comanda, id_produs, cantitate, pret_unitar)
VALUES (
    (SELECT MAX(id_comanda) FROM COMANDA),
    (SELECT MAX(id_produs) FROM PRODUS),
    2, 
    1299.99 
);
commit;

DECLARE
  v_next_produs_id NUMBER;
  v_electronice_id NUMBER;
BEGIN
  
  SELECT id_categorie INTO v_electronice_id 
  FROM CATEGORIE 
  WHERE nume_categorie = 'Electronice';
  
  SELECT NVL(MAX(id_produs), 0) + 1 INTO v_next_produs_id FROM PRODUS;
  
  INSERT INTO PRODUS VALUES (
    v_next_produs_id, 
    'Cască wireless Sony WH-1000XM4', 
    1299.99, 
    v_electronice_id, 
    'Căști cu noise cancelling premium'
  );
  INSERT INTO STOC VALUES (v_next_produs_id, 15);
  
  v_next_produs_id := v_next_produs_id + 1;
  INSERT INTO PRODUS VALUES (
    v_next_produs_id,
    'Smartphone Samsung Galaxy S21',
    3499.99,
    v_electronice_id,
    'Telefon flagship cu camera profesională'
  );
  INSERT INTO STOC VALUES (v_next_produs_id, 8);
  
  
  v_next_produs_id := v_next_produs_id + 1;
  INSERT INTO PRODUS VALUES (
    v_next_produs_id,
    'Tabletă Lenovo Tab P11 Pro',
    1999.99,
    v_electronice_id,
    'Tabletă premium cu display OLED'
  );
  INSERT INTO STOC VALUES (v_next_produs_id, 10);
  
  
  INSERT INTO DETALII_COMANDA VALUES (1, v_next_produs_id-2, 1, 1299.99);
  INSERT INTO DETALII_COMANDA VALUES (2, v_next_produs_id-2, 1, 1299.99);
  
  
  INSERT INTO DETALII_COMANDA VALUES (1, v_next_produs_id-1, 3, 3499.99);
  INSERT INTO DETALII_COMANDA VALUES (2, v_next_produs_id-1, 2, 3499.99);
  INSERT INTO DETALII_COMANDA VALUES (3, v_next_produs_id-1, 1, 3499.99);
  
  COMMIT;
   DBMS_OUTPUT.PUT_LINE('Inserări finalizate cu succes. Ultimul ID folosit: ' || v_next_produs_id);
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.PUT_LINE('Eroare: ' || SQLERRM);
END;
/
 