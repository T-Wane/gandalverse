// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_link.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SocialLinkModel> _$socialLinkModelSerializer =
    new _$SocialLinkModelSerializer();

class _$SocialLinkModelSerializer
    implements StructuredSerializer<SocialLinkModel> {
  @override
  final Iterable<Type> types = const [SocialLinkModel, _$SocialLinkModel];
  @override
  final String wireName = 'SocialLinkModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, SocialLinkModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'description',
      serializers.serialize(object.description,
          specifiedType: const FullType(String)),
      'subscriptionLink',
      serializers.serialize(object.subscriptionLink,
          specifiedType: const FullType(String)),
      'image',
      serializers.serialize(object.image,
          specifiedType: const FullType(String)),
      'reward',
      serializers.serialize(object.reward,
          specifiedType: const FullType(double)),
      'isSubscribed',
      serializers.serialize(object.isSubscribed,
          specifiedType: const FullType(bool)),
      'isVisible',
      serializers.serialize(object.isVisible,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  SocialLinkModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SocialLinkModelBuilder();

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
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'subscriptionLink':
          result.subscriptionLink = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'image':
          result.image = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'reward':
          result.reward = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'isSubscribed':
          result.isSubscribed = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'isVisible':
          result.isVisible = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$SocialLinkModel extends SocialLinkModel {
  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final String subscriptionLink;
  @override
  final String image;
  @override
  final double reward;
  @override
  final bool isSubscribed;
  @override
  final bool isVisible;

  factory _$SocialLinkModel([void Function(SocialLinkModelBuilder)? updates]) =>
      (new SocialLinkModelBuilder()..update(updates))._build();

  _$SocialLinkModel._(
      {required this.id,
      required this.title,
      required this.description,
      required this.subscriptionLink,
      required this.image,
      required this.reward,
      required this.isSubscribed,
      required this.isVisible})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'SocialLinkModel', 'id');
    BuiltValueNullFieldError.checkNotNull(title, r'SocialLinkModel', 'title');
    BuiltValueNullFieldError.checkNotNull(
        description, r'SocialLinkModel', 'description');
    BuiltValueNullFieldError.checkNotNull(
        subscriptionLink, r'SocialLinkModel', 'subscriptionLink');
    BuiltValueNullFieldError.checkNotNull(image, r'SocialLinkModel', 'image');
    BuiltValueNullFieldError.checkNotNull(reward, r'SocialLinkModel', 'reward');
    BuiltValueNullFieldError.checkNotNull(
        isSubscribed, r'SocialLinkModel', 'isSubscribed');
    BuiltValueNullFieldError.checkNotNull(
        isVisible, r'SocialLinkModel', 'isVisible');
  }

  @override
  SocialLinkModel rebuild(void Function(SocialLinkModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SocialLinkModelBuilder toBuilder() =>
      new SocialLinkModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SocialLinkModel &&
        id == other.id &&
        title == other.title &&
        description == other.description &&
        subscriptionLink == other.subscriptionLink &&
        image == other.image &&
        reward == other.reward &&
        isSubscribed == other.isSubscribed &&
        isVisible == other.isVisible;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, subscriptionLink.hashCode);
    _$hash = $jc(_$hash, image.hashCode);
    _$hash = $jc(_$hash, reward.hashCode);
    _$hash = $jc(_$hash, isSubscribed.hashCode);
    _$hash = $jc(_$hash, isVisible.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SocialLinkModel')
          ..add('id', id)
          ..add('title', title)
          ..add('description', description)
          ..add('subscriptionLink', subscriptionLink)
          ..add('image', image)
          ..add('reward', reward)
          ..add('isSubscribed', isSubscribed)
          ..add('isVisible', isVisible))
        .toString();
  }
}

class SocialLinkModelBuilder
    implements Builder<SocialLinkModel, SocialLinkModelBuilder> {
  _$SocialLinkModel? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _subscriptionLink;
  String? get subscriptionLink => _$this._subscriptionLink;
  set subscriptionLink(String? subscriptionLink) =>
      _$this._subscriptionLink = subscriptionLink;

  String? _image;
  String? get image => _$this._image;
  set image(String? image) => _$this._image = image;

  double? _reward;
  double? get reward => _$this._reward;
  set reward(double? reward) => _$this._reward = reward;

  bool? _isSubscribed;
  bool? get isSubscribed => _$this._isSubscribed;
  set isSubscribed(bool? isSubscribed) => _$this._isSubscribed = isSubscribed;

  bool? _isVisible;
  bool? get isVisible => _$this._isVisible;
  set isVisible(bool? isVisible) => _$this._isVisible = isVisible;

  SocialLinkModelBuilder();

  SocialLinkModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _description = $v.description;
      _subscriptionLink = $v.subscriptionLink;
      _image = $v.image;
      _reward = $v.reward;
      _isSubscribed = $v.isSubscribed;
      _isVisible = $v.isVisible;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SocialLinkModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SocialLinkModel;
  }

  @override
  void update(void Function(SocialLinkModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SocialLinkModel build() => _build();

  _$SocialLinkModel _build() {
    final _$result = _$v ??
        new _$SocialLinkModel._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'SocialLinkModel', 'id'),
            title: BuiltValueNullFieldError.checkNotNull(
                title, r'SocialLinkModel', 'title'),
            description: BuiltValueNullFieldError.checkNotNull(
                description, r'SocialLinkModel', 'description'),
            subscriptionLink: BuiltValueNullFieldError.checkNotNull(
                subscriptionLink, r'SocialLinkModel', 'subscriptionLink'),
            image: BuiltValueNullFieldError.checkNotNull(
                image, r'SocialLinkModel', 'image'),
            reward: BuiltValueNullFieldError.checkNotNull(
                reward, r'SocialLinkModel', 'reward'),
            isSubscribed: BuiltValueNullFieldError.checkNotNull(
                isSubscribed, r'SocialLinkModel', 'isSubscribed'),
            isVisible: BuiltValueNullFieldError.checkNotNull(
                isVisible, r'SocialLinkModel', 'isVisible'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
