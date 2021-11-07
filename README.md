# rendu-projet-bdd-foody-CDA

1- Ecrire le Modèle Physique de données correspondant à ce schéma.
Vérifier votre schéma de BDD en y insérant les donnant fournies dans les 8 fichiers csv en Pièces jointes..
(si bloqué je peux aussi vous donner un script Foody_data.sql)
2- Exploiter la Base de données :
Répondre aux requêtes du projet en utilisant un code sql compatible MySQL: (projet de 50 requêtes)
  
 I- Requêtage simple : I.1- Requêtage simple
Exercices :
1.Afficher les 10 premiers éléments de la table Produit triés par leur prix unitaire 2.Afficher les trois produits les plus chers
I.2- Restriction
Exercices :
1.Lister les clients français installés à Paris dont le numéro de fax n'est pas renseigné
2.Lister les clients français, allemands et canadiens
3.Lister les clients dont le nom de société contient "restaurant"
I.3- Projection
Exercices :
1.Lister les descriptions des catégories de produits (table Categorie)
2.Lister les différents pays et villes des clients, le tout trié par ordre alphabétique croissant du pays et décroissant de la ville
3.Lister les fournisseurs français, en affichant uniquement le nom, le contact et la ville, triés par ville
4.Lister les produits (nom en majuscule et référence) du fournisseur n° 8 dont le prix unitaire est entre 10 et 100 euros, en renommant les attributs pour que ça soit explicite
II- Calculs et Fonctions :
II.1- Calculs arithmétiques
Exercices :
La table DetailsCommande contient l'ensemble des lignes d'achat de chaque commande. Calculer, pour la commande numéro 10251, pour chaque produit acheté dans celle-ci, le montant de la ligne d'achat en incluant la remise (stockée en proportion dans la table). Afficher donc (dans une même requête) :

  - le prix unitaire,
- la remise,
- la quantité,
- le montant de la remise,
- le montant à payer pour ce produit
II.2- Traitement conditionnel
Exercices :
1.A partir de la table Produit, afficher "Produit non disponible" lorsque l'attribut Indisponible vaut 1, et "Produit disponible" sinon.
II.3- Fonctions sur chaînes de caractères
Exercices :
Dans une même requête, sur la table Client :
* Concaténer les champs Adresse, Ville, CodePostal et Pays dans un nouveau
champ nommé Adresse_complète, pour avoir : Adresse, CodePostal, Ville, Pays * Extraire les deux derniers caractères des codes clients
* Mettre en minuscule le nom des sociétés
* Remplacer le terme "Owner" par "Freelance" dans Fonction
* Indiquer la présence du terme "Manager" dans Fonction II.4- Fonctions sur les dates
Exercices :
1.Afficher le jour de la semaine en lettre pour toutes les dates de commande, afficher "week-end" pour les samedi et dimanche,
2.Calculer le nombre de jours entre la date de la commande (DateCom) et la date butoir de livraison (ALivAvant), pour chaque commande, On souhaite aussi contacter les clients 1 mois après leur commande. ajouter la date correspondante pour chaque commande
III- Aggrégats III.1- Dénombrements

 Exercices :
1.Calculer le nombre d'employés qui sont "Sales Manager"
2.Calculer le nombre de produits de catégorie 1, des fournisseurs 1 et 18 3.Calculer le nombre de pays différents de livraison
4.Calculer le nombre de commandes réalisées le en Aout 2006.
III.2- Calculs statistiques simples
Exercices
1.Calculer le coût du port minimum et maximum des commandes , ainsi que le coût moyen du port pour les commandes du client dont le code est "QUICK"
(attribut CodeCli)
2.Pour chaque messager (par leur numéro : 1, 2 et 3), donner le montant total des frais de port leur correspondant
III.3- Agrégats selon attribut(s)
Exercices
1.Donner le nombre d'employés par fonction
2.Donner le nombre de catégories de produits fournis par chaque fournisseur 3.Donner le prix moyen des produits pour chaque fournisseur et chaque catégorie de produits fournis par celui-ci
III.4- Restriction sur agrégats
Exercices
1.Lister les fournisseurs ne fournissant qu'un seul produit
2.Lister les fournisseurs ne fournissant qu'une seule catégorie de produits
3.Lister le Products le plus cher pour chaque fournisseur, pour les Products de plus de 50 euro
IV- Jointures :
IV.1- Jointures naturelles
Exercices
1.Récupérer les informations des fournisseurs pour chaque produit
2.Afficher les informations des commandes du client "Lazy K Kountry Store" 3.Afficher le nombre de commande pour chaque messager (en indiquant son nom)

 IV.2- Jointures internes
Exercices
1.Récupérer les informations des fournisseurs pour chaque produit, avec une jointure interne
2.Afficher les informations des commandes du client "Lazy K Kountry Store", avec une jointure interne
3.Afficher le nombre de commande pour chaque messager (en indiquant son nom), avec une jointure interne
IV.3- Jointures externes
Exercices
1.Compter pour chaque produit, le nombre de commandes où il apparaît, même pour ceux dans aucune commande
2.Lister les produits n'apparaissant dans aucune commande
3.Existe-t'il un employé n'ayant enregistré aucune commande ?
IV.4- Jointures à la main
Exercices
1.Récupérer les informations des fournisseurs pour chaque produit, avec jointure à la main
2.Afficher les informations des commandes du client "Lazy K Kountry Store", avec jointure à la main
3.Afficher le nombre de commande pour chaque messager (en indiquant son nom), avec jointure à la main
V- Sous-requêtes
V.1- Sous-requêtes
Exercices
1.Lister les employés n'ayant jamais effectué une commande, via une sous-requête 2.Nombre de produits proposés par la société fournisseur "Ma Maison", via une sous-requête
3.Nombre de commandes passées par des employés sous la responsabilité
de "Buchanan Steven"

V.2- Opérateur EXISTS
Exercices
1.Lister les produits n'ayant jamais été commandés, à l'aide de l'opérateur EXISTS 2.Lister les fournisseurs dont au moins un produit a été livré en France
3.Liste des fournisseurs qui ne proposent que des boissons (drinks)
VI- Opérations Ensemblistes
VI.1- Union
Exercices
En utilisant la clause UNION :
1.Lister les employés (nom et prénom) étant "Representative" ou étant basé au Royaume-Uni (UK)
2.Lister les clients (société et pays) ayant commandés via un employé situé à Londres ("London" pour rappel) ou ayant été livré par "Speedy Express"
VI.2- Intersection
Exercices
1.Lister les employés (nom et prénom) étant "Representative" et étant basé au Royaume-Uni (UK)
2.Lister les clients (société et pays) ayant commandés via un employé basé à "Seattle" et ayant commandé des "Desserts"
VI.3- Différence
Exercices
1.Lister les employés (nom et prénom) étant "Representative" mais n'étant pas basé au Royaume-Uni (UK)
2.Lister les clients (société et pays) ayant commandés via un employé situé à Londres ("London" pour rappel) et n'ayant jamais été livré par "United Package"
