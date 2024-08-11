import 'package:gandalverse/core/modeles/carte.dart';

abstract class QGService {
  Stream<bool> get loadingStream;
  Future<void> updateCarte(String nom, Carte carte);
}