import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:gandalverse/core/modeles/user_model/user_model.dart'; 

part 'serializers.g.dart';  // Le fichier généré par build_runner

@SerializersFor([
  UserModel,
])
final Serializers serializers = (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
