# ExplorerService

`ExplorerService` est une classe Dart utilisée pour gérer le chargement et la sauvegarde de données dans une application Flutter. Elle permet de charger des éléments depuis des sources de données locales, comme `SharedPreferences` et des fichiers d'actifs JSON, et de les stocker pour une utilisation future.

## Caractéristiques principales

- Chargement de données depuis `SharedPreferences`.
- Chargement de données depuis un fichier d'actifs JSON si aucune donnée n'est trouvée dans `SharedPreferences`.
- Gestion des types génériques pour la flexibilité des données.
- Manipulation facile des données avec des méthodes d'extension.

## Constructeur

```dart
ExplorerService(String storageKey, String assetPath)

//storageKey : Clé utilisée pour identifier les données dans SharedPreferences.**
//assetPath : Chemin vers le fichier d'actifs à utiliser si aucune donnée n'est trouvée.
```

## Méthodes principales
-`Future<List<T>> loadItems<T>()`
Cette méthode charge une liste d'éléments de type générique T.
- Vérifie d'abord si des données sont stockées dans `SharedPreferences` sous la clé spécifiée.
- Si aucune donnée n'est trouvée, elle charge les données depuis un fichier d'actifs spécifié par `assetPath`.
- Retourne une liste d'éléments après avoir désérialisé les données JSON.


-` `

-` `

-` `