# Gesture Navigation Package

Un package Flutter qui permet une navigation fluide entre les pages basée sur les gestes, avec des animations personnalisables. Le package utilise une disposition en croix où la page centrale peut naviguer vers quatre pages adjacentes (haut, bas, gauche, droite) à l'aide de gestes de balayage.

## Fonctionnalités

- 🔄 Navigation gestuelle fluide
- 💫 Animations personnalisables
- ⚡ Performances optimisées avec GetX
- 🎯 Navigation unidirectionnelle depuis les pages satellites
- 📱 Support du mode portrait et paysage
- 🔧 Hautement personnalisable

## Installation

Ajoutez ceci à votre fichier `pubspec.yaml` :

```yaml
dependencies:
  gesture_navigation_package:
    git:
      url: https://github.com/votre-username/gesture_navigation_package.git
      ref: main
```

## Utilisation

### Configuration de base

```dart
import 'package:flutter/material.dart';
import 'package:gesture_navigation_package/gesture_navigation.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        body: GestureWrapper(
          centerPage: CenterPage(),
          topPage: TopPage(),
          bottomPage: BottomPage(),
          leftPage: LeftPage(),
          rightPage: RightPage(),
        ),
      ),
    );
  }
}
```

### Exemple complet

```dart
GestureWrapper(
  // Pages principales
  centerPage: Container(
    color: Colors.blue,
    child: Center(child: Text('Page Centrale')),
  ),
  topPage: Container(
    color: Colors.green,
    child: Center(child: Text('Page Haut')),
  ),
  bottomPage: Container(
    color: Colors.orange,
    child: Center(child: Text('Page Bas')),
  ),
  leftPage: Container(
    color: Colors.purple,
    child: Center(child: Text('Page Gauche')),
  ),
  rightPage: Container(
    color: Colors.red,
    child: Center(child: Text('Page Droite')),
  ),
  
  // Paramètres optionnels
  swipeThreshold: 0.3,
  animationDuration: Duration(milliseconds: 300),
)
```

## Paramètres personnalisables


| Paramètre        | Type     | Description                      | Défaut |
| ----------------- | -------- | -------------------------------- | ------- |
| centerPage        | Widget   | Page centrale obligatoire        | -       |
| topPage           | Widget?  | Page du haut (optionnelle)       | null    |
| bottomPage        | Widget?  | Page du bas (optionnelle)        | null    |
| leftPage          | Widget?  | Page de gauche (optionnelle)     | null    |
| rightPage         | Widget?  | Page de droite (optionnelle)     | null    |
| swipeThreshold    | double   | Seuil de déclenchement du swipe | 0.3     |
| animationDuration | Duration | Durée de l'animation            | 300ms   |

## Comportement de navigation

1. Depuis la page centrale :

   - Swipe vers le haut → Page du haut
   - Swipe vers le bas → Page du bas
   - Swipe vers la gauche → Page de gauche
   - Swipe vers la droite → Page de droite
2. Depuis une page satellite :

   - Seul le geste inverse est possible pour revenir à la page centrale
   - Exemple : Si vous êtes arrivé par un swipe vers la gauche, seul le swipe vers la droite sera possible

## Contribuer

Les contributions sont les bienvenues ! N'hésitez pas à :

1. Fork le projet
2. Créer une branche pour votre fonctionnalité
3. Commit vos changements
4. Push sur la branche
5. Créer une Pull Request

## Licence

Ce projet est sous licence MIT - voir le fichier [LICENSE](LICENSE) pour plus de détails.

## Support

Si vous rencontrez des problèmes ou avez des suggestions :

1. Ouvrez une [issue](https://github.com/votre-username/gesture_navigation_package/issues)
2. Consultez les [issues existantes](https://github.com/votre-username/gesture_navigation_package/issues?q=is%3Aissue)
