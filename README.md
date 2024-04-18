# README - TP3

Ce rapport présente les évolutions apportées au projet depuis la version précédente, à savoir la configuration du déploiement vers Azure Container Instance et l'ajout de métriques avec Prometheus.

## 1. Choix techniques
### Langage de programmation : 
Python.

### Framework web :
Flask.

### Conteneurisation : 
Docker est utilisé pour isoler l'application et ses dépendances, assurant une portabilité et une gestion simplifiée de l'environnement d'exécution.

## 2. Configuration du workflow GitHub Action pour Azure
Le workflow GitHub Action a été étendu pour inclure le déploiement vers Azure Container Instance en plus de la publication sur Docker Hub.
Voici les principales modifications :

Ajout du push de l'image Docker vers Azure Container Registry.

Ajout d'un nouveau job "deploy" pour déployer l'image Docker vers Azure Container Instance.

Utilisation des secrets GitHub pour stocker les informations sensibles nécessaires au déploiement vers Azure Container Registry, telles que les informations d'identification et les variables d'environnement sécurisées (clé API).

L'image Docker contenant l'API météorologique est automatiquement déployée vers Azure Container Instance après chaque nouveau commit sur la branche principale.

## 3. Test de l'API
   Une fois l'image déployée sur Azure, on peut tester l'API via ce curl dans le terminal :
   ```bash
   curl "http://devops-20221199.germanynorth.azurecontainer.io/?lat=10.902785&lon=44.754175"
   ```
## 4. Ajout de métriques avec Prometheus
Une nouvelle fonctionnalité a été ajoutée pour surveiller les performances de l'API à l'aide de Prometheus. Les métriques incluent le nombre total de requêtes HTTP reçues. Cela permet de surveiller et de diagnostiquer les performances de l'API en temps réel.
