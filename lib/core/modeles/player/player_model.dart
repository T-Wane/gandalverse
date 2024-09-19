 
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../serializers/serializers.dart'; 

part 'player_model.g.dart';

abstract class PlayerModel implements Built<PlayerModel, PlayerModelBuilder> {
  String get id; 
  String? get firstName;
  String? get lastName;
  String? get username;  
  int get level;
  int get coins;
  double get profitPerHour;
  String? get profileImage;

  PlayerModel._();
  factory PlayerModel([void Function(PlayerModelBuilder) updates]) = _$PlayerModel;

  static Serializer<PlayerModel> get serializer => _$playerModelSerializer;

  Map<String, dynamic> toJson() {

    return serializers.serializeWith(PlayerModel.serializer, this)
        as Map<String, dynamic>;
  }

  static PlayerModel fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(PlayerModel.serializer, json)!;
  }

  String get gradleFormate {
    if (profitPerHour >= 1000000) {
      return '${(profitPerHour / 1000000).toStringAsFixed(1)}M';
    } else if (profitPerHour >= 1000) {
      return '${(profitPerHour / 1000).toStringAsFixed(1)}K';
    } else {
      return profitPerHour.toStringAsFixed(1);
    }
  }
}
