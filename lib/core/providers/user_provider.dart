import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gandalverse/core/data/levels.dart';
import 'package:gandalverse/core/functions/shareLink.dart';
import 'package:gandalverse/core/modeles/carte_model/carte.dart';
import 'package:gandalverse/core/modeles/fields/createUser_fields/createUser_fields.dart';
import 'package:gandalverse/core/modeles/purchasedCard/user_purchase_card.dart';
import 'package:gandalverse/core/modeles/user_model/user_model.dart';
import 'package:gandalverse/core/repositories/startparam/start_param.dart';
import 'package:gandalverse/core/repositories/startparam/start_param_parsing.dart';
import 'package:gandalverse/core/repositories/user_repository.dart';
import 'package:gandalverse/core/services/QG_services/QGService.dart';
import 'package:gandalverse/core/services/QG_services/equipe_service.dart';
import 'package:gandalverse/core/services/QG_services/partenaire_service.dart';
import 'package:gandalverse/data/telegram_client.dart';
import 'package:injectable/injectable.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telegram_web_app/telegram_web_app.dart';

@singleton
class UserProvider extends ChangeNotifier {
  UserRepository _userRepository;
  TelegramClient _telegramClient;
  //late TelegramWebApp telegram;
  List<UserModel> friends = [];
  List<UserPurchaseCard> userPurchasedCards = [];

  UserModel? _user;
  int _localPoint = 0;

  UserModel? get user => _user;
  int get localPoint => _localPoint;

  int get telegramUserId => //1016029253;
      _telegramClient.telegram.initData.user.id;

  UserProvider(
    this._telegramClient,
    this._userRepository,
  ) {
    // telegram = TelegramWebApp.instance;
    // telegram.ready();
    fetchUserByTelegramId();
    notifyListeners();
  }

  /// Charge l'utilisateur en fonction de son ID Telegram
  /// Si l'utilisateur n'existe pas, il est créé.
  /// Si l'utilisateur existe, ses points/coins sont mis à jour en local
  /// et synchronisés avec l'API
  Future<void> fetchUserByTelegramId() async {
    _user = await _userRepository.getUserByTelegramId(telegramUserId);

    final prefs = await SharedPreferences.getInstance();
    if (_user == null) {
      await prefs.clear();
      TelegramUser user = _telegramClient.telegram.initData.user;
      String? startParam = _telegramClient.telegram.initDataUnsafe?.startParam;
      StartParam parsedParam = (startParam ?? '').parseStartParam();
      await createUser(
        telegramId: _telegramClient.telegram.initData.user.id,
        firstName: user.firstname,
        lastName: user.lastname,
        username: user.username,
        parrainId: getParrainId(parsedParam),
        photoUrl: _telegramClient.telegram.initDataUnsafe?.user?.photoUrl,
      );

      // createUser(
      //   telegramId: 1016029253,
      //   firstName: "joe",
      //   lastName: "Testeur",
      //   username: "joe@45",
      //   parrainId: "bySystem",
      //   photoUrl: null,
      // );
    } else {
      //Mettre à jour les points/coins de l'user en local
      await loadUserPurchasedCards();
      bool localpointIsSaved = await _userRepository.userPointIsSaved();
      if (localpointIsSaved == true) {
        await updateUserPointLocal(_user!);
      } else {
        int localPoints = await _userRepository.getPoints();
        _localPoint = localPoints;
        // UserModel? user_sync =
        await _userRepository.syncUserCoins(localPoints, _user?.id ?? '');
        // if(user_sync!=null){
        //   _user = user_sync;
        // }
        _user = await _userRepository.getUserByTelegramId(telegramUserId);
        await updateUserPointLocal(_user!);
        //await updateUserPointLocal(_user!);
      }
    }

    notifyListeners();
  }

  /// Creer un utilisateur en fonction des données passées en paramètres
  /// Si l'utilisateur existe déjà, il est mise à jour en local
  /// et synchroniser  avec l'API
  /// Si l'utilisateur n'existe pas, il est crée
  Future<void> createUser(
      {required int telegramId,
      String? firstName,
      String? lastName,
      String? username,
      String? parrainId,
      String? photoUrl}) async {
    CreateUserFields fields = CreateUserFields(
        telegramId: telegramId,
        firstName: firstName,
        lastName: lastName,
        username: username,
        parrainId: parrainId,
        initialCoin: parrainId != null ? 7500 : 2500,
        photoUrl: photoUrl);
    await _userRepository.createUser(fields: fields);
    await fetchUserByTelegramId();
    await loadUserPurchasedCards();
  }

  /// Retourne le parrainId en fonction du paramètre de lancement de l'application
  /// Si le paramètre est de type Referral, alors le parrainId est renvoyé
  /// Sinon, le parrainId est 'bySystem'
  String getParrainId(StartParam param) {
    switch (param) {
      case Referral _:
        return param.parrainId;
      default:
        return 'bySystem';
    }
  }

  /// Mettre à jour un utilisateur en local et en base de données distante
  /// Si l'utilisateur n'existe pas, il est créé
  /// Sinon, il est mis à jour
  ///
  /// La propriété [_user] est mise à jour
  ///
  /// La méthode notifyListeners est appelée
  ///
  /// Si une erreur survient, un message d'erreur est affiché
  ///
  /// La méthode est asynchrone
  Future<void> updateUser(UserModel user) async {
    try {
      //need
      await _userRepository.updateUser(user);

      _user = user;
      log("########## ${user.toString()}################");
    } catch (e) {
      print("#### error $e");
    }
    notifyListeners();
  }

  /// Renvoie les détails du niveau de l'utilisateur courant
  ///
  /// Si l'utilisateur n'a pas de niveau, renvoie null
  ///
  /// Les détails du niveau sont stockés dans la map 'levels' et sont
  /// renvoyés sous forme de Map<String, dynamic>
  ///
  /// La clé 'title' contient le titre du niveau
  ///
  /// La clé 'index' contient l'index du niveau
  ///
  /// La clé 'coins_required' contient le nombre de pièces nécessaires pour
  /// atteindre le niveau
  ///
  /// La clé 'image' contient l'URL de l'image du niveau
  ///
  /// La clé 'description' contient la description du niveau
  ///
  /// La méthode est synchronisée
  Map<String, dynamic>? getUserLevelDetails() {
    int userLevelIndex = _user?.level ?? 1;
    // Parcourir tous les niveaux pour trouver celui correspondant
    for (final entry in levels.entries) {
      if (entry.value['index'] == userLevelIndex) {
        return entry.value;
      }
    }

    print("Level not found");
    return null;
  }

  /// Mise à jour du niveau de l'utilisateur en fonction des pièces.
  ///
  /// Vérifie si l'utilisateur a atteint le niveau suivant en fonction des pièces qu'il a.
  /// Si c'est le cas, met à jour le niveau de l'utilisateur en base de données et
  /// recharge l'utilisateur en local.
  ///
  /// La méthode est asynchrone.
  Future<void> updateUserLevel() async {
    // Mise à jour du niveau de l'utilisateur en fonction des pièces

    final currentLevelIndex = _user?.level ?? 1;
    final userCoins = _user?.coins ?? 0;

    final nextLevel = levels.values
        .where((level) => level['index'] > currentLevelIndex)
        .reduce((current, next) =>
            current['index'] < next['index'] ? current : next);

    if (userCoins >= nextLevel['coins_required']) {
      await Future.wait([
        _userRepository.updateUserLevel(_user!.id),
        fetchUserByTelegramId()
      ]);
    }
  }

  Future<void> deleteUser() async {
    if (_user != null) {
      await _userRepository.deleteUser(_user!.id);
      _user = null;
      notifyListeners();
    }
  }

  // Future<void> purchaseCard(CarteModel carte, QGService qgService) async {
  //   await _userRepository.purchaseCard(_user!.id, carte, qgService);
  //   await reloadServiceData(qgService);
  //   await fetchUserByTelegramId();
  // }

  Future<void> updateCardLevel(
      QGService qgService, CarteModel carteData) async {
    try {
      print("carteData ${carteData.toJson()}");
      if (carteData.estAchete == false) {
        await _userRepository.purchaseCard(_user!.id, carteData, qgService);
      } else {
        await _userRepository.updateCardLevel(qgService, _user!.id, carteData);
      }
    } catch (e) {
      print("Error $e");
    }
    await reloadServiceData(qgService);
    await fetchUserByTelegramId();
  }

  Future<void> reloadServiceData(QGService qgService) async {
    switch (qgService) {
      case EquipeService _:
        await qgService.loadInitialData();
        break;
      case PartenaireService _:
        await qgService.loadInitialData();
        break;
    }
  }

  Future<List<Map<String, dynamic>>> loadUserPurchasedCards() async {
    if (_user == null) await fetchUserByTelegramId();
    List<Map<String, dynamic>> cards =
        await _userRepository.loadUserPurchasedCards(
      _user?.id ?? '',
    );
    userPurchasedCards =
        cards.map((e) => UserPurchaseCard.fromJson(e)).toList();
    print(
        "loadUserPurchasedCards purchased cards ${userPurchasedCards.map((e) => e.toJson())}");
    notifyListeners();
    return cards;
  }

  // Future<List<String>> getPurchaseCardsIds() async {
  //   if (userPurchasedCards.isEmpty) await loadUserPurchasedCards();
  //   return userPurchasedCards.map((e) => e.id).toList();
  // }
  List<String> getPurchaseCardsIds() {
    // if (userPurchasedCards.isEmpty) loadUserPurchasedCards();
    return userPurchasedCards.map((e) => e.id).toList();
  }

  // List<Map<String, int>> getPurchaseCardsLevelAndId() {
  //  if (userPurchasedCards.isEmpty) loadUserPurchasedCards();
  //   return userPurchasedCards.map((e) => {e.id: e.niveau}).toList();
  // }
  Map<String, int> getPurchaseCardsLevelAndId() {
    //if (userPurchasedCards.isEmpty) loadUserPurchasedCards();
    return userPurchasedCards.fold<Map<String, int>>({}, (map, e) {
      map[e.id] = e.niveau;
      return map;
    });
  }

  //To update loacaly user point
  Future<void> updateUserPointLocal(UserModel user) async {
    try {
      //need
      await _userRepository.updatePoints(user.coins);
      await updateUserLevel();
      _user = user;
    } catch (e) {
      print("#### error $e");
    }
    notifyListeners();
  }

  ///GET USER FRIENDS
  ///use user telegramId to get his friends
  Future<List<UserModel>> getMyFirends({bool refresh = true}) async {
    if (_user == null) {
      await fetchUserByTelegramId();
    }
    if (friends.isNotEmpty && !refresh) return friends;
    try {
      print("UserProvider.getMyFirends => telegramUserId : $telegramUserId");
      List<UserModel> friendsList =
          await _userRepository.getUserFriends(telegramUserId);
      friends = friendsList;
      notifyListeners();
      return friendsList;
    } catch (e) {
      print("#UserProvider.getMyFirends => error $e");
      return []; // Retourne une liste vide en cas d'erreur
    }
  }

  // Méthode pour rafraîchir les amis dans UserProvider
  Future<void> refreshFriends() async {
    await getMyFirends(refresh: true);
  }

  ///INVITER AMI
  void inviterAmi() {
    shareViaTelegram(
        "https://t.me/gandalverse_bot/start?startapp=gogverseId$telegramUserId",
        "Plongez dans Gandalverse 🌍\nConstruisez votre monde dans le premier métavers pour le prochain milliard d'Africains. Gagnez des jetons, montez en grade, et signez des partenariats pour des commissions. Invitez des amis, augmentez votre influence et remportez des panneaux publicitaires ou des immeubles. Rejoignez-nous et façonnez l'avenir dès aujourd'hui !");
  }
}
