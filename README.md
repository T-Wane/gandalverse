# gandalverse

Go GandalVerse

## Technologies utilisées

- **Flutter**: Framework open-source pour le développement d'applications mobiles multiplateformes. 
- **get_it**: Service locator pour l'injection de dépendances. 
- **build_runner**: Outil pour générer du code Dart automatiquement.

## Deployement proccess

1. **Build web**

   ```bash
   flutter build web --web-renderer canvaskit --base-href /starbrigVerse/
   ```

2. **copy the content of build/web and past in docs**

    **After past the content of build/web in docs folder**

   ```bash
   git add .
   git commit -m "commit message"
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

 