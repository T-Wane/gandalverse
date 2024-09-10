import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:gandalverse/core/modeles/explorer/categorie/categorie.dart';
import 'package:gandalverse/core/modeles/social_link/social_link.dart';
import 'package:gandalverse/core/modeles/user_model/user_model.dart';

import '../carte_model/carte.dart';
import '../explorer/evenement/evenement.dart';

part 'serializers.g.dart'; // Le fichier généré par build_runner

@SerializersFor([UserModel, ContrainteType,CarteModel, CategorieModel, EvenementModel,SocialLinkModel])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
