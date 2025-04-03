# Inception of things

[![Makefile](https://img.shields.io/badge/Makefile-blue.svg)](https://www.gnu.org/software/make/manual/make.html) [![Vagrant](https://img.shields.io/badge/Vagrant-blue.svg)](https://www.vagrantup.com/) [![Kubernetes](https://img.shields.io/badge/Kubernetes-blue.svg)](https://kubernetes.io/) [![GitLab](https://img.shields.io/badge/GitLab-blue.svg)](https://about.gitlab.com/) [![Argo CD](https://img.shields.io/badge/Argo%20CD-blue.svg)](https://argo-cd.readthedocs.io/)

Le but du projet est de faire ses premier pas dans la CI/CD, pour deployer des projets tout simple, et de la découverte de Vagrant ainsi de Kubernetes.

Le projet est coupé en 3 parties :

- p1 : Débuter avec vagrant, et avoir une architecture 1 serveurs puis n workers, et installer k3s
- p2 : Installer k3s dans une seule machine virtuel de vagrant, et avoir ses nodes en mode serveur et workers
- p3 : Création de sa premier CD en utilisant un docker image simple qui affiche le changement de version, puis instancier Argo CD sur un repo github
- bonus : Tout comme la p3, mais au lieu d'utiliser github, on instancie notre gitlab local.

Toute les parties ont un `README.md` associer pour des explications plus précie et les dépendances.