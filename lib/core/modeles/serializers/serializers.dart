import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:gandalverse/core/modeles/user_model/user_model.dart';

import '../carte_model/carte.dart'; 

part 'serializers.g.dart';  // Le fichier généré par build_runner

@SerializersFor([
  UserModel,
  CarteModel,
])
final Serializers serializers = (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();

 