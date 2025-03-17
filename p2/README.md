# K3s - Kubernetes léger

## Qu'est-ce que K3s?

K3s est une distribution légère de Kubernetes, conçue pour être simple à installer et à utiliser. C'est essentiellement Kubernetes complet mais optimisé pour les environnements avec des ressources limitées comme les appareils IoT, les edge devices, ou les environnements de développement.

## Architecture

Notre projet utilise une architecture simple avec un seul nœud K3s qui sert à la fois de:

- **Serveur K3s (Control Plane)**: Gère l'orchestration et les décisions de planification
- **Worker Node**: Exécute les applications conteneurisées

L'architecture des applications Kubernetes déployées comprend:

- 3 applications web simples (app1, app2, app3) basées sur Nginx
- Un contrôleur Ingress pour router le trafic selon les noms d'hôtes

## Prérequis

Pour utiliser ce projet, vous devez installer:

- [Vagrant](https://developer.hashicorp.com/vagrant/install)
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

## Structure du projet

```none
project/
├── Vagrantfile                  # Configuration de la VM
├── scripts/
│   ├── setup.sh                 # Script pour installer K3s 
│   └── deploy.sh                # Script pour déployer les applications
└── k3s-apps/
    ├── app1-deployement.yaml    # Configuration App 1
    ├── app2-deployement.yaml    # Configuration App 2
    ├── app3-deployement.yaml    # Configuration App 3
    └── ingress.yaml             # Configuration du routage
```

## Comment ça fonctionne

### K3s et Kubernetes: concepts de base

1. **Pods**: Unité la plus petite dans Kubernetes, contient un ou plusieurs conteneurs
2. **Deployments**: Gère les pods et les réplicas pour assurer la disponibilité
3. **Services**: Expose les pods en créant un point d'accès stable
4. **Ingress**: Configure le routage HTTP/HTTPS vers différents services
5. **ConfigMaps**: Stocke des données de configuration non-confidentielles

### Composants déployés dans notre cluster

- **3 Déploiements** (app1, app2, app3): Chacun avec un nombre différent de réplicas
- **3 Services**: Exposent les applications à l'intérieur du cluster
- **1 Ingress**: Route le trafic selon les noms d'hôtes (app1.com, app2.com)
- **3 ConfigMaps**: Contiennent le HTML personnalisé pour chaque application

## Commandes utiles K3s

Une fois que vous êtes connecté à la VM via `vagrant ssh userS`, vous pouvez utiliser ces commandes:

### Gestion du cluster

- `sudo k3s kubectl get nodes`: Affiche tous les nœuds du cluster
- `sudo k3s kubectl cluster-info`: Affiche les informations sur le cluster
- `sudo k3s kubectl get all --all-namespaces`: Affiche toutes les ressources dans tous les namespaces

### Gestion des applications

- `sudo k3s kubectl get pods`: Liste tous les pods
- `sudo k3s kubectl get deployments`: Liste tous les déploiements
- `sudo k3s kubectl get services`: Liste tous les services
- `sudo k3s kubectl get ingress`: Liste toutes les ressources Ingress

### Diagnostic et dépannage

- `sudo k3s kubectl describe pod <nom-du-pod>`: Affiche les détails d'un pod spécifique
- `sudo k3s kubectl logs <nom-du-pod>`: Affiche les logs d'un pod
- `sudo k3s kubectl exec -it <nom-du-pod> -- /bin/sh`: Ouvre un shell dans un pod

### Configuration du cluster

- `sudo k3s kubectl apply -f <fichier.yaml>`: Applique une configuration depuis un fichier
- `sudo k3s kubectl delete -f <fichier.yaml>`: Supprime une ressource définie dans un fichier

## Comment démarrer

1. Lancez la VM avec `vagrant up`
2. Connectez-vous à la VM avec `vagrant ssh userS`
3. Vérifiez que K3s fonctionne avec `sudo k3s kubectl get nodes`
4. Vérifiez que les applications sont déployées avec `sudo k3s kubectl get pods`

## Test des applications

Pour tester les applications, vous devez ajouter des entrées dans votre fichier hosts:

```none
192.168.56.110  app1.com
192.168.56.110  app2.com
```

Puis, ouvrez votre navigateur et accédez à:

- http://app1.com
- http://app2.com
- http://192.168.56.110 (pour app3, la règle par défaut)