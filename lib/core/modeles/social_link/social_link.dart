// import 'dart:convert';

// import 'package:built_value/built_value.dart';
// import 'package:built_value/serializer.dart';
// import 'package:built_collection/built_collection.dart';
// import 'package:gandalverse/core/modeles/serializers/serializers.dart';
// import 'package:url_launcher/url_launcher.dart';

// part 'social_link.g.dart';

// class SocialLinkType extends EnumClass {
//   static const SocialLinkType facebook = _$facebook;
//   static const SocialLinkType twitter = _$twitter;
//   static const SocialLinkType instagram = _$instagram;
//   static const SocialLinkType linkedin = _$linkedin;
//   static const SocialLinkType youtube = _$youtube;

//   const SocialLinkType._(String name) : super(name);

//   static BuiltSet<SocialLinkType> get values => _$values;
//   static SocialLinkType valueOf(String name) => _$valueOf(name);

//   static Serializer<SocialLinkType> get serializer =>
//       _$socialLinkTypeSerializer;
// }

// abstract class SocialLinkModel
//     implements Built<SocialLinkModel, SocialLinkModelBuilder> {
//   @BuiltValueField(wireName: 'id')
//   String? get id;

//   @BuiltValueField(wireName: 'link_type')
//   SocialLinkType get linkType;

//   @BuiltValueField(wireName: 'title')
//   String get title;

//   @BuiltValueField(wireName: 'description')
//   String get description;

//   @BuiltValueField(wireName: 'subscriptionLink')
//   String get subscriptionLink;

//   @BuiltValueField(wireName: 'image')
//   String get image;

//   @BuiltValueField(wireName: 'reward')
//   String get reward;

//   @BuiltValueField(wireName: 'isSubscribed')
//   bool get isSubscribed;

//   @BuiltValueField(wireName: 'isVisible')
//   bool get isVisible;

//   SocialLinkModel._();
//   factory SocialLinkModel([void Function(SocialLinkModelBuilder) updates]) =
//       _$SocialLinkModel;

//   static Serializer<SocialLinkModel> get serializer =>
//       _$socialLinkModelSerializer;

//   Map<String, dynamic> toJson() {
//     return serializers.serializeWith(SocialLinkModel.serializer, this)
//         as Map<String, dynamic>;
//   }

//   static SocialLinkModel fromJson(Map<String, dynamic> json) {
//     return serializers.deserializeWith(SocialLinkModel.serializer, json)!;
//   }

//   //--------------------------------------------------------//

//   String get linkTypeLabel {
//     switch (linkType) {
//       case SocialLinkType.facebook:
//         return 'Facebook';
//       case SocialLinkType.twitter:
//         return 'Twitter';
//       case SocialLinkType.instagram:
//         return 'Instagram';
//       case SocialLinkType.linkedin:
//         return 'LinkedIn';
//       case SocialLinkType.youtube:
//         return 'YouTube';
//       default:
//         return 'Unknown';
//     }
//   }

//   String get formattedUrl => subscriptionLink.startsWith('https')
//       ? subscriptionLink
//       : 'https://$subscriptionLink';

//   Future<void> openLink() async {
//     if (await canLaunch(formattedUrl)) {
//       await launch(formattedUrl);
//     } else {
//       // Handle the error, e.g., show a message to the user
//       throw 'Could not launch $formattedUrl';
//     }
//   }
// }

import 'dart:convert';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:gandalverse/core/modeles/serializers/serializers.dart';
import 'package:url_launcher/url_launcher.dart';

part 'social_link.g.dart';

abstract class SocialLinkModel
    implements Built<SocialLinkModel, SocialLinkModelBuilder> {
  @BuiltValueField(wireName: 'id')
  String get id;

  @BuiltValueField(wireName: 'title')
  String get title;

  @BuiltValueField(wireName: 'description')
  String get description;

  @BuiltValueField(wireName: 'subscriptionLink')
  String get subscriptionLink;

  @BuiltValueField(wireName: 'image')
  String get image;

  @BuiltValueField(wireName: 'reward')
  double get reward; // Le champ reward est maintenant de type double

  @BuiltValueField(wireName: 'isSubscribed')
  bool get isSubscribed; 

  @BuiltValueField(wireName: 'isVisible')
  bool get isVisible;

  @BuiltValueField(wireName: 'subscribeAt')
  DateTime? get subscribeAt;

  @BuiltValueField(wireName: 'isClaimed')
  bool? get isClaimed;

  SocialLinkModel._();
  factory SocialLinkModel([void Function(SocialLinkModelBuilder) updates]) =
      _$SocialLinkModel;

  static Serializer<SocialLinkModel> get serializer =>
      _$socialLinkModelSerializer;

  // Méthode pour convertir le modèle en JSON
  Map<String, dynamic> toJson() {
    return serializers.serializeWith(SocialLinkModel.serializer, this)
        as Map<String, dynamic>;
  }

  // Méthode pour convertir du JSON en modèle
  static SocialLinkModel fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(SocialLinkModel.serializer, json)!;
  }

  // Fonction d'ouverture de lien
  Future<void> openLink() async {
    if (await canLaunch(subscriptionLink)) {
      await launch(subscriptionLink);
    } else {
      throw 'Impossible d’ouvrir $subscriptionLink';
    }
  }

  // Fonction pour vérifier si l'utilisateur peut réclamer le gain
  bool canClaimReward() {
    if (subscribeAt == null || isClaimed == true) {
      return false;
    }
    
    // Vérifier si une heure s'est écoulée depuis la souscription
    final DateTime now = DateTime.now();
    return now.difference(subscribeAt!).inHours >= 1;
  }
}
