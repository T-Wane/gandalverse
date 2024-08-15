import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gandalverse/core/modeles/serializers.dart';

part 'user_model.g.dart';

abstract class UserModel implements Built<UserModel, UserModelBuilder> {
  String get id;
  int get telegramId;
  String? get firstName;
  String? get lastName;
  String? get username;
  String? get photoUrl;
  int get level;
  int get coins;
  double get profitPerHour;
  String? get profileImage;

  UserModel._();
  factory UserModel([void Function(UserModelBuilder) updates]) = _$UserModel;

  static Serializer<UserModel> get serializer => _$userModelSerializer;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(UserModel.serializer, this) as Map<String, dynamic>;
  }

  static UserModel fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(UserModel.serializer, json)!;
  }
}
