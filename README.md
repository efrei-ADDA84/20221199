# README - Weather API Wrapper

Ce rapport présente le processus de création d'un wrapper pour obtenir les informations météorologiques d'un lieu donné en utilisant l'API OpenWeather. Le wrapper est développé en Python et encapsulé dans un conteneur Docker pour assurer la portabilité et la facilité de déploiement.

## 1. Choix techniques
### Langage de programmation : 
Python.

### Conteneurisation : 
Docker est utilisé pour isoler l'application et ses dépendances, assurant une portabilité et une gestion simplifiée de l'environnement d'exécution.

## 2. Création du wrapper
Le wrapper utilise les informations de latitude, longitude et la clé API fournies en tant que variables d'environnement pour interroger l'API OpenWeather et récupérer les données météorologiques.

## 3. Création de l'image Docker et dépôt sur le Hub
   Création de l'image Docker:
    ```docker build -t weatherapicall:20221199 .
    ```

   Tag de l'image:
    ```docker tag weatherapicall baltasarbn6/weatherapicall:20221199
    ```

   Push de l'image vers Docker Hub:
    ```docker push baltasarbn6/weatherapicall:20221199
    ```

## 4. Récupérer et tester l'image : 

Il faut récupérer l'image avec : 
   ```bash
      docker pull baltasarbn6/weatherapicall:20221199
   ```

On peut tester l'appel API avec cette commande (et en renseignant sa propre clé API) : 
   ```bash
      docker run --env LAT="31.2504" --env LONG="-99.2506" --env API_KEY=your_api_key baltasarbn6/weatherapicall:20221199
   ```

Sécurité de l'image avec Trivy:

Windows :
```bash
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy image weatherapicall:20221199
```
Linux :
```bash
docker trivy image weatherapicall:20221199
```

Analyse du Dockerfile avec Hadolint:
```bash
docker run --rm -i hadolint/hadolint < Dockerfile
```


## 5. Difficultés rencontrées
Aucune difficulté n'a été rencontrée lors de la création du wrapper. Cependant, il est recommandé de vérifier régulièrement les mises à jour de sécurité des dépendances et de surveiller les éventuelles vulnérabilités dans l'image Docker utilisée.
