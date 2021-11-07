-- 1.Afficher les 10 premiers éléments de la table Produit triés par leur prix unitaire

SELECT * FROM Produit 
ORDER BY Produit.PrixUnit 
LIMIT 10;

-- 2.Afficher les trois produits les plus chers

SELECT * FROM Produit 
ORDER BY Produit.PrixUnit DESC 
LIMIT 3;

-- I.2- Restriction

-- 1.Lister les clients français installés à Paris dont le numéro de fax n'est pas renseigné

SELECT * FROM `Client` 
WHERE Client.Ville = "Paris" 
AND Client.Fax IS NULL;

-- 2.Lister les clients français, allemands et canadiens

SELECT * FROM `Client` 
WHERE Client.Pays IN ("France", "Canada", "Germany");

-- 3.Lister les clients dont le nom de société contient "restaurant"

SELECT * FROM `Client` 
WHERE Client.Societe 
LIKE "%restaurant%" 
--requete equivalente 
select * from Client 
where  instr(Societe, 'restaurant')!=0

-- I.3- Projection

-- 1.Lister les descriptions des catégories de produits (table Categorie)

SELECT DISTINCT Categorie.NomCateg, Categorie.Descriptionn 
FROM Categorie;

-- 2.Lister les différents pays et villes des clients, le tout trié par ordre alphabétique croissant du pays et décroissant de la ville

SELECT DISTINCT Client.Pays, Client.Ville 
FROM `Client` 
ORDER BY Client.Pays, Client.Ville DESC;
-- equivalent position des attributs dans le meme ordre que le select
SELECT DISTINCT Client.Pays, Client.Ville 
FROM `Client` 
ORDER BY 1, 2 DESC

-- 3.Lister les fournisseurs français, en affichant uniquement le nom, le contact et la ville, triés par ville

SELECT `Societe`, `Contact`, `Ville` 
FROM `Fournisseur` 
WHERE Pays = "France" 
ORDER BY Ville;

-- 4.Lister les produits (nom en majuscule et référence) du fournisseur n° 8 dont le prix unitaire est entre 10 et 100 euros, en renommant les attributs pour que ça soit explicite

SELECT UPPER(`NomProd`) AS 'nom_produit', `RefProd` AS 'reference_produit' 
FROM `Produit` 
WHERE NoFour = 8 
AND (PrixUnit BETWEEN 10 AND 100);

-- II- Calculs et Fonctions :
-- II.1- Calculs arithmétiques
/*
Exercices :
La table DetailsCommande contient l'ensemble des lignes d'achat de chaque commande. Calculer, pour la commande numéro 10251, pour chaque produit acheté dans celle-ci, le montant de la ligne d'achat en incluant la remise (stockée en proportion dans la table). Afficher donc (dans une même requête) :
- le prix unitaire,
- la remise,
- la quantité,
- le montant de la remise,
- le montant à payer pour ce produit
*/

SELECT `PrixUnit`, `Qte`, `Remise`, (Remise * PrixUnit) AS 'montant de remise', 
((PrixUnit - (Remise * PrixUnit)) * Qte) AS 'montant a payer' 
FROM `DetailCommande` 
WHERE NoCom = 10251;

-- II.2- Traitement conditionnel

-- 1.A partir de la table Produit, afficher "Produit non disponible" lorsque l'attribut Indisponible vaut 1, et "Produit disponible" sinon.

SELECT NomProd,
    CASE
      WHEN Indisponible=1 THEN 'Produit non disponible'
      ELSE 'Produit disponible'
    END
    AS 'Message a afficher'
FROM Produit

-- equivalent
SELECT p.NomProd, IF(p.Indisponible = 0 , "Produit disponible", "Produit non disponible") AS Disponibility
FROM Produit p;

/*
II.3- Fonctions sur chaînes de caractères
Exercices :
Dans une même requête, sur la table Client :
* Concaténer les champs Adresse, Ville, CodePostal et Pays dans un nouveau champ nommé Adresse_complète, pour avoir : Adresse, CodePostal, Ville, Pays 
* Extraire les deux derniers caractères des codes clients
* Mettre en minuscule le nom des sociétés
* Remplacer le terme "Owner" par "Freelance" dans Fonction
* Indiquer la présence du terme "Manager" dans Fonction
*/

SELECT CONCAT(Adresse, ' ', Ville, ' ', Codepostal, ' ', Pays) AS 'Adresse_complète', 
SUBSTR(Codecli, length(Codecli)-1, 2) AS 'deux derniers caractere', 
SUBSTR(Codecli, 4, 2) AS 'deux derniers caractere', -- des equivalences
RIGHT(Codecli, 2) AS 'deux derniers caractere', -- des equivalences
SUBSTR(Codecli, -2) AS 'deux derniers caractere', -- des equivalences
Lower(Societe) AS 'societe_lower', 
REPLACE(Fonction, 'Owner', 'Freelance') AS 'replace word'
FROM Client WHERE FONCTION LIKE '%Manager%';

/*
II.4- Fonctions sur les dates
Exercices :
*/

-- 1.Afficher le jour de la semaine en lettre pour toutes les dates de commande, afficher "week-end" pour les samedi et dimanche,

SELECT NoCom, DateCom,
 CASE
      WHEN DATE_FORMAT(DateCom, "%W") IN ('Saturday', 'Sunday') THEN 'week-end'
      ELSE DATE_FORMAT(DateCom, "%W")
    END
    AS 'jour_commande'
FROM Commande;

--equivalent
SELECT IF(DATE_FORMAT(DateCom,"%W") LIKE '%Saturday%' OR DATE_FORMAT(DateCom,"%W") 
LIKE '%Sunday%' ,"WEEKEND" ,DATE_FORMAT(DateCom,"%W")) AS DateCommande 
FROM Commande AS cmd;
--equivalent
SELECT *, 
IF(WEEKDAY(DateCom) < 5, DATE_FORMAT(DateCom, "%W"), 'week-end') DateCom
FROM Commande

-- 2.Calculer le nombre de jours entre la date de la commande (DateCom) et la date butoir de livraison (ALivAvant), pour chaque commande, On souhaite aussi contacter les clients 1 mois après leur commande. ajouter la date correspondante pour chaque commande

SELECT NoCom, DateCom, DATEDIFF(ALivAvant, DateCom) AS 'nbre de jour', 
DATE_ADD(DateCom, INTERVAL 1 month) AS 'DateCom Commande 30 jour apres'
FROM Commande;

--autre interpretation de la question 
SELECT NoCom, DateCom, DATEDIFF(ALivAvant, DateCom) AS 'nbre de jour', 
CASE 
      WHEN DATEDIFF(ALivAvant, DateCom) >= 30 THEN 'appeler client'
    END
    AS 'alerte'
FROM Commande

/*
III- Aggrégats III.1- Dénombrements
Exercices :
*/

-- 1.Calculer le nombre d'employés qui sont "Sales Manager"

SELECT COUNT(*) AS nbre_employe 
FROM Employe 
WHERE Fonction = 'Sales Manager'

-- 2.Calculer le nombre de produits de catégorie 1, des fournisseurs 1 et 18 

SELECT COUNT(*) AS 'nbre_produit_categ = 1' 
FROM Produit 
WHERE Produit.CodeCateg = 1 
AND (Produit.NoFour = 1 OR Produit.NoFour = 18)

-- 3.Calculer le nombre de pays différents de livraison

SELECT COUNT(DISTINCT Commande.PaysLiv) AS 'nbr pays de livraion' 
FROM Commande

-- 4.Calculer le nombre de commandes réalisées en Aout 2006.

SELECT COUNT(DATE_FORMAT(Commande.DateCom, '%M %Y')) AS 'nbre commande en aout' 
FROM Commande 
WHERE DATE_FORMAT(Commande.DateCom, '%M %Y') = 'August 2006'

/*
III.2- Calculs statistiques simples
Exercices
*/

-- 1.Calculer le coût du port minimum et maximum des commandes , ainsi que le coût moyen du port pour les commandes du client dont le code est "QUICK"(attribut CodeCli)

SELECT MIN(c.Port), MAX(c.Port), AVG(c.Port) 
FROM Commande c 
WHERE CodeCli = 'QUICK'

-- 2.Pour chaque messager (par leur numéro : 1, 2 et 3), donner le montant total des frais de port leur correspondant

SELECT Commande.NoMess, SUM(Port) AS 'frais de port' 
FROM Commande 
GROUP BY Commande.NoMess

/*
III.3- Agrégats selon attribut(s)
Exercices
*/

-- 1.Donner le nombre d'employés par fonction

SELECT Employe.Fonction, COUNT(Employe.Fonction) AS 'nbre employe par fonction' 
FROM Employe 
GROUP BY Employe.Fonction

-- 2.Donner le nombre de catégories de produits fournis par chaque fournisseur 

SELECT Produit.NoFour, COUNT(DISTINCT Produit.CodeCateg) AS 'nbre categorie de produit' 
FROM Produit 
GROUP BY Produit.NoFour

-- 3.Donner le prix moyen des produits pour chaque fournisseur et chaque catégorie de produits fournis par celui-ci

SELECT Produit.NoFour, Produit.CodeCateg, AVG(Produit.PrixUnit) AS 'prix moyen' 
FROM Produit 
GROUP BY Produit.NoFour, Produit.CodeCateg

/*
III.4- Restriction sur agrégats
Exercices
*/

-- 1.Lister les fournisseurs ne fournissant qu'un seul produit

SELECT Produit.NoFour, COUNT(DISTINCT Produit.NomProd) AS 'nbre produit distinct'
FROM Produit
GROUP BY Produit.NoFour 
HAVING COUNT(Produit.NomProd) = 1

-- 2.Lister les fournisseurs ne fournissant qu'une seule catégorie de produits

SELECT Produit.NoFour, COUNT(DISTINCT Produit.CodeCateg) AS 'nbre categorie distinct'
FROM Produit
GROUP BY Produit.NoFour
HAVING COUNT(DISTINCT Produit.CodeCateg) = 1

-- 3.Lister le Products le plus cher pour chaque fournisseur, pour les Products de plus de 50 euro

SELECT Produit.RefProd, Produit.NoFour, MAX(Produit.PrixUnit) AS 'prix le plus cher'
FROM Produit
WHERE Produit.PrixUnit > 50
GROUP BY Produit.RefProd, Produit.NoFour

/*
IV- Jointures :
IV.1- Jointures naturelles
*/

-- 1.Récupérer les informations des fournisseurs pour chaque produit

SELECT p.NomProd, f.NoFour, f.Societe, f.Contact, f.Fonction, f.Adresse, f.Ville, f.Region, f.CodePostal, f.Pays, f.Tel, f.Fax, f.PageAccueil
FROM Fournisseur f 
NATURAL JOIN Produit p

-- 2.Afficher les informations des commandes du client "Lazy K Kountry Store" 

SELECT c.Societe, cmd.NoCom, cmd.CodeCli, cmd.NoEmp, cmd.DateCom, cmd.ALivAvant, cmd.DateEnv, cmd.NoMess, cmd.Port, cmd.Port, cmd.Destinataire, cmd.AdrLiv, cmd.VilleLiv, cmd.RegionLiv, cmd.CodePostalLiv, cmd.PaysLiv
FROM Commande cmd NATURAL JOIN Client c 
WHERE c.Societe = 'Lazy K Kountry Store'

-- 3.Afficher le nombre de commande pour chaque messager (en indiquant son nom)

SELECT m.NomMess, COUNT(*) 'nbre de commande' FROM Messager m
NATURAL JOIN Commande c 
GROUP BY m.NomMess

/*
IV.2- Jointures internes
Exercices
*/

-- 1.Récupérer les informations des fournisseurs pour chaque produit, avec une jointure interne

SELECT p.NomProd, f.NoFour, f.Societe, f.Contact, f.Fonction, f.Adresse, f.Ville, f.Region, f.CodePostal, f.Pays, f.Tel, f.Fax, f.PageAccueil
FROM Fournisseur f 
INNER JOIN Produit p ON f.NoFour = p.NoFour

-- 2.Afficher les informations des commandes du client "Lazy K Kountry Store", avec une jointure interne

SELECT c.Societe, cmd.NoCom, cmd.CodeCli, cmd.NoEmp, cmd.DateCom, cmd.ALivAvant, cmd.DateEnv, cmd.NoMess, cmd.Port, cmd.Port, cmd.Destinataire, cmd.AdrLiv, cmd.VilleLiv, cmd.RegionLiv, cmd.CodePostalLiv, cmd.PaysLiv
FROM Commande cmd INNER JOIN Client c ON c.Codecli = cmd.CodeCli
WHERE c.Societe = 'Lazy K Kountry Store'

-- 3.Afficher le nombre de commande pour chaque messager (en indiquant son nom), avec une jointure interne

SELECT m.NomMess, COUNT(*) 'nbre de commande' 
FROM Messager m
INNER JOIN Commande c ON m.NoMess = c.NoMess
GROUP BY m.NomMess

/*
IV.3- Jointures externes
Exercices
*/

-- 1.Compter pour chaque produit, le nombre de commandes où il apparaît, même pour ceux dans aucune commande

SELECT p.RefProd, p.NomProd, COUNT(dc.NoCom) 
FROM Produit p 
LEFT OUTER JOIN DetailCommande dc ON p.RefProd = dc.RefProd
GROUP BY p.RefProd, p.NomProd

-- 2.Lister les produits n'apparaissant dans aucune commande

SELECT p.RefProd, p.NomProd, COUNT(dc.NoCom) 
FROM Produit p 
LEFT OUTER JOIN DetailCommande dc ON p.RefProd = dc.RefProd
GROUP BY p.RefProd, p.NomProd
HAVING COUNT(dc.NoCom) = 0

-- 3.Existe-t'il un employé n'ayant enregistré aucune commande ?

SELECT e.Nom, e.Prenom 
FROM Employe e
LEFT OUTER JOIN Commande c ON e.NoEmp = c.NoEmp
GROUP BY e.Nom, e.Prenom
HAVING  COUNT(c.NoCom) = 0

/*
IV.4- Jointures à la main
Exercices
*/

-- 1.Récupérer les informations des fournisseurs pour chaque produit, avec jointure à la main

SELECT p.NomProd, f.NoFour, f.Societe, f.Contact, f.Fonction, f.Adresse, f.Ville, f.Region, f.CodePostal, f.Pays, f.Tel, f.Fax, f.PageAccueil  
FROM Produit p, Fournisseur f 
WHERE p.NoFour = f.NoFour

-- 2.Afficher les informations des commandes du client "Lazy K Kountry Store", avec jointure à la main

SELECT c.Societe, cmd.NoCom, cmd.CodeCli, cmd.NoEmp, cmd.DateCom, cmd.ALivAvant, cmd.DateEnv, cmd.NoMess, cmd.Port, cmd.Port, cmd.Destinataire, cmd.AdrLiv, cmd.VilleLiv, cmd.RegionLiv, cmd.CodePostalLiv, cmd.PaysLiv
FROM Commande cmd, Client c 
WHERE c.Codecli = cmd.CodeCli
AND c.Societe = 'Lazy K Kountry Store'

-- 3.Afficher le nombre de commande pour chaque messager (en indiquant son nom), avec jointure à la main

SELECT m.NomMess, COUNT(*) 'nbre de commande' 
FROM Messager m, Commande c 
WHERE m.NoMess = c.NoMess
GROUP BY m.NomMess

/*
V- Sous-requêtes
V.1- Sous-requêtes
Exercices
*/

-- 1.Lister les employés n'ayant jamais effectué une commande, via une sous-requête 

SELECT Nom, Prenom
FROM Employe
WHERE NoEmp NOT IN (SELECT NoEmp
FROM Commande);

-- 2.Nombre de produits proposés par la société fournisseur "Ma Maison", via une sous-requête

SELECT COUNT(*)
FROM Produit p
WHERE p.NoFour = (SELECT f.NoFour
                FROM Fournisseur f
                        WHERE f.Societe = "Ma Maison");

-- 3.Nombre de commandes passées par des employés sous la responsabilité de "Buchanan Steven"

SELECT COUNT(*)
    FROM Commande c
    WHERE c.NoEmp IN (SELECT e.NoEmp
                        FROM Employe e
                        WHERE e.RendCompteA = (SELECT e.NoEmp
                                                FROM Employe e
                                                WHERE e.Nom = "Buchanan"
                                                AND e.Prenom = "Steven"));


/*
V.2- Opérateur EXISTS
Exercices
*/

-- 1.Lister les produits n'ayant jamais été commandés, à l'aide de l'opérateur EXISTS 

SELECT p.RefProd, p.NomProd
    FROM Produit p
    WHERE NOT EXISTS (SELECT dc.RefProd
                        FROM DetailCommande dc
                        WHERE dc.RefProd = p.RefProd)

-- 2.Lister les fournisseurs dont au moins un produit a été livré en France ==>reponse = (27)

SELECT Societe
    FROM Fournisseur f
    WHERE EXISTS (SELECT * 
                    FROM Produit p 
                    INNER JOIN DetailCommande dc ON p.RefProd = dc.RefProd
                    INNER JOIN Commande c ON dc.NoCom = c.NoCom
                    WHERE c.PaysLiv = "France"
                    AND p.NoFour = f.NoFour);
--equivalent
SELECT Societe
    FROM Fournisseur
    WHERE EXISTS (SELECT * 
                    FROM Produit, DetailCommande, Commande
                    WHERE Produit.RefProd = DetailCommande.RefProd
                    AND DetailCommande.NoCom = Commande.NoCom
                    AND PaysLiv = "France"
                    AND NoFour = Fournisseur.NoFour);

-- 3.Liste des fournisseurs qui ne proposent que des boissons (drinks)

SELECT f.Societe
    FROM Fournisseur f
    WHERE EXISTS (SELECT *
                    FROM Produit p
                    INNER JOIN Categorie c ON p.CodeCateg = c.CodeCateg
                    WHERE p.NoFour = f.NoFour
                    AND c.NomCateg = "drinks")
    AND NOT EXISTS (SELECT *
                    FROM Produit p
                    INNER JOIN Categorie c ON p.CodeCateg = c.CodeCateg
                    WHERE p.NoFour = f.NoFour
                    AND c.NomCateg <> "drinks")

--equivalent
SELECT Societe
    FROM Fournisseur
    WHERE EXISTS (SELECT *
                    FROM Produit, Categorie
                    WHERE Produit.CodeCateg = Categorie.CodeCateg
                    AND NoFour = Fournisseur.NoFour
                    AND NomCateg = "drinks")
    AND NOT EXISTS (SELECT *
                    FROM Produit, Categorie
                    WHERE Produit.CodeCateg = Categorie.CodeCateg
                    AND NoFour = Fournisseur.NoFour
                    AND NomCateg <> "drinks")

/*
VI- Opérations Ensemblistes
VI.1- Union
Exercices
*/

-- En utilisant la clause UNION :
-- 1.Lister les employés (nom et prénom) étant "Representative" ou étant basé au Royaume-Uni (UK)

SELECT e.Nom, e.Prenom FROM Employe e
    WHERE e.Fonction LIKE ('%Representative%')
    UNION
    SELECT e.Nom, e.Prenom FROM Employe e
    WHERE e.Pays = "UK"

-- 2.Lister les clients (société et pays) ayant commandés via un employé situé à Londres ("London" pour rappel) ou ayant été livré par "Speedy Express"

SELECT c.Societe , c.Pays FROM Client c
    INNER JOIN Commande co ON c.Codecli = co.CodeCli
    INNER JOIN Employe e ON co.NoEmp = e.NoEmp
    WHERE e.Ville = 'London'
    UNION
    SELECT c.Societe , c.Pays FROM Client c
    INNER JOIN Commande co ON c.Codecli = co.CodeCli
    INNER JOIN Messager m ON co.NoMess = m.NoMess
    WHERE m.NomMess = 'Speedy Express'

/*
VI.2- Intersection
Exercices
*/

-- 1.Lister les employés (nom et prénom) étant "Representative" et étant basé au Royaume-Uni (UK)

--ne fonctionne pas avec MySql
SELECT e.Nom, e.Prenom FROM Employe e
    WHERE e.Fonction LIKE ('%Representative%')
    INTERSECT
    SELECT e.Nom, e.Prenom FROM Employe e
    WHERE e.Pays = "UK"

--alternative
SELECT DISTINCT e.Nom, e.Prenom FROM Employe e
    WHERE e.Fonction LIKE ('%Representative%')
    and e.Pays = "UK"

-- 2.Lister les clients (société et pays) ayant commandés via un employé basé à "Seattle" et ayant commandé des "Desserts"

--ne fonctionne pas en MySql
SELECT DISTINCT c.Societe , c.Pays FROM Client c
    INNER JOIN Commande co ON c.Codecli = co.CodeCli
    INNER JOIN Employe e ON co.NoEmp = e.NoEmp
    WHERE e.Ville = 'Seattle'
  INTERSECT
    SELECT c.Societe , c.Pays FROM Client c
    INNER JOIN Commande co ON c.Codecli = co.CodeCli
    INNER JOIN DetailCommande dc ON co.NoCom = dc.NoCom
    INNER JOIN Produit p ON dc.RefProd = p.RefProd
    INNER JOIN Categorie ca ON p.CodeCateg = ca.CodeCateg
    WHERE ca.NomCateg = 'Desserts'

/*
VI.3- Différence
Exercices
*/

-- 1.Lister les employés (nom et prénom) étant "Representative" mais n'étant pas basé au Royaume-Uni (UK)

--ne fonctionne pas
SELECT e.Nom, e.Prenom FROM Employe e
    WHERE e.Fonction LIKE ('%Representative%')
    MINUS
        (SELECT e.Nom, e.Prenom FROM Employe e
        WHERE e.Pays = "UK")


-- 2.Lister les clients (société et pays) ayant commandés via un employé situé à Londres ("London" pour rappel) et n'ayant jamais été livré par "United Package"

--ne fonctionne pas
SELECT c.Societe , c.Pays FROM Client c
    INNER JOIN Commande co ON c.Codecli = co.CodeCli
    INNER JOIN Employe e ON co.NoEmp = e.NoEmp
    WHERE e.Ville = 'London'
    MINUS
        SELECT c.Societe , c.Pays FROM Client c
        INNER JOIN Commande co ON c.Codecli = co.CodeCli
        INNER JOIN Messager m ON co.NoMess = m.NoMess
        WHERE m.NomMess = 'United Package'