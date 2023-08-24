# CocoPass
Ce projet est réalisé dans le cadre du module PDG de la HEIG-VD.

## Description du projet

À l'ère numérique moderne, où la sécurité en ligne est primordiale, l'application CocoPass propose une solution intuitive, 
fiable et élégante pour stocker et gérer ses mots de passes.
CocoPass permettra de stocker et générer des mots de passes forts et uniques pour chaque compte.

### Problèmes à résoudre

Avec l'avènement du monde numérique moderne, la sécurité en ligne est primordiale. Celle-ci s'effectue souvent grâce à l'utilisation de mots de passes.

Ces mots de passes sont donc devenus un rempart nécessaire à la protection de nos données personnelles. Pour résister à la menace croissante des hackeurs tentant sans cesses de dérober nos informations, il est impératif d'utiliser des mots de passe longs, complexes et différents.

Cependant, cette tâche peut vite s'avérer plus compliquée qu'elle n'y parait. Il est en effet difficile de se souvenir de dizaines voir centaines de mots de passes composées de combinaisons alphanumériques complexes, parfois assorties de caractères spéciaux. 

Il devient donc tentant de les réutiliser. Malheureusement, c'est à ce moment qu'on compromet une grande partie de notre sécurité en ligne. En effet, si un mot de passe est compromis, tous les comptes utilisant ce mot de passe sont alors vulnérables et nos données personnelles aussi.

Les données personnelles sont de l'or, il est donc important d'y accorder une importante extrême et ne pas jouer avec celles-ci. 

### Solutions proposées

Notre solution mobile est un gestionnaire de mots de passe. Celle-ci aura les fonctionnalités suivantes :

- Création et accès à son compte : Les utilisateurs pourront créer un compte gratuitement et y accéder avec une authentification à double facteurs pour une sécurité accrue à l'accès de leurs mots de passes.
- Stockage sécurisé : L'utilisateur pourra stocker des mots de passes prédéfinis liés à des comptes de services en ligne de manière sécurisée.

- Génération automatique de mots de passes : L'utilisateur pourra générer automatiquement des mots de passes forts et unique pour
  chaque compte avec la possibilité d'inclure ou d'exclure certains types de caractères et de spécifier un nombre de caractères.

- Authentification sécurisée : L'utilisateur pourra utiliser une authentification à doubles facteurs afin de sécuriser son compte.

- Synchronisation : Grâce à notre synchronisation, l'utilisateur pourra accéder à ses mots de passes depuis n'importe quel appareil android disposant de notre application.

- Interface intuitive : Afin de cibler un public plus large, l'interface sera très intuitive et facile d'utilisation.

## Requirements fonctionnels
- Création de compte : Les utilisateurs doivent pouvoir créer un compte sécurisé pour accéder à l'application.
- Modification de compte : Les utilisateurs doivent pouvoir modifier les informations de leur compte.
- Stockage sécurisé : Les mots de passe et les données sensibles doivent être stockés de manière chiffrée et sécurisée.
- Ajout et gestion de mots de passe : Les utilisateurs doivent pouvoir ajouter, modifier et supprimer des entrées de mots de passe et spécifier sur quels sites ceux-ci sont utilisés.
- Génération de mots de passe : Une fonctionnalité de génération de mots de passe forts et uniques doit être disponible.
- Synchronisation multi-appareils : Les mots de passe doivent pouvoir être synchronisés en toute sécurité entre différents appareils.
- Sécurité renforcée : Intégrer l'authentification à deux facteurs pour une sécurité accrue.

## Requirements non-fonctionnels
- Sécurité : Les données doivent être stockées et transmises de manière sécurisée, en utilisant des protocoles de chiffrement forts. L'application doit garantir le chiffrement de bout en bout des données utilisateur.
- Convivialité : L'interface utilisateur doit être intuitive et conviviale pour permettre une expérience utilisateur fluide et intuitive.
- Performances : Dans un premier temps, l'application doit être capable de répondre aux besoins d'une dizaine de clients.
- Compatibilité : L'application doit être compatible avec les principales version d'android.
- Disponibilité : L'application doit être disponible et fonctionnelle en ligne et hors ligne.
- Évolutivité : La solution doit pouvoir gérer une augmentation du nombre d'utilisateurs et de données au fil du temps.
  
## Description de la méthodologie de développement
Description de la Méthodologie de Développement : Scrum Adapté

**Introduction** :

Pour assurer une planification, un développement et une livraison efficaces de notre projet de gestionnaire de mot de passe en seulement 3 semaines, nous avons choisi d'adopter une approche Scrum adaptée. Scrum est une méthodologie agile bien connue qui nous permettra de rester flexibles tout en atteignant nos objectifs.

**Cadence Sprint** :

En raison de la contrainte de temps de 3 semaines, nous allons adopter des itérations de Sprint de 1 semaine chacune. Chaque Sprint débutera le lundi et se terminera le vendredi, ce qui nous donnera un rythme soutenu et concentré.

**Rôles Scrum** :

Product Owner : Céine Roger sera le Product Owner. Il sera responsable de définir les exigences et les priorités du produit.

Scrum Master : Florian Conti sera le Scrum Master. Il veillera à ce que l'équipe respecte les principes de Scrum et supprime les obstacles.

**Backlog du Produit Initial** :

Avant le début du Sprint 1, nous allons rassembler les exigences clés et les fonctionnalités prioritaires pour le projet. Cela constituera notre Backlog du Produit initial.

**Sprint 1 (3 jours)** :

Le Sprint 1 débutera le mardi 22.08 avec une réunion de planification du Sprint, où l'équipe choisira les éléments du Backlog du Produit à inclure dans le Sprint.
Chaque jour, une réunion de mêlée de 15 minutes sera tenue pour mettre à jour l'équipe sur les progrès et les obstacles.
Le vendredi, nous tiendrons une réunion de revue de Sprint pour examiner les fonctionnalités développées pendant la semaine et définir les prochaines étapes.
Livrables de la Semaine 1 :

Description du projet
Requirements fonctionnels
Requirements non-fonctionnels
Description de la méthodologie de développement
Mockups
Landing page
Description Préliminaire de l’Architecture
Description des Choix Techniques
Description du processus de travail
Mise en place des outils de développement (VCM, Issue tracker)​
Mise en place d’un environnement de déploiement​
Mise en place d’un pipeline de livraison et de déploiement (CI/CD)​

### Conventions mises en place :

**Commits** : 

Messages clairs et informatifs structurés ainsi : "type(scope):message". type indique le type de changement (fix, feat, docs, style, refactor, test...) et scope précise la portée du changement et message décrit les modifications de manière brève.

**Branchs** :

Utilisation de Gitflow, la branche master sera la branche de production, la branche develop celle de développement. Il y aura des branches de fonctionnalités ou correctifs à ajouter au fur et à mesure. Le nommage des branches sera de la forme suivante : type/nom. Exemple : bugfix/email-validation ou feature/generate-password.

**Style de code** : Langage Dart, camelCase, commentaires et noms de fonction/variables etc... en français.

**Revues de code** :

Revue obligatoire pour chaque pull-request par l'un des membres de l'équipe avant la fusion.

**Gestion des problèmes et fonctionnalités** :

Utilisation de JIRA pour l'organisation des tâches, des bugs et fonctionnalités. Ils seront associés aux banches correspondantes.

**Intégration Continue et Déploiement Continu** : 

**A DEFINIR** Scripts de build et tests automatiques à chaque pull request/commit. Configuration du pipeline CI/CD pour automatiser les tests et le déploiement.
## Mockups
[Mockup](mockup/CocoPass.pdf)

## Landing page
[https://cocopass.live](https://cocopass.live)


## Description des choix techniques 

Afin de réaliser notre application mobile, nous allons utiliser flutter qui est un framework google permettant de concevoir des applications multiplateformes pour Android et iOS.

Pour le stockage des données, nous allons utiliser une base de donnée noSQL sur Firebase. Nous avons fait ce choix afin de pouvoir accéder aux données voulues depuis plusieurs appareils en simultané et rapidement.

Pour ce qui est de la sécurité, nous allons chiffrer les données à l'aide du package Flutter Secure Storage directement sur l'application mobile avant de les envoyés et les stockés sur le cloud. Comme ça le serveur n'aura pas accès au donnée en claire et la confidentialité lors des échanges d'information sera garantie.

## Description préliminaire de l'architecture

![Alt text](images/Architecture.png)
