import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../serializers/serializers.dart';

part 'user_purchase_card.g.dart';

abstract class UserPurchaseCard implements Built<UserPurchaseCard, UserPurchaseCardBuilder> {
  // La catégorie de la carte (ex: "Equipe Card")
  @BuiltValueField(wireName: 'categorie_carte')
  String get categorieCarte;

  // Si la carte est achetée ou non
  @BuiltValueField(wireName: 'est_achete')
  bool get estAchete;

  // Identifiant unique de la carte
  @BuiltValueField(wireName: 'id')
  String get id;

  // Niveau de la carte
  @BuiltValueField(wireName: 'niveau')
  int get niveau;

  // Nom de la carte
  @BuiltValueField(wireName: 'nom')
  String get nom;

  // Profil par heure associé à la carte
  @BuiltValueField(wireName: 'profilParHeure')
  double get profilParHeure;

  UserPurchaseCard._();
  factory UserPurchaseCard([void Function(UserPurchaseCardBuilder) updates]) = _$UserPurchaseCard;

  static Serializer<UserPurchaseCard> get serializer => _$userPurchaseCardSerializer;

  // Convertir l'objet en JSON
  Map<String, dynamic> toJson() {
    return serializers.serializeWith(UserPurchaseCard.serializer, this) as Map<String, dynamic>;
  }

  // Convertir JSON en objet
  static UserPurchaseCard fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(UserPurchaseCard.serializer, json)!;
  }
}
