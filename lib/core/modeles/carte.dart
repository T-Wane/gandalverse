class Carte {
  final String nom;
  final String description;
  final List<String> competences;
  final String image;
  final double prix;
  final double tauxAugmentation;
  final int niveau;
  bool estAchete;

  Carte({
    required this.nom,
    required this.description,
    required this.competences,
    required this.image,
    required this.prix,
    required this.tauxAugmentation,
    required this.niveau,
    this.estAchete = false,
  });

  // Méthode pour créer une instance à partir d'un Map (utile pour la désérialisation JSON)
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
    );
  }

  // Méthode pour convertir une instance en Map (utile pour la sérialisation JSON)
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
    };
  }
}
