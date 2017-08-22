use immobilier;


-- question 1 : Affichez le nom des agences

SELECT nom 
	FROM agence;

-- question 2 : Affichez le numéro de l’agence « Orpi »

SELECT IdAgence 
	FROM agence 
		WHERE nom="orpi";

-- question 3 :  Affichez le premier enregistrement de la table logement.
SELECT * 
	FROM logement 
    ORDER BY idlogement
		LIMIT 1;

-- question 4 : Affichez le nombre de logements (Alias : Nombre_de_logements).
SELECT
 COUNT(*) AS Nombre_De_Logement
	FROM logement;
 
 -- question 5 : Affichez les logements à vendre à moins de 150 000 € dans l’ordre croissant des prix.
 SELECT * 
	FROM logement 
		WHERE (categorie ="vente") AND (prix < 150000) 
			ORDER BY prix;
 
 -- question 6  : Affichez le nombre de logements à la location (alias : nombre)
 SELECT COUNT(*) AS Nombre 
	FROM logement 
		WHERE categorie="location";
 
 -- question 7 : Affichez les villes différentes recherchées par les personnes demandeuses d'un logement
 SELECT DISTINCT ville 
	FROM demande;
 
 -- Question 8 : Affichez le nombre de biens à vendre par ville
 SELECT COUNT(*) AS nombre, ville 
	FROM logement 
		WHERE categorie="vente" 
			GROUP BY ville;
 
 -- question 9 :  Quelles sont les id des logements destinés à la location ?
 SELECT idlogement 
	FROM logement 
		WHERE categorie="location" ;
        
-- question 10 : Quels sont les id des logements entre 20 et 30m² ?
 SELECT idlogement 
	FROM logement 
		WHERE superficie > 20 AND superficie <30;

-- question 11 : Quel est le prix vendeur (hors commission) du logement le moins cher à vendre ? (Alias : prix minimum)
SELECT MIN(prix) 
	FROM logement 
		WHERE categorie="vente";
        
-- question 12 : Dans quelle ville se trouve les maisons à vendre ?
SELECT DISTINCT ville
	FROM logement
		WHERE categorie="vente";
        
-- question 13 : L’agence Orpi souhaite diminuer les frais qu’elle applique sur le logement ayant l'id « 5246 ». Passer les frais de ce logement de 800 à 730€

-- SELECT frais FROM logement_agence Where idLogement=5246;

UPDATE logement_agence 
	SET frais= 730 
		Where idLogement=5246;

-- SELECT frais FROM logement_agence Where idLogement=5246;

-- question 14 : Quels sont les logements gérés par l’agence « laforet »
-- SELECT idlogement
-- 	FROM logement_agence
-- 		WHERE idAgence IN
-- 			(SELECT 
-- 				FROM agence 
-- 					WHERE nom ="laforet");

SELECT log.*
	FROM logement AS log
		LEFT JOIN logement_agence AS log_ag ON log.idlogement = log_ag.idLogement
		RIGHT JOIN agence AS ag ON log_ag.idAgence = ag.idAgence
			WHERE ag.nom = "laforet";


-- question 15 : Affichez le nombre de propriétaires dans la ville de Paris (Alias : Nombre)
SELECT count(DISTINCT idPersonne) AS Nombre
	FROM logement_personne
		WHERE idLogement IN
			(SELECT idLogement
				FROM logement
					WHERE ville = "Paris");
                    
-- question 16 :  Affichez les informations des trois premieres personnes souhaitant acheter un logement

SELECT *
	FROM Personne
		WHERE idPersonne IN
		(SELECT  idPersonne
			FROM demande 
				WHERE categorie ="vente")
					LIMIT 3;
            
            
-- question 17 : Affichez le prénom du vendeur pour le logement ayant la référence « 5770 »

SELECT prenom
	FROM Personne
		WHERE idPersonne =
		(SELECT  idPersonne
			FROM logement_personne
				WHERE idLogement ="5770");
                
-- question 18 : Affichez les prénoms des personnes souhaitant accéder à un logement sur la ville de Lyon
					
SELECT prenom
	FROM Personne
		WHERE idPersonne IN
		(SELECT  idPersonne
			FROM demande
				WHERE ville ="Lyon");

-- Question 19 : Affichez les prénoms des personnes souhaitant accéder à un logement en location sur la ville de Paris

SELECT prenom
	FROM Personne
		WHERE idPersonne IN
		(SELECT  idPersonne
			FROM demande
				WHERE ville ="Paris" AND categorie="location");

-- Question 20 : Affichez les prénoms des personnes souhaitant acheter un logement de la plus grande à la plus petite superficie

SELECT prenom
	FROM Personne
		WHERE idPersonne IN
		(SELECT  idPersonne
			FROM demande
				ORDER BY superficie);
                
 -- Question 21 : Quel sont les prix finaux proposés par les agences pour la maison à la vente ayant la référence « 5091 » ? (Alias : prix frais d'agence inclus)   
 
 SELECT (logement.prix+logement_agence.frais) AS 'prix frais d_agence inclus'
    FROM logement 
		INNER JOIN logement_agence ON logement_agence.idLogement = logement.idLogement
			WHERE logement.idLogement ="5091";
        
-- Question 23 : Si l’ensemble des logements étaient vendus ou loués demain, quel serait le bénéfice généré grâce aux frais d’agence et pour chaque agence (Alias : benefice, classement : par ordre croissant des gains)
          
SELECT agence.nom, SUM(logement_agence.frais) AS benefice         
       FROM agence
			INNER JOIN logement_agence ON logement_agence.idAgence = agence.idAgence
				GROUP BY agence.nom
                ORDER BY SUM(logement_agence.frais);
          
          
          
          
 