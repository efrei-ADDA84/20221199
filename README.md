# README - TP2

Ce rapport présente le processus de transformation d'un wrapper météorologique en une API, ainsi que la configuration d'un flux de travail GitHub Action pour automatiser le processus de construction et de publication sur Docker Hub.

## 1. Choix techniques
### Langage de programmation : 
Python.

### Framework web :
Flask.

### Conteneurisation : 
Docker est utilisé pour isoler l'application et ses dépendances, assurant une portabilité et une gestion simplifiée de l'environnement d'exécution.

## 2. Modification du Wrapper en API
Le wrapper initial a été transformé en une API Flask pour permettre une interaction plus flexible avec les données météorologiques. Les principales modifications incluent :

Utilisation du framework Flask pour créer une application web.

Définition d'une route /weather qui accepte des requêtes GET avec des paramètres de latitude et de longitude.

Utilisation de l'environnement pour récupérer la clé API.

Interrogation de l'API OpenWeather pour récupérer les données météorologiques en fonction des paramètres de localisation.

Réponse formatée en JSON contenant les informations météorologiques.

## 3. Modification du Dockerfile
Le Dockerfile initial a été ajusté pour prendre en compte les nouvelles dépendances nécessaires à l'exécution de l'API Flask. Les principales modifications incluent :

Installation des dépendances Flask et Werkzeug en plus de la dépendance Requests.

Utilisation du fichier requirements.txt pour spécifier les dépendances Python.

## 4. Configuration du workflow GitHub Action
Le workflow GitHub Action a été configuré pour automatiser le processus de construction et de publication de l'image Docker sur Docker Hub à chaque nouveau commit sur la branche principale (main). Voici les principales configurations :

Utilisation d'un workflow déclenché par les événements de push sur la branche main et les pull requests vers la branche main.

Définition de deux jobs : "lint" pour la validation du Dockerfile avec Hadolint, et "build" pour la construction et la publication de l'image Docker.

Utilisation des secrets GitHub pour stocker les informations sensibles, telles que les identifiants Docker Hub (DOCKERHUB_USERNAME et DOCKERHUB_PASSWORD).

Cette approche garantit que les informations sensibles ne sont pas exposées dans le fichier de configuration du workflow, assurant ainsi la sécurité des identifiants utilisés pour accéder à Docker Hub lors du processus de publication de l'image Docker.

## 5. Publication sur Docker Hub
L'image Docker contenant l'API météorologique est publiée automatiquement sur Docker Hub après chaque nouveau commit sur la branche principale. L'image est taggée avec la version "latest" pour refléter la dernière version du code.

## 6. Test de l'API
   Récupération de l'image Docker depuis Docker Hub :
   ```bash
   docker pull baltasarbn6/weatherapi
   ```
   Exécution de l'image Docker en spécifiant la clé API :
   
   Windows : 
   ```bash
   docker run -p 8081:8081 --env API_KEY='your_api_key' baltasarbn6/weatherapi
   ```
   Linux :
   ```bash
   docker run --network host --env API_KEY='your_api_key' baltasarbn6/weatherapi
   ```
   Utilisation de curl pour interroger l'API avec les paramètres de localisation :
   ```bash
   curl "http://localhost:8081/weather?lat=5.902785&lon=10.754175"
   ```
## 7. Sécurité de l'image avec Trivy :
Windows :
```bash
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy image baltasarbn6/weatherapi
```
Linux :
```bash
docker trivy image baltasarbn6/weatherapi
```
## 8. Difficultés rencontrées
La seule difficulté rencontrée lors de ce tp2 a été de trouver les bonnes versions de dépendances pour éviter tout problème de compatibilité entre elles.
