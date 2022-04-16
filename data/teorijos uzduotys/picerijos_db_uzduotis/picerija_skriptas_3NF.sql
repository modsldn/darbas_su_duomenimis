create table darbuotojai 
    ( 
    darbuotojas_id smallint not null auto_increment,
    vardas varchar(20),
    pavarde varchar(20),
    amzius tinyint, 
    priemimo_data date, 
    atleidimo_data date, 
    adresas varchar(50), 
    asmenine_banko_saskaita varchar(16), 
    el_pastas varchar(30), 
    pareigos enum('jaunesnysis padavejas', 'padavejas', 
        'picu kepejas', 'direktorius', 
'buhalteris', 'duomenu analitikas', 'vadybininkas', 
'iveziotojas', 'valytojas'),
constraint pk_darbuotojai primary key (darbuotojas_id));

create table picu_meniu
(
picos_id tinyint unsigned not null auto_increment,
pavadinimas varchar(30),
sudetis varchar(200),
kaina float(4,2),
alergenai varchar(300),
dydis enum('vaikiska', 'maza', 'vidutine', 'seimynine'),
tipas enum('vegetariska', 'astri', 'veganiska', 'be gliuteno', 'tradicine'),
constraint pk_picu_meniu primary key (picos_id));


create table klientai
(
kliento_id smallint unsigned not null auto_increment,
telefonas varchar(20),
adresas varchar(50),
constraint pk_klientai primary key (kliento_id));



create table uzsakymai
(
uzsakymo_numeris smallint unsigned not null auto_increment,
uzsakymo_data datetime,
picos_id tinyint unsigned,
darbuotojas_id smallint,
kiekis tinyint,
kliento_id smallint unsigned,
constraint pk_uzsakymai primary key (uzsakymo_numeris),
constraint fk_uzsakymai_picos_id foreign key (picos_id) references picu_meniu (picos_id),
constraint fk_uzsakymai_darbuotojas_id foreign key (darbuotojas_id) references darbuotojai (darbuotojas_id),
constraint fk_uzsakymai_kliento_id foreign key (kliento_id) references klientai (kliento_id));


alter table darbuotojai add column miestas varchar(100),
    add column gatve varchar(50),
    add column gatves_numeris varchar(50),
    add column buto_numeris varchar(50);
   
   
   
alter table darbuotojai drop column adresas;


alter table klientai add column miestas varchar(100),
    add column gatve varchar(50),
    add column gatves_numeris varchar(50),
    add column buto_numeris varchar(50);
   
   
alter table klientai drop column adresas;

create table alergenai (
alergeno_id tinyint unsigned not null auto_increment,
pavadinimas varchar(100),
constraint pk_alergeno_id primary key (alergeno_id));


create table picu_alergenai (
picos_id tinyint unsigned,
alergeno_id tinyint unsigned,
constraint pk_picu_alergenai primary key (picos_id, alergeno_id),
constraint fk_picu_meniu foreign key (picos_id) references picu_meniu (picos_id),
constraint fk_alergenai foreign key (alergeno_id) references alergenai (alergeno_id)
);


alter table picu_meniu drop column alergenai;
create table ingredientai(
ingrediento_id tinyint unsigned,
ingredientas varchar(100),
constraint pk_ingrediento_id primary key (ingrediento_id)
);


create table picu_ingredientai(
picos_id tinyint unsigned,
ingrediento_id tinyint unsigned,
constraint pk_picu_ingredientai primary key (picos_id, ingrediento_id),
constraint fk_picu_meniu2 foreign key (picos_id) references picu_meniu (picos_id),
constraint fk_ingredientai foreign key (ingrediento_id) references ingredientai (ingrediento_id)
);


alter table picu_meniu drop column sudetis;

create table uzsakymu_dydis(
uzsakymo_numeris smallint unsigned,
picos_id tinyint unsigned,
kiekis tinyint,
constraint pk_uzsakymu_dydis primary key (uzsakymo_numeris, picos_id),
constraint fk_uzsakymu_dydis foreign key (uzsakymo_numeris) references uzsakymai (uzsakymo_numeris)
);

alter table uzsakymai drop foreign key fk_uzsakymai_picos_id;
alter table uzsakymu_dydis add constraint fk_picos_id foreign key (picos_id) references picu_meniu(picos_id);
alter table uzsakymai drop column picos_id, drop column kiekis;

create table dydziu_sarasas (
dydzio_id tinyint unsigned not null auto_increment,
dydis enum('vaikiska', 'maza', 'vidutine', 'seimynine'),
dydzio_koef float(3,1),
constraint pk_dydziu_sarasas primary key (dydzio_id)
);


create table picu_dydziai (
picos_id tinyint unsigned,
dydzio_id tinyint unsigned,
constraint pk_picu_dydziai primary key (picos_id, dydzio_id),
constraint fk_picu_dydziai foreign key (picos_id) references picu_meniu(picos_id),
constraint fk_picu_dydziai2 foreign key (dydzio_id) references dydziu_sarasas(dydzio_id)
);

alter table picu_meniu drop column dydis;

alter table uzsakymu_dydis add column dydzio_id tinyint unsigned;

alter table uzsakymu_dydis drop foreign key fk_picos_id;


alter table uzsakymu_dydis drop primary key, add primary key (uzsakymo_numeris, picos_id, dydzio_id);

alter table uzsakymu_dydis drop primary key, add primary key (uzsakymo_numeris, picos_id, dydzio_id);


alter table uzsakymu_dydis add constraint fk_picos_id_dydzio_id foreign key (picos_id, dydzio_id) references picu_dydziai(picos_id, dydzio_id);

