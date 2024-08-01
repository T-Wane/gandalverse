class Carte {
  final String nom;
  final String description;
  final List<String> competences;
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
    required this.competences,
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
      competences: List<String>.from(json['competences']),
      image: json['image'],
      prix: json['prix'].toDouble(),
      tauxAugmentation: json['taux_augmentation'].toDouble(),
      niveau: json['niveau'],
      estAchete: json['est_achete'],
      force: json['force'].toDouble(), // Désérialisation de la force
      tauxAugmentationForce: json['taux_augmentation_force'].toDouble(), // Désérialisation du taux d'augmentation de la force
    );
  }

  String get prixFormate {
    if (prix >= 1000000) {
      return '${(prix / 1000000).toStringAsFixed(1)}M';
    } else if (prix >= 1000) {
      return '${(prix / 1000).toStringAsFixed(1)}K';
    } else {
      return prix.toStringAsFixed(2);
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
      'taux_augmentation_force': tauxAugmentationForce, // Sérialisation du taux d'augmentation de la force
    };
  }
}
