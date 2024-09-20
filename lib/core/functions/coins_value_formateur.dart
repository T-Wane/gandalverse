import 'package:intl/intl.dart';

/// Formate une valeur numérique en un string avec des espaces
/// comme séparateurs de milliers, et un point comme séparateur
/// des parties entière et décimale.
///
/// Exemple : 123456.78 -> "123 456.78"
///
/// [value] est la valeur numurique à formatter.
///
/// Retourne le string format , ou une erreur si cela échoue.
String coins_value_formateur(double value) {
  NumberFormat formatteur = NumberFormat("#,##0.00", "fr_FR");
   // Applique la conversion
  String valeurFormatee = formatteur.format(value).replaceAll(',', '.');

 return valeurFormatee;
}


String formatValue(double value) {
  if (value >= 1000000000000) {
    // Trillions
    return '${(value / 1000000000000).toStringAsFixed(1)}T';
  } else if (value >= 1000000000) {
    // Billions
    return '${(value / 1000000000).toStringAsFixed(1)}B';
  } else if (value >= 1000000) {
    // Millions
    return '${(value / 1000000).toStringAsFixed(1)}M';
  } else if (value >= 1000) {
    // Thousands
    return '${(value / 1000).toStringAsFixed(1)}K';
  } else {
    // Less than 1000
    return value.toStringAsFixed(1);
  }
}
