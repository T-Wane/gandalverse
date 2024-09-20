import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../serializers/serializers.dart';

part 'friend_model.g.dart';

abstract class FriendModel implements Built<FriendModel, FriendModelBuilder> {
  String get id;
  bool? get reward_isClaimed;

  FriendModel._();
  factory FriendModel([void Function(FriendModelBuilder) updates]) =
      _$FriendModel;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(FriendModel.serializer, this)
        as Map<String, dynamic>;
  }

  static FriendModel fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(FriendModel.serializer, json)!;
  }

  static Serializer<FriendModel> get serializer => _$friendModelSerializer;
}
