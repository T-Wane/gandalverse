// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<UserModel> _$userModelSerializer = new _$UserModelSerializer();

class _$UserModelSerializer implements StructuredSerializer<UserModel> {
  @override
  final Iterable<Type> types = const [UserModel, _$UserModel];
  @override
  final String wireName = 'UserModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, UserModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'telegramId',
      serializers.serialize(object.telegramId,
          specifiedType: const FullType(int)),
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
    value = object.photoUrl;
    if (value != null) {
      result
        ..add('photoUrl')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.parrainId;
    if (value != null) {
      result
        ..add('parrainId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.friends;
    if (value != null) {
      result
        ..add('friends')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                BuiltList, const [const FullType(FriendModel)])));
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
  UserModel deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserModelBuilder();

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
        case 'telegramId':
          result.telegramId = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
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
        case 'photoUrl':
          result.photoUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'parrainId':
          result.parrainId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'friends':
          result.friends.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(FriendModel)]))!
              as BuiltList<Object?>);
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

class _$UserModel extends UserModel {
  @override
  final String id;
  @override
  final int telegramId;
  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final String? username;
  @override
  final String? photoUrl;
  @override
  final String? parrainId;
  @override
  final BuiltList<FriendModel>? friends;
  @override
  final int level;
  @override
  final int coins;
  @override
  final double profitPerHour;
  @override
  final String? profileImage;

  factory _$UserModel([void Function(UserModelBuilder)? updates]) =>
      (new UserModelBuilder()..update(updates))._build();

  _$UserModel._(
      {required this.id,
      required this.telegramId,
      this.firstName,
      this.lastName,
      this.username,
      this.photoUrl,
      this.parrainId,
      this.friends,
      required this.level,
      required this.coins,
      required this.profitPerHour,
      this.profileImage})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'UserModel', 'id');
    BuiltValueNullFieldError.checkNotNull(
        telegramId, r'UserModel', 'telegramId');
    BuiltValueNullFieldError.checkNotNull(level, r'UserModel', 'level');
    BuiltValueNullFieldError.checkNotNull(coins, r'UserModel', 'coins');
    BuiltValueNullFieldError.checkNotNull(
        profitPerHour, r'UserModel', 'profitPerHour');
  }

  @override
  UserModel rebuild(void Function(UserModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserModelBuilder toBuilder() => new UserModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserModel &&
        id == other.id &&
        telegramId == other.telegramId &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        username == other.username &&
        photoUrl == other.photoUrl &&
        parrainId == other.parrainId &&
        friends == other.friends &&
        level == other.level &&
        coins == other.coins &&
        profitPerHour == other.profitPerHour &&
        profileImage == other.profileImage;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, telegramId.hashCode);
    _$hash = $jc(_$hash, firstName.hashCode);
    _$hash = $jc(_$hash, lastName.hashCode);
    _$hash = $jc(_$hash, username.hashCode);
    _$hash = $jc(_$hash, photoUrl.hashCode);
    _$hash = $jc(_$hash, parrainId.hashCode);
    _$hash = $jc(_$hash, friends.hashCode);
    _$hash = $jc(_$hash, level.hashCode);
    _$hash = $jc(_$hash, coins.hashCode);
    _$hash = $jc(_$hash, profitPerHour.hashCode);
    _$hash = $jc(_$hash, profileImage.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UserModel')
          ..add('id', id)
          ..add('telegramId', telegramId)
          ..add('firstName', firstName)
          ..add('lastName', lastName)
          ..add('username', username)
          ..add('photoUrl', photoUrl)
          ..add('parrainId', parrainId)
          ..add('friends', friends)
          ..add('level', level)
          ..add('coins', coins)
          ..add('profitPerHour', profitPerHour)
          ..add('profileImage', profileImage))
        .toString();
  }
}

class UserModelBuilder implements Builder<UserModel, UserModelBuilder> {
  _$UserModel? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  int? _telegramId;
  int? get telegramId => _$this._telegramId;
  set telegramId(int? telegramId) => _$this._telegramId = telegramId;

  String? _firstName;
  String? get firstName => _$this._firstName;
  set firstName(String? firstName) => _$this._firstName = firstName;

  String? _lastName;
  String? get lastName => _$this._lastName;
  set lastName(String? lastName) => _$this._lastName = lastName;

  String? _username;
  String? get username => _$this._username;
  set username(String? username) => _$this._username = username;

  String? _photoUrl;
  String? get photoUrl => _$this._photoUrl;
  set photoUrl(String? photoUrl) => _$this._photoUrl = photoUrl;

  String? _parrainId;
  String? get parrainId => _$this._parrainId;
  set parrainId(String? parrainId) => _$this._parrainId = parrainId;

  ListBuilder<FriendModel>? _friends;
  ListBuilder<FriendModel> get friends =>
      _$this._friends ??= new ListBuilder<FriendModel>();
  set friends(ListBuilder<FriendModel>? friends) => _$this._friends = friends;

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

  UserModelBuilder();

  UserModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _telegramId = $v.telegramId;
      _firstName = $v.firstName;
      _lastName = $v.lastName;
      _username = $v.username;
      _photoUrl = $v.photoUrl;
      _parrainId = $v.parrainId;
      _friends = $v.friends?.toBuilder();
      _level = $v.level;
      _coins = $v.coins;
      _profitPerHour = $v.profitPerHour;
      _profileImage = $v.profileImage;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UserModel;
  }

  @override
  void update(void Function(UserModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UserModel build() => _build();

  _$UserModel _build() {
    _$UserModel _$result;
    try {
      _$result = _$v ??
          new _$UserModel._(
              id: BuiltValueNullFieldError.checkNotNull(id, r'UserModel', 'id'),
              telegramId: BuiltValueNullFieldError.checkNotNull(
                  telegramId, r'UserModel', 'telegramId'),
              firstName: firstName,
              lastName: lastName,
              username: username,
              photoUrl: photoUrl,
              parrainId: parrainId,
              friends: _friends?.build(),
              level: BuiltValueNullFieldError.checkNotNull(
                  level, r'UserModel', 'level'),
              coins: BuiltValueNullFieldError.checkNotNull(
                  coins, r'UserModel', 'coins'),
              profitPerHour: BuiltValueNullFieldError.checkNotNull(
                  profitPerHour, r'UserModel', 'profitPerHour'),
              profileImage: profileImage);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'friends';
        _friends?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'UserModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
