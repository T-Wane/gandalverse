import 'package:flutter/material.dart';
import 'package:gandalverse/core/modeles/player/player_model.dart';
import 'package:gandalverse/core/repositories/playersRepository.dart';
import 'package:injectable/injectable.dart';

@singleton
class PlayerProvider with ChangeNotifier {
  final PlayerRepository _playerRepository;
  List<PlayerModel> _players = [];

  PlayerProvider(this._playerRepository);

  // Getter pour obtenir la liste des joueurs
  List<PlayerModel> get players => _players;

  // Fonction pour récupérer tous les joueurs depuis Firebase si la liste est vide
  /// Récupère tous les joueurs depuis Firebase si la liste est vide
  /// ou si le paramètre `reload` est à `true`.
  ///
  /// Si la liste n'est pas vide et que `reload` est à `false`, la fonction
  /// renvoie simplement la liste actuelle.
  ///
  /// La fonction est asynchrone et notifie les listeners une fois les données
  /// récupérées.
  ///
  /// Retourne la liste des joueurs.
  Future<List<PlayerModel>> fetchAllPlayers({bool reload = false}) async {
    if (reload || _players.isEmpty) {
      _players = await _playerRepository.getAllPlayers();
      notifyListeners();
    }
    return _players;
  }

  // Fonction pour récupérer les joueurs par niveau
  Future<void> fetchPlayersByLevel(int level) async {
    List<PlayerModel> playersByLevel =

        /// Récupère les joueurs par niveau
        ///
        /// La fonction prend un entier `level` comme paramètre, qui correspond
        /// au niveau des joueurs à récupérer.
        ///
        /// La fonction est asynchrone et notifie les listeners une fois les données
        /// récupérées.
        ///
        /// Retourne la liste des joueurs du niveau demandé.
        await _playerRepository.getPlayersByLevel(level);
    _players = playersByLevel;
    notifyListeners();
  }

  // Fonction pour vider la liste des joueurs (si nécessaire)
  void clearPlayers() {
    _players = [];
    notifyListeners();
  }
}
