import 'package:built_collection/built_collection.dart';

import '../friend/friend_model.dart';
import 'user_model.dart';

extension UserModelExtension on UserModel {
  /// Récupère les amis dont les coins n'ont pas encore été réclamés
  BuiltList<FriendModel> getUnclaimedFriends() {
    return BuiltList(
        friends?.where((friend) => friend.reward_isClaimed == false).toList() ??
            []);
  }

  /// Fonction pour réclamer les récompenses des amis et mettre à jour leur état
  UserModel claimCoinsFromFriends() {
    // Mettre à jour les amis en marquant les coins comme réclamés
    final updatedFriends = friends?.map((friend) {
      if (friend.reward_isClaimed == false) {
        return friend.rebuild((b) => b..reward_isClaimed = true);
      }
      return friend;
    }).toList();

    // Retourner un nouvel utilisateur avec la liste de friends mise à jour
    return rebuild((b) => b
      ..coins = b.coins ?? 0 + (10000 * ((updatedFriends ?? []).length))
      ..friends.replace(updatedFriends ?? []));
  }
}
