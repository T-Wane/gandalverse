import 'package:gandalverse/themes/images/appImages.dart';

final Map<String, Map<String, dynamic>> levels = {
  'Neo': {
    'title': 'Neo',
    'index': 1,
    'coins_required': 10000,
    'image': Images.niveau1, // L'image représentant un œuf intact
    'description':
        'Le niveau Neo représente l\'œuf, un potentiel immense prêt à éclore.',
  },
  'Galaxy': {
    'title': 'Galaxy', 'index': 2,
    'coins_required': 500000,
    'image': Images.niveau2, // L'image représentant un œuf en cours d'éclosion
    'description':
        'Le niveau Galaxy représente l\'œuf en cours d\'éclosion, une transition vers de nouvelles possibilités.',
  },
  'Virtuos': {
    'title': 'Virtuos', 'index': 3,
    'coins_required': 10000000,
    'image': Images.niveau3, // L'image représentant un aiglon sortant de l'œuf
    'description':
        'Le niveau Virtuos représente le petit aigle sortant de l\'œuf, prêt à conquérir les cieux.',
  },
};
