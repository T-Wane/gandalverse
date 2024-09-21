import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gandalverse/core/modeles/user_model/user_model.dart';
import 'package:gandalverse/core/repositories/user_repository.dart';

extension UserModelExtension on UserRepository {
  Future<void> updateUserFriendsInFirebase(UserModel user) async {
    // Référence au document utilisateur dans Firestore
    DocumentReference userDoc =
        FirebaseFirestore.instance.collection('users').doc(user.id);

    try {
      // Récupérer les données actuelles de l'utilisateur
      DocumentSnapshot snapshot = await userDoc.get();

      if (snapshot.exists) {
        // Extraire les données de l'utilisateur existant
        Map<String, dynamic> existingUserData =
            snapshot.data() as Map<String, dynamic>;

        // Récupérer l'ancienne liste d'amis
        List<dynamic> existingFriends = existingUserData['friends'] ?? [];

        // Fusionner l'ancienne liste d'amis avec la nouvelle
        List<Map<String, dynamic>> newFriends =
            user.friends?.map((friend) => friend.toJson()).toList() ?? [];
        List<Map<String, dynamic>> mergedFriends =
            mergeFriends(existingFriends, newFriends);

        // Mettre à jour uniquement la liste d'amis dans Firestore
        await userDoc.update({
          'friends': mergedFriends,
        });

        print('User friends updated successfully on Firebase');
      } else {
        print('User not found in Firebase');
      }
    } catch (e) {
      print('Failed to update user friends on Firebase: $e');
    }
  }

// Fonction pour fusionner deux listes d'amis
  List<Map<String, dynamic>> mergeFriends(
      List<dynamic> existingFriends, List<Map<String, dynamic>> newFriends) {
    List<Map<String, dynamic>> mergedFriends = [];

    // Ajouter les anciens amis à la liste fusionnée
    for (var friend in existingFriends) {
      mergedFriends.add(Map<String, dynamic>.from(friend));
    }

    // Ajouter les nouveaux amis tout en vérifiant qu'ils n'existent pas déjà
    for (var newFriend in newFriends) {
      bool alreadyExists =
          mergedFriends.any((friend) => friend['id'] == newFriend['id']);
      if (!alreadyExists) {
        mergedFriends.add(newFriend);
      } else {
        // Si l'ami existe déjà, tu peux choisir d'actualiser des champs spécifiques ici
        mergedFriends = mergedFriends.map((friend) {
          if (friend['id'] == newFriend['id']) {
            return {
              ...friend,
              ...newFriend, // Mise à jour des champs de l'ami
            };
          }
          return friend;
        }).toList();
      }
    }

    return mergedFriends;
  }
}
