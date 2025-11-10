CREATE SEQUENCE seq_id START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

CREATE TABLE CLIENT (
    id_client NUMBER PRIMARY KEY,
    nume VARCHAR2(50),
    email VARCHAR2(50),
    parola VARCHAR2(50),
    data_inregistrare DATE
);

CREATE TABLE CATEGORIE (
    id_categorie NUMBER PRIMARY KEY,
    nume_categorie VARCHAR2(50)
);

CREATE TABLE PRODUS (
    id_produs NUMBER PRIMARY KEY,
    nume VARCHAR2(50),
    pret NUMBER(10,2),
    id_categorie NUMBER,
    descriere VARCHAR2(100),
    CONSTRAINT fk_produs_categorie FOREIGN KEY (id_categorie) REFERENCES CATEGORIE(id_categorie)
);

CREATE TABLE COMANDA (
    id_comanda NUMBER PRIMARY KEY,
    data DATE,
    id_client NUMBER,
    adresa_livrare VARCHAR2(100),
    status VARCHAR2(20),
    CONSTRAINT fk_comanda_client FOREIGN KEY (id_client) REFERENCES CLIENT(id_client)
);

CREATE TABLE STOC (
    id_produs NUMBER PRIMARY KEY,
    cantitate_disponibila NUMBER,
    CONSTRAINT fk_stoc_produs FOREIGN KEY (id_produs) REFERENCES PRODUS(id_produs)
);

CREATE TABLE PLATA (
    id_plata NUMBER PRIMARY KEY,
    id_comanda NUMBER,
    valoare NUMBER(10,2),
    data_plata DATE,
    tip_plata VARCHAR2(20),
    CONSTRAINT fk_plata_comanda FOREIGN KEY (id_comanda) REFERENCES COMANDA(id_comanda)
);

CREATE TABLE DETALII_COMANDA (
    id_comanda NUMBER,
    id_produs NUMBER,
    cantitate NUMBER,
    pret_unitar NUMBER(10,2),
    PRIMARY KEY (id_comanda, id_produs),
    CONSTRAINT fk_detalii_comanda FOREIGN KEY (id_comanda) REFERENCES COMANDA(id_comanda),
    CONSTRAINT fk_detalii_produs FOREIGN KEY (id_produs) REFERENCES PRODUS(id_produs)
);
create TABLE produs_categorie(
    id_produs NUMBER NOT NULL,
    id_categorie NUMBER NOT null,
    PRIMARY KEY(id_produs,id_categorie),
    CONSTRAINT fk_pc_produs FOREIGN KEY(id_produs) REFERENCES PRODUS(id_produs),
    CONSTRAINT fk_pc_categorie FOREIGN KEY (id_categorie) REFERENCES (id_categorie)
);
