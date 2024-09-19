// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<PlayerModel> _$playerModelSerializer = new _$PlayerModelSerializer();

class _$PlayerModelSerializer implements StructuredSerializer<PlayerModel> {
  @override
  final Iterable<Type> types = const [PlayerModel, _$PlayerModel];
  @override
  final String wireName = 'PlayerModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, PlayerModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'level',
      serializers.serialize(object.level, specifiedType: const FullType(int)),
      'coins',
      serializers.serialize(object.coins, specifiedType: const FullType(int)),
      'profitPerHour',
      serializers.serialize(object.profitPerHour,
          specifiedType: const FullType(double)),
    ];
    Object? value;
    value = object.firstName;
    if (value != null) {
      result
        ..add('firstName')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.lastName;
    if (value != null) {
      result
        ..add('lastName')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.username;
    if (value != null) {
      result
        ..add('username')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.profileImage;
    if (value != null) {
      result
        ..add('profileImage')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  PlayerModel deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PlayerModelBuilder();

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
        case 'firstName':
          result.firstName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'lastName':
          result.lastName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'username':
          result.username = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'level':
          result.level = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'coins':
          result.coins = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'profitPerHour':
          result.profitPerHour = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'profileImage':
          result.profileImage = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$PlayerModel extends PlayerModel {
  @override
  final String id;
  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final String? username;
  @override
  final int level;
  @override
  final int coins;
  @override
  final double profitPerHour;
  @override
  final String? profileImage;

  factory _$PlayerModel([void Function(PlayerModelBuilder)? updates]) =>
      (new PlayerModelBuilder()..update(updates))._build();

  _$PlayerModel._(
      {required this.id,
      this.firstName,
      this.lastName,
      this.username,
      required this.level,
      required this.coins,
      required this.profitPerHour,
      this.profileImage})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'PlayerModel', 'id');
    BuiltValueNullFieldError.checkNotNull(level, r'PlayerModel', 'level');
    BuiltValueNullFieldError.checkNotNull(coins, r'PlayerModel', 'coins');
    BuiltValueNullFieldError.checkNotNull(
        profitPerHour, r'PlayerModel', 'profitPerHour');
  }

  @override
  PlayerModel rebuild(void Function(PlayerModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PlayerModelBuilder toBuilder() => new PlayerModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PlayerModel &&
        id == other.id &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        username == other.username &&
        level == other.level &&
        coins == other.coins &&
        profitPerHour == other.profitPerHour &&
        profileImage == other.profileImage;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, firstName.hashCode);
    _$hash = $jc(_$hash, lastName.hashCode);
    _$hash = $jc(_$hash, username.hashCode);
    _$hash = $jc(_$hash, level.hashCode);
    _$hash = $jc(_$hash, coins.hashCode);
    _$hash = $jc(_$hash, profitPerHour.hashCode);
    _$hash = $jc(_$hash, profileImage.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PlayerModel')
          ..add('id', id)
          ..add('firstName', firstName)
          ..add('lastName', lastName)
          ..add('username', username)
          ..add('level', level)
          ..add('coins', coins)
          ..add('profitPerHour', profitPerHour)
          ..add('profileImage', profileImage))
        .toString();
  }
}

class PlayerModelBuilder implements Builder<PlayerModel, PlayerModelBuilder> {
  _$PlayerModel? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _firstName;
  String? get firstName => _$this._firstName;
  set firstName(String? firstName) => _$this._firstName = firstName;

  String? _lastName;
  String? get lastName => _$this._lastName;
  set lastName(String? lastName) => _$this._lastName = lastName;

  String? _username;
  String? get username => _$this._username;
  set username(String? username) => _$this._username = username;

  int? _level;
  int? get level => _$this._level;
  set level(int? level) => _$this._level = level;

  int? _coins;
  int? get coins => _$this._coins;
  set coins(int? coins) => _$this._coins = coins;

  double? _profitPerHour;
  double? get profitPerHour => _$this._profitPerHour;
  set profitPerHour(double? profitPerHour) =>
      _$this._profitPerHour = profitPerHour;

  String? _profileImage;
  String? get profileImage => _$this._profileImage;
  set profileImage(String? profileImage) => _$this._profileImage = profileImage;

  PlayerModelBuilder();

  PlayerModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _firstName = $v.firstName;
      _lastName = $v.lastName;
      _username = $v.username;
      _level = $v.level;
      _coins = $v.coins;
      _profitPerHour = $v.profitPerHour;
      _profileImage = $v.profileImage;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PlayerModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PlayerModel;
  }

  @override
  void update(void Function(PlayerModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PlayerModel build() => _build();

  _$PlayerModel _build() {
    final _$result = _$v ??
        new _$PlayerModel._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'PlayerModel', 'id'),
            firstName: firstName,
            lastName: lastName,
            username: username,
            level: BuiltValueNullFieldError.checkNotNull(
                level, r'PlayerModel', 'level'),
            coins: BuiltValueNullFieldError.checkNotNull(
                coins, r'PlayerModel', 'coins'),
            profitPerHour: BuiltValueNullFieldError.checkNotNull(
                profitPerHour, r'PlayerModel', 'profitPerHour'),
            profileImage: profileImage);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
