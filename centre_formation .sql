Enter password: ***********
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 22
Server version: 8.0.36 MySQL Community Server - GPL

Copyright (c) 2000, 2024, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| bd_vol             |
| centre_formation   |
| djallabasoft       |
| ecuri              |
| hollywood          |
| information_schema |
| isgi               |
| mysql              |
| performance_schema |
| sakila             |
| stordb             |
| sys                |
| test1              |
| tramway            |
| world              |
+--------------------+
15 rows in set (0.01 sec)

mysql> use centre_formation;
Database changed
mysql> show tables;
+----------------------------+
| Tables_in_centre_formation |
+----------------------------+
| catalogue                  |
| etudiant                   |
| formation                  |
| inscription                |
| session                    |
| specialite                 |
+----------------------------+
6 rows in set (0.00 sec)

mysql> select COUNT(*) as NB_ETUDIANTES
    -> from etudiant;
+---------------+
| NB_ETUDIANTES |
+---------------+
|             7 |
+---------------+
1 row in set (0.00 sec)

mysql> desc etudiant;
+----------------+-------------+------+-----+---------+-------+
| Field          | Type        | Null | Key | Default | Extra |
+----------------+-------------+------+-----+---------+-------+
| num_cin        | varchar(10) | NO   | PRI | NULL    |       |
| nom            | varchar(45) | YES  |     | NULL    |       |
| prenom         | varchar(45) | YES  |     | NULL    |       |
| date_naissance | date        | YES  |     | NULL    |       |
| adresse        | varchar(45) | YES  |     | NULL    |       |
| niveau         | varchar(45) | YES  |     | NULL    |       |
| ville          | varchar(45) | YES  |     | NULL    |       |
+----------------+-------------+------+-----+---------+-------+
7 rows in set (0.00 sec)

mysql> select nom,prenom ,round ( datediff (sysdate(),date_naissance) / 365 , 0 )
    -> from etudiant ;
+---------------+--------------+---------------------------------------------------------+
| nom           | prenom       | round ( datediff (sysdate(),date_naissance) / 365 , 0 ) |
+---------------+--------------+---------------------------------------------------------+
| alami         | ahmad        |                                                      38 |
| souni         | sanaa        |                                                      26 |
| idrissi alami | mohammed     |                                                      28 |
| boudiaf       | fatima zohra |                                                      27 |
| toumi         | aicha        |                                                      24 |
| ben omar      | abd allah    |                                                      34 |
| ouled thami   | ali          |                                                      44 |
+---------------+--------------+---------------------------------------------------------+
7 rows in set (0.00 sec)

mysql> select nom,prenom ,round ( datediff (sysdate(),date_naissance) / 365 , 0 ) as AGE
    -> from etudiant;
+---------------+--------------+------+
| nom           | prenom       | AGE  |
+---------------+--------------+------+
| alami         | ahmad        |   38 |
| souni         | sanaa        |   26 |
| idrissi alami | mohammed     |   28 |
| boudiaf       | fatima zohra |   27 |
| toumi         | aicha        |   24 |
| ben omar      | abd allah    |   34 |
| ouled thami   | ali          |   44 |
+---------------+--------------+------+
7 rows in set (0.00 sec)

mysql> desc formation;
+------------+-------------+------+-----+---------+-------+
| Field      | Type        | Null | Key | Default | Extra |
+------------+-------------+------+-----+---------+-------+
| codeforme  | int         | NO   | PRI | NULL    |       |
| tittreform | varchar(45) | YES  |     | NULL    |       |
| dureeform  | double      | YES  |     | NULL    |       |
| prixforme  | double      | YES  |     | NULL    |       |
+------------+-------------+------+-----+---------+-------+
4 rows in set (0.00 sec)

mysql> select tittreform as formation_chere from formation where prixforme = (select MAX(prixforme) from formation);
+-----------------------+
| formation_chere       |
+-----------------------+
| base de donnes oracle |
+-----------------------+
1 row in set (0.00 sec)

mysql> select tittreform as formation_mois_chere from formation where prixforme = (select MIN(prixforme) from formation);
+----------------------+
| formation_mois_chere |
+----------------------+
| communication        |
+----------------------+
1 row in set (0.00 sec)

mysql> select SUM(prixforme) as TOTAL from formation;
+-------+
| TOTAL |
+-------+
| 23050 |
+-------+
1 row in set (0.00 sec)

mysql> desc session;
+-----------+-------------+------+-----+---------+-------+
| Field     | Type        | Null | Key | Default | Extra |
+-----------+-------------+------+-----+---------+-------+
| code      | int         | NO   | PRI | NULL    |       |
| nomSess   | varchar(45) | YES  |     | NULL    |       |
| dateDebut | date        | YES  |     | NULL    |       |
| datefin   | date        | YES  |     | NULL    |       |
| codeforme | int         | YES  | MUL | NULL    |       |
+-----------+-------------+------+-----+---------+-------+
5 rows in set (0.00 sec)

mysql> desc inscription;
+-----------+-------------+------+-----+---------+-------+
| Field     | Type        | Null | Key | Default | Extra |
+-----------+-------------+------+-----+---------+-------+
| code      | int         | NO   | PRI | NULL    |       |
| num_cine  | varchar(10) | NO   | PRI | NULL    |       |
| typeCours | varchar(45) | NO   |     | NULL    |       |
+-----------+-------------+------+-----+---------+-------+
3 rows in set (0.00 sec)

mysql> select code ,COUNT (num_cine) as NB_ETUDIANTS
    -> from inscription
    -> group by code;
ERROR 1630 (42000): FUNCTION centre_formation.COUNT does not exist. Check the 'Function Name Parsing and Resolution' section in the Reference Manual
mysql> select code ,COUNT(num_cine) as NB_ETUDIANTS
    -> from inscription
    -> group by code;
+------+--------------+
| code | NB_ETUDIANTS |
+------+--------------+
| 1101 |            7 |
| 1201 |            6 |
| 1301 |            1 |
| 1302 |            4 |
| 1401 |            6 |
| 1501 |            7 |
+------+--------------+
6 rows in set (0.00 sec)

mysql> select distinct num_cine
    -> from inscription;
+----------+
| num_cine |
+----------+
| AB234567 |
| C0987265 |
| D2356903 |
| F9827363 |
| G5346789 |
| J3578902 |
| Y1234987 |
+----------+
7 rows in set (0.00 sec)

mysql>select num_cine , COUNT(*) as NB_INSCRIPTION
    -> from inscription
    -> group by num_cine;
+----------+----------------+
| num_cine | NB_INSCRIPTION |
+----------+----------------+
| AB234567 |              4 |
| C0987265 |              5 |
| D2356903 |              5 |
| F9827363 |              3 |
| G5346789 |              5 |
| J3578902 |              4 |
| Y1234987 |              5 |
+----------+----------------+
7 rows in set (0.01 sec)

mysql> select code , COUNT(typeCours) as NB_INSCRI_DISTANTIELLES
    -> from inscription
    -> where typeCours = 'Distanciel'
    -> group by code;
+------+-------------------------+
| code | NB_INSCRI_DISTANTIELLES |
+------+-------------------------+
| 1101 |                       7 |
| 1302 |                       1 |
| 1401 |                       6 |
| 1501 |                       2 |
+------+-------------------------+
4 rows in set (0.01 sec)

mysql> select code , COUNT(typeCours) as NB_INSCRI_PRESENTIELLES
    -> from inscription
    -> where typeCours = 'Présentiel'
    -> group by code;
+------+-------------------------+
| code | NB_INSCRI_PRESENTIELLES |
+------+-------------------------+
| 1201 |                       6 |
| 1301 |                       1 |
| 1302 |                       3 |
| 1501 |                       5 |
+------+-------------------------+
4 rows in set (0.00 sec)

mysql>