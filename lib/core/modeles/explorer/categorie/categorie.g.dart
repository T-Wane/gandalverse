// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categorie.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CategorieType _$top20 = const CategorieType._('top20');
const CategorieType _$resto = const CategorieType._('resto');
const CategorieType _$banques = const CategorieType._('banques');
const CategorieType _$guichets = const CategorieType._('guichets');
const CategorieType _$tourisme = const CategorieType._('tourisme');
const CategorieType _$hotels = const CategorieType._('hotels');
const CategorieType _$shopping = const CategorieType._('shopping');

CategorieType _$valueOf(String name) {
  switch (name) {
    case 'top20':
      return _$top20;
    case 'resto':
      return _$resto;
    case 'banques':
      return _$banques;
    case 'guichets':
      return _$guichets;
    case 'tourisme':
      return _$tourisme;
    case 'hotels':
      return _$hotels;
    case 'shopping':
      return _$shopping;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<CategorieType> _$values =
    new BuiltSet<CategorieType>(const <CategorieType>[
  _$top20,
  _$resto,
  _$banques,
  _$guichets,
  _$tourisme,
  _$hotels,
  _$shopping,
]);

Serializer<CategorieType> _$categorieTypeSerializer =
    new _$CategorieTypeSerializer();
Serializer<CategorieModel> _$categorieModelSerializer =
    new _$CategorieModelSerializer();

class _$CategorieTypeSerializer implements PrimitiveSerializer<CategorieType> {
  @override
  final Iterable<Type> types = const <Type>[CategorieType];
  @override
  final String wireName = 'CategorieType';

  @override
  Object serialize(Serializers serializers, CategorieType object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  CategorieType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      CategorieType.valueOf(serialized as String);
}

class _$CategorieModelSerializer
    implements StructuredSerializer<CategorieModel> {
  @override
  final Iterable<Type> types = const [CategorieModel, _$CategorieModel];
  @override
  final String wireName = 'CategorieModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, CategorieModel object,
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
    value = object.categorieType;
    if (value != null) {
      result
        ..add('categorieType')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(CategorieType)));
    }
    return result;
  }

  @override
  CategorieModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CategorieModelBuilder();

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
        case 'categorieType':
          result.categorieType = serializers.deserialize(value,
              specifiedType: const FullType(CategorieType)) as CategorieType?;
          break;
      }
    }

    return result.build();
  }
}

class _$CategorieModel extends CategorieModel {
  @override
  final String? titre;
  @override
  final String? image;
  @override
  final String? description;
  @override
  final String? id;
  @override
  final CategorieType? categorieType;

  factory _$CategorieModel([void Function(CategorieModelBuilder)? updates]) =>
      (new CategorieModelBuilder()..update(updates))._build();

  _$CategorieModel._(
      {this.titre, this.image, this.description, this.id, this.categorieType})
      : super._();

  @override
  CategorieModel rebuild(void Function(CategorieModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CategorieModelBuilder toBuilder() =>
      new CategorieModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CategorieModel &&
        titre == other.titre &&
        image == other.image &&
        description == other.description &&
        id == other.id &&
        categorieType == other.categorieType;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, titre.hashCode);
    _$hash = $jc(_$hash, image.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, categorieType.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CategorieModel')
          ..add('titre', titre)
          ..add('image', image)
          ..add('description', description)
          ..add('id', id)
          ..add('categorieType', categorieType))
        .toString();
  }
}

class CategorieModelBuilder
    implements Builder<CategorieModel, CategorieModelBuilder> {
  _$CategorieModel? _$v;

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

  CategorieType? _categorieType;
  CategorieType? get categorieType => _$this._categorieType;
  set categorieType(CategorieType? categorieType) =>
      _$this._categorieType = categorieType;

  CategorieModelBuilder();

  CategorieModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _titre = $v.titre;
      _image = $v.image;
      _description = $v.description;
      _id = $v.id;
      _categorieType = $v.categorieType;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CategorieModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CategorieModel;
  }

  @override
  void update(void Function(CategorieModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CategorieModel build() => _build();

  _$CategorieModel _build() {
    final _$result = _$v ??
        new _$CategorieModel._(
            titre: titre,
            image: image,
            description: description,
            id: id,
            categorieType: categorieType);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
