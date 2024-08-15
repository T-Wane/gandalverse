# gandalverse

Go GandalVerse

## Technologies utilisées

- **Flutter**: Framework open-source pour le développement d'applications multiplateformes (mobile, web, desktop).
- **Provider**: Gestionnaire d'état pour Flutter, permettant une architecture plus modulaire et testable.
- **get_it**: Service locator pour l'injection de dépendances dans Flutter.
- **build_runner**: Outil pour générer du code Dart automatiquement.
- **json_annotation**: Utilisé pour la sérialisation et désérialisation JSON avec `json_serializable`.
- **injectable**: Générateur de code pour la création d'instances de services avec `get_it`.
- **firebase**: Plateforme cloud pour l'intégration des services backend tels que l'authentification, la base de données en temps réel, et le stockage.
- **webView_flutter_web**: Plugin pour intégrer des pages web directement dans votre application Flutter sur le web.
- **telegram_web_app**: Intégration avec l'API Telegram pour ajouter des fonctionnalités de bot et de web app à votre application Flutter.


## Deployement proccess

1. **Build web**

   ```bash
   flutter build web --web-renderer canvaskit --base-href /starbrigVerse/
   ```

2. **copy the content of build/web and past in docs**

    **After past the content of build/web in docs folder**

   ```bash
   cp -r build/web/* docs/
   git add .
   git commit -m "Déploiement de la version web"
   ```

3. **PUSH on master for deployment**

   ```bash
   git push -u origin master
   ```

## Lancez l'application

   Lancez l'application sur une émulateur chrome ou autre :

   ```bash
   flutter run
   ```



## Génération de code

   Certains packages nécessitent la génération de code Dart. Utilisez `build_runner` pour cela :

   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```
   > **Remarque**: Assurez-vous d'exécuter cette commande chaque fois que vous apportez des modifications aux fichiers qui nécessitent une régénération automatique.

## Licence

Ce projet est sous licence [MIT](LICENSE).

 
