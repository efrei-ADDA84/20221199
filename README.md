Ce rapport présente le processus de création d'un wrapper pour obtenir les informations météorologiques d'un lieu donné en utilisant l'API OpenWeather. Le wrapper est développé en Python et encapsulé dans un conteneur Docker pour assurer la portabilité et la facilité de déploiement.

1. Choix techniques
Langage de programmation : Python.
Conteneurisation : Docker est utilisé pour isoler l'application et ses dépendances, assurant une portabilité et une gestion simplifiée de l'environnement d'exécution.

2. Création du wrapper
Le wrapper utilise les informations de latitude, longitude et la clé API fournies en tant que variables d'environnement pour interroger l'API OpenWeather et récupérer les données météorologiques.

3. Création de l'image Docker et dépôt sur le Hub
   Création de l'image Docker:
    docker build -t weatherapicall:20221199 .

   Tag de l'image:
    docker tag weatherapicall baltasarbn6/weatherapicall:20221199

   Push de l'image vers Docker Hub:
    docker push baltasarbn6/weatherapicall:20221199
