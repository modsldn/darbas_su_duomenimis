CREATE DATABASE picerija_uzduotis;
use picerija_uzduotis;

create table darbuotojai 
	( 
	darbuotojas_id smallint NOT NULL AUTO_INCREMENT,
	vardas varchar(20),
    pavarde varchar(20),
    amzius tinyint, 
    priemimo_data date, 
    atleidimo_data date, 
    adresas varchar(50), -- ne viena reiksme 
    -- miestas, gatve, namo numeris, buto numeris, pasto-kodas
    asmenine_banko_saskaita varchar(16), 
    el_pastas varchar(30), 
    pareigos enum('jaunesnysis padavejas', 'padavejas', 
		'picu kepejas', 'direktorius', 
'buhalteris', 'duomenu analitikas', 'vadybininkas', 
'iveziotojas', 'valytojas'),
constraint pk_darbuotojai primary key (darbuotojas_id));




create table Picu_meniu
(
picos_id tinyint unsigned NOT NULL AUTO_INCREMENT,
pavadinimas varchar(30),
sudetis varchar(200), -- ne viena reiksme
kaina float(4,2),
alergenai varchar(300), -- ne viena reiksme
-- atskira alergenu lentele
dydis enum('vaikiska', 'maza', 'vidutine', 'seimynine'),
tipas enum('vegetariska', 'astri', 'veganiska', 'be gliuteno', 'tradicine'),
constraint pk_picu_meniu primary key (picos_id));


-- alergenai - 5 alergenai (populiariausi)
-- pienas, riesutai, zuvis, kiausiniai, gliutenas

-- picu alergenai
-- picos_id, alergeno_id


-- sudetis - 5 ingredientai
-- picos_id, ingrediento_id




create table Klientai
(
kliento_id smallint unsigned NOT NULL AUTO_INCREMENT,
telefonas varchar(20),
adresas varchar (50), -- ne viena reiksme 
-- miestas, gatve, namo numeris, buto numeris, pasto-kodas
constraint pk_klientai primary key (kliento_id));


create table Uzsakymai
(
uzsakymo_numeris smallint unsigned NOT NULL AUTO_INCREMENT,
uzsakymo_data datetime,
picos_id tinyint unsigned,
darbuotojas_id smallint,
kiekis tinyint,
kliento_id smallint unsigned,
constraint pk_uzsakymai primary key (uzsakymo_numeris),
constraint fk_uzsakymai_picos_id foreign key (picos_id) REFERENCES Picu_meniu (picos_id),
constraint fk_uzsakymai_darbuotojas_id foreign key (darbuotojas_id) REFERENCES darbuotojai (darbuotojas_id),
constraint fk_uzsakymai_kliento_id foreign key (kliento_id) REFERENCES klientai (kliento_id));