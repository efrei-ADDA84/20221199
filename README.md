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

## 3. Focus sur le déploiement sur Azure
Pour déployer sur Azure, le worflow suit les étapes suivantes :

Connexion à Azure Container Registry (ACR) en utilisant les informations d'identification stockées dans les secrets GitHub : 
```bash
- name: Log in to Azure Container Registry
        run: echo ${{ secrets.REGISTRY_PASSWORD }} | docker login ${{ secrets.REGISTRY_LOGIN_SERVER }} --username ${{ secrets.REGISTRY_USERNAME }} --password-stdin
```

Poussée de l'image vers Azure : 
```bash
- name: Push Docker image to Azure Container Registry
        run: docker push baltasarbn6/20221199
```

Déploiement sur Azure : 
```bash
- name: Deploy to Azure Container Instance
        run: |
          az container create --resource-group ${{ secrets.RESOURCE_GROUP }} --name 20221199 --image baltasarbn6/20221199 --dns-name-label devops-20221199 --location germanynorth --registry-username ${{ secrets.REGISTRY_USERNAME }} --registry-password ${{ secrets.REGISTRY_PASSWORD }} --secure-environment-variables API_KEY=${{ secrets.API_KEY }} --ports 8080
```
Cette commande déploie l'API météorologique sur Azure Container Instance. Elle crée une instance de conteneur dans le groupe de ressources spécifié, en utilisant l'image Docker poussée vers le registre de conteneurs Azure. Les secrets GitHub sont utilisés pour récupérer les informations d'identification nécessaires au déploiement.

## 4. Test de l'API
   Une fois l'image déployée sur Azure, on peut tester l'API via ce curl dans le terminal, en choisissant sa longitude et sa latitude :
   ```bash
   curl "http://devops-20221199.germanynorth.azurecontainer.io:8080/?lat=10.902785&lon=44.754175"
   ```
## 5. Ajout de métriques avec Prometheus
Une nouvelle fonctionnalité a été ajoutée pour surveiller les performances de l'API à l'aide de Prometheus. L'endpoint ```bash /metrics``` expose des métriques comme le nombre total de requêtes HTTP reçues, la consommation de mémoire ou encore l'utilisation du CPU. Cela permet de surveiller et de diagnostiquer les performances de l'API en temps réel. En surveillant ces métriques, onpeut avoir une vision claire des performances de l'API et prendre des mesures appropriées pour optimiser son fonctionnement et assurer sa disponibilité et sa fiabilité.

Voici la commande : 

   ```bash
   curl "http://devops-20220004.francecentral.azurecontainer.io:8081/metrics
   ```

