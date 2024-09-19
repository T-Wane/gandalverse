import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gandalverse/core/modeles/player/player_model.dart';
import 'package:gandalverse/data/tg_storage/telegram_cloudStorage.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PlayerRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TelegramCloudStorage _telegramCloudStorage;

  PlayerRepository(this._telegramCloudStorage);

  // Récupère tous les joueurs, triés par le nombre de coins (du plus grand au plus petit)
  Future<List<PlayerModel>> getAllPlayers() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .orderBy('coins', descending: true) // Tri par nombre de coins
          .get();

      List<PlayerModel> players = snapshot.docs.map((doc) {
        return PlayerModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      return players;
    } catch (e) {
      print("Erreur lors de la récupération des joueurs: $e");
      return [];
    }
  }

  // Récupère les joueurs d'un niveau spécifique, triés par le nombre de coins
  Future<List<PlayerModel>> getPlayersByLevel(int level) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .where('level', isEqualTo: level) // Filtrer par niveau
          .orderBy('coins', descending: true) // Tri par nombre de coins
          .get();

      List<PlayerModel> players = snapshot.docs.map((doc) {
        return PlayerModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      return players;
    } catch (e) {
      print("Erreur lors de la récupération des joueurs: $e");
      return [];
    }
  }
}
