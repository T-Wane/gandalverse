class Carte {
  final String nom;
  final String description;
  List<String>? competences;
  final String image;
  final double prix;
  final double tauxAugmentation;
  final int niveau;
  final bool estAchete;
  final double force; // Remplacé par force
  final double tauxAugmentationForce; // Taux d'augmentation de la force

  Carte({
    required this.nom,
    required this.description,
    this.competences,
    required this.image,
    required this.prix,
    required this.tauxAugmentation,
    required this.niveau,
    required this.estAchete,
    required this.force, // Initialisation du nouvel attribut
    required this.tauxAugmentationForce, // Initialisation du taux d'augmentation de la force
  });

  factory Carte.fromJson(Map<String, dynamic> json) {
    return Carte(
      nom: json['nom'],
      description: json['description'],
      competences: json.containsKey("competences")
          ? List<String>.from(json['competences'])
          : null,
      image: json['image'],
      prix: json['prix'].toDouble(),
      tauxAugmentation: json['taux_augmentation'].toDouble(),
      niveau: json['niveau'],
      estAchete: json['est_achete'],
      force: json['force'].toDouble(), // Désérialisation de la force
      tauxAugmentationForce: json['taux_augmentation_force']
          .toDouble(), // Désérialisation du taux d'augmentation de la force
    );
  }

  double increase(double value, double taux) =>
      (niveau > 0 ? (taux * niveau * value) : value);

  get getPrix => increase(prix, tauxAugmentation).toStringAsFixed(1);
  get getForce => increase(force, tauxAugmentationForce).toStringAsFixed(1);

  String get prixFormate {
    double value = increase(prix, tauxAugmentation);
    if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(1)}M';
    } else if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}K';
    } else {
      return value.toStringAsFixed(1);
    }
  }

  String get forceFormate {
    double value = increase(force, tauxAugmentationForce / 10);
    if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(1)}M';
    } else if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}K';
    } else {
      return value.toStringAsFixed(1);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'nom': nom,
      'description': description,
      'competences': competences,
      'image': image,
      'prix': prix,
      'taux_augmentation': tauxAugmentation,
      'niveau': niveau,
      'est_achete': estAchete,
      'force': force, // Sérialisation de la force
      'taux_augmentation_force':
          tauxAugmentationForce, // Sérialisation du taux d'augmentation de la force
    };
  }
}
