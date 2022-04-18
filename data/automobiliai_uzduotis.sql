create database automobiliai_uzduotis;
use automobiliai_uzduotis;

create table automobiliai (
marke varchar(100),
modelis varchar(100),
kuro_tipas enum('Dyzelinas', 'Benzinas', 'Dujos', 'Elektra'),
kebulas enum('SUV', 'sedanas', 'universalas', 'hecbekas', 'kabrioletas'),
gamybos_metai year,
transmisija enum('mechanine', 'automatine'),
duru_skaicius int,
galingumas int,
turis float(3,1),
rida int,
kaina int,
savikaina int,
pirkejas varchar(300),
pirkejo_adresas varchar(300),
pirkejo_telefonas varchar(12),
saugojimo_lokacija varchar(255),
pardavimo_data date
);