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