import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Méthode pour vérifier et créer un utilisateur
  Future<void> checkAndCreateUser(
      String userId, Map<String, dynamic> userData) async {
    final DocumentReference userRef =
        _firestore.collection('users').doc(userId);
    log("##############[ checkAndCreateUser ######################");

    try {
      // Vérifiez si le document utilisateur existe
      final DocumentSnapshot userSnap = await userRef.get();

      if (userSnap.exists) {
        // Si l'utilisateur existe déjà
        print('User already exists: ${userSnap.data()}');
      } else {
        // Si l'utilisateur n'existe pas, créer un nouveau document
        await userRef.set(userData);
        print('User created successfully');
      }
    } catch (e) {
      print('Error checking or creating user: $e');
      log("####################################################");
    }
  }
}
