import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gandalverse/core/modeles/serializers/serializers.dart';

import '../friend/friend_model.dart';

part 'user_model.g.dart';

 

abstract class UserModel implements Built<UserModel, UserModelBuilder> {
  String get id;
  int get telegramId;
  String? get firstName;
  String? get lastName;
  String? get username;
  String? get photoUrl;
  String? get parrainId;
  BuiltList<FriendModel>? get friends;
  int get level;
  int get coins;
  double get profitPerHour;
  String? get profileImage;

  UserModel._();
  factory UserModel([void Function(UserModelBuilder) updates]) = _$UserModel;

  static Serializer<UserModel> get serializer => _$userModelSerializer;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(UserModel.serializer, this)
        as Map<String, dynamic>;
  }

  static UserModel fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(UserModel.serializer, json)!;
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
