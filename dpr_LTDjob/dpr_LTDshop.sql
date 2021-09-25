INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_ltd', 'LTD', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_ltd', 'LTD', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_ltd', 'LTD', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('ltd', 'LTD')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('ltd',0,'recrue','Recrue',12,'{}','{}'),
	('ltd',1,'commis',"Vendeur",24,'{}','{}'),
	('ltd',2,'ltd','LTD',36,'{}','{}'),
	('ltd',3,'boss',"Patron",48,'{}','{}')
;

INSERT INTO `items` (name, label) VALUES 
	('bread', 'Pain'),
	('water', "Bouteille d'Eau"),
	('pastabox', 'Pasta Box'),
    ('sandwitch', 'Sandwitch'),
	('jusdorange', "Jus d'orange"),
    ('fruitshoot', 'Fruit Shoot'),
	('caprisun', 'Capri Sun')
;