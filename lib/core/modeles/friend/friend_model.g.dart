// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<FriendModel> _$friendModelSerializer = new _$FriendModelSerializer();

class _$FriendModelSerializer implements StructuredSerializer<FriendModel> {
  @override
  final Iterable<Type> types = const [FriendModel, _$FriendModel];
  @override
  final String wireName = 'FriendModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, FriendModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.reward_isClaimed;
    if (value != null) {
      result
        ..add('reward_isClaimed')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  FriendModel deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new FriendModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'reward_isClaimed':
          result.reward_isClaimed = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
      }
    }

    return result.build();
  }
}

class _$FriendModel extends FriendModel {
  @override
  final String id;
  @override
  final bool? reward_isClaimed;

  factory _$FriendModel([void Function(FriendModelBuilder)? updates]) =>
      (new FriendModelBuilder()..update(updates))._build();

  _$FriendModel._({required this.id, this.reward_isClaimed}) : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'FriendModel', 'id');
  }

  @override
  FriendModel rebuild(void Function(FriendModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FriendModelBuilder toBuilder() => new FriendModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FriendModel &&
        id == other.id &&
        reward_isClaimed == other.reward_isClaimed;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, reward_isClaimed.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FriendModel')
          ..add('id', id)
          ..add('reward_isClaimed', reward_isClaimed))
        .toString();
  }
}

class FriendModelBuilder implements Builder<FriendModel, FriendModelBuilder> {
  _$FriendModel? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  bool? _reward_isClaimed;
  bool? get reward_isClaimed => _$this._reward_isClaimed;
  set reward_isClaimed(bool? reward_isClaimed) =>
      _$this._reward_isClaimed = reward_isClaimed;

  FriendModelBuilder();

  FriendModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _reward_isClaimed = $v.reward_isClaimed;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FriendModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$FriendModel;
  }

  @override
  void update(void Function(FriendModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FriendModel build() => _build();

  _$FriendModel _build() {
    final _$result = _$v ??
        new _$FriendModel._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'FriendModel', 'id'),
            reward_isClaimed: reward_isClaimed);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
