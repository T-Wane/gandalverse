import 'dart:math';

import 'package:gandalverse/screens/bnda/modeles/agence.dart';

// Fonction pour calculer la distance entre deux coordonnées géographiques
double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  const double earthRadius = 6371; // Rayon de la Terre en kilomètres
  double dLat = _toRadians(lat2 - lat1);
  double dLon = _toRadians(lon2 - lon1);

  double a = sin(dLat / 2) * sin(dLat / 2) +
      cos(_toRadians(lat1)) *
          cos(_toRadians(lat2)) *
          sin(dLon / 2) *
          sin(dLon / 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  return earthRadius * c;
}

double _toRadians(double degrees) {
  return degrees * (pi / 180);
}

// Fonction pour trier les agences par distance
List<Agence> sortAgenciesByDistance(
    List<Agence> agencies, double userLat, double userLon) {
  // Cloner la liste pour ne pas modifier l'originale
  List<Agence> sortedAgencies = List.from(agencies);

  // Trier la liste en fonction de la distance
  sortedAgencies.sort((a, b) {
    double distanceA =
        _calculateDistance(userLat, userLon, a.lat ?? 0, a.long ?? 0);
    double distanceB =
        _calculateDistance(userLat, userLon, b.lat ?? 0, b.long ?? 0);
    return distanceA.compareTo(distanceB);
  });

  return sortedAgencies;
}
