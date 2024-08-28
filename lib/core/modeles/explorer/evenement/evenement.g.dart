// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'evenement.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<EvenementModel> _$evenementModelSerializer =
    new _$EvenementModelSerializer();

class _$EvenementModelSerializer
    implements StructuredSerializer<EvenementModel> {
  @override
  final Iterable<Type> types = const [EvenementModel, _$EvenementModel];
  @override
  final String wireName = 'EvenementModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, EvenementModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.titre;
    if (value != null) {
      result
        ..add('titre')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.image;
    if (value != null) {
      result
        ..add('image')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.description;
    if (value != null) {
      result
        ..add('description')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  EvenementModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new EvenementModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'titre':
          result.titre = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'image':
          result.image = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$EvenementModel extends EvenementModel {
  @override
  final String? titre;
  @override
  final String? image;
  @override
  final String? description;
  @override
  final String? id;

  factory _$EvenementModel([void Function(EvenementModelBuilder)? updates]) =>
      (new EvenementModelBuilder()..update(updates))._build();

  _$EvenementModel._({this.titre, this.image, this.description, this.id})
      : super._();

  @override
  EvenementModel rebuild(void Function(EvenementModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EvenementModelBuilder toBuilder() =>
      new EvenementModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EvenementModel &&
        titre == other.titre &&
        image == other.image &&
        description == other.description &&
        id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, titre.hashCode);
    _$hash = $jc(_$hash, image.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EvenementModel')
          ..add('titre', titre)
          ..add('image', image)
          ..add('description', description)
          ..add('id', id))
        .toString();
  }
}

class EvenementModelBuilder
    implements Builder<EvenementModel, EvenementModelBuilder> {
  _$EvenementModel? _$v;

  String? _titre;
  String? get titre => _$this._titre;
  set titre(String? titre) => _$this._titre = titre;

  String? _image;
  String? get image => _$this._image;
  set image(String? image) => _$this._image = image;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  EvenementModelBuilder();

  EvenementModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _titre = $v.titre;
      _image = $v.image;
      _description = $v.description;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EvenementModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$EvenementModel;
  }

  @override
  void update(void Function(EvenementModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EvenementModel build() => _build();

  _$EvenementModel _build() {
    final _$result = _$v ??
        new _$EvenementModel._(
            titre: titre, image: image, description: description, id: id);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
