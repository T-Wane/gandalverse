// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carte.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<CarteModel> _$carteModelSerializer = new _$CarteModelSerializer();

class _$CarteModelSerializer implements StructuredSerializer<CarteModel> {
  @override
  final Iterable<Type> types = const [CarteModel, _$CarteModel];
  @override
  final String wireName = 'CarteModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, CarteModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'nom',
      serializers.serialize(object.nom, specifiedType: const FullType(String)),
      'description',
      serializers.serialize(object.description,
          specifiedType: const FullType(String)),
      'image',
      serializers.serialize(object.image,
          specifiedType: const FullType(String)),
      'prix',
      serializers.serialize(object.prix, specifiedType: const FullType(double)),
      'taux_augmentation',
      serializers.serialize(object.tauxAugmentation,
          specifiedType: const FullType(double)),
      'niveau',
      serializers.serialize(object.niveau, specifiedType: const FullType(int)),
      'est_achete',
      serializers.serialize(object.estAchete,
          specifiedType: const FullType(bool)),
      'force',
      serializers.serialize(object.force,
          specifiedType: const FullType(double)),
      'taux_augmentation_force',
      serializers.serialize(object.tauxAugmentationForce,
          specifiedType: const FullType(double)),
    ];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.competences;
    if (value != null) {
      result
        ..add('competences')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    return result;
  }

  @override
  CarteModel deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CarteModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'nom':
          result.nom = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'competences':
          result.competences.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
        case 'image':
          result.image = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'prix':
          result.prix = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'taux_augmentation':
          result.tauxAugmentation = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'niveau':
          result.niveau = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'est_achete':
          result.estAchete = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'force':
          result.force = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'taux_augmentation_force':
          result.tauxAugmentationForce = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
      }
    }

    return result.build();
  }
}

class _$CarteModel extends CarteModel {
  @override
  final String? id;
  @override
  final String nom;
  @override
  final String description;
  @override
  final BuiltList<String>? competences;
  @override
  final String image;
  @override
  final double prix;
  @override
  final double tauxAugmentation;
  @override
  final int niveau;
  @override
  final bool estAchete;
  @override
  final double force;
  @override
  final double tauxAugmentationForce;

  factory _$CarteModel([void Function(CarteModelBuilder)? updates]) =>
      (new CarteModelBuilder()..update(updates))._build();

  _$CarteModel._(
      {this.id,
      required this.nom,
      required this.description,
      this.competences,
      required this.image,
      required this.prix,
      required this.tauxAugmentation,
      required this.niveau,
      required this.estAchete,
      required this.force,
      required this.tauxAugmentationForce})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(nom, r'CarteModel', 'nom');
    BuiltValueNullFieldError.checkNotNull(
        description, r'CarteModel', 'description');
    BuiltValueNullFieldError.checkNotNull(image, r'CarteModel', 'image');
    BuiltValueNullFieldError.checkNotNull(prix, r'CarteModel', 'prix');
    BuiltValueNullFieldError.checkNotNull(
        tauxAugmentation, r'CarteModel', 'tauxAugmentation');
    BuiltValueNullFieldError.checkNotNull(niveau, r'CarteModel', 'niveau');
    BuiltValueNullFieldError.checkNotNull(
        estAchete, r'CarteModel', 'estAchete');
    BuiltValueNullFieldError.checkNotNull(force, r'CarteModel', 'force');
    BuiltValueNullFieldError.checkNotNull(
        tauxAugmentationForce, r'CarteModel', 'tauxAugmentationForce');
  }

  @override
  CarteModel rebuild(void Function(CarteModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CarteModelBuilder toBuilder() => new CarteModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CarteModel &&
        id == other.id &&
        nom == other.nom &&
        description == other.description &&
        competences == other.competences &&
        image == other.image &&
        prix == other.prix &&
        tauxAugmentation == other.tauxAugmentation &&
        niveau == other.niveau &&
        estAchete == other.estAchete &&
        force == other.force &&
        tauxAugmentationForce == other.tauxAugmentationForce;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, nom.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, competences.hashCode);
    _$hash = $jc(_$hash, image.hashCode);
    _$hash = $jc(_$hash, prix.hashCode);
    _$hash = $jc(_$hash, tauxAugmentation.hashCode);
    _$hash = $jc(_$hash, niveau.hashCode);
    _$hash = $jc(_$hash, estAchete.hashCode);
    _$hash = $jc(_$hash, force.hashCode);
    _$hash = $jc(_$hash, tauxAugmentationForce.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CarteModel')
          ..add('id', id)
          ..add('nom', nom)
          ..add('description', description)
          ..add('competences', competences)
          ..add('image', image)
          ..add('prix', prix)
          ..add('tauxAugmentation', tauxAugmentation)
          ..add('niveau', niveau)
          ..add('estAchete', estAchete)
          ..add('force', force)
          ..add('tauxAugmentationForce', tauxAugmentationForce))
        .toString();
  }
}

class CarteModelBuilder implements Builder<CarteModel, CarteModelBuilder> {
  _$CarteModel? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _nom;
  String? get nom => _$this._nom;
  set nom(String? nom) => _$this._nom = nom;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  ListBuilder<String>? _competences;
  ListBuilder<String> get competences =>
      _$this._competences ??= new ListBuilder<String>();
  set competences(ListBuilder<String>? competences) =>
      _$this._competences = competences;

  String? _image;
  String? get image => _$this._image;
  set image(String? image) => _$this._image = image;

  double? _prix;
  double? get prix => _$this._prix;
  set prix(double? prix) => _$this._prix = prix;

  double? _tauxAugmentation;
  double? get tauxAugmentation => _$this._tauxAugmentation;
  set tauxAugmentation(double? tauxAugmentation) =>
      _$this._tauxAugmentation = tauxAugmentation;

  int? _niveau;
  int? get niveau => _$this._niveau;
  set niveau(int? niveau) => _$this._niveau = niveau;

  bool? _estAchete;
  bool? get estAchete => _$this._estAchete;
  set estAchete(bool? estAchete) => _$this._estAchete = estAchete;

  double? _force;
  double? get force => _$this._force;
  set force(double? force) => _$this._force = force;

  double? _tauxAugmentationForce;
  double? get tauxAugmentationForce => _$this._tauxAugmentationForce;
  set tauxAugmentationForce(double? tauxAugmentationForce) =>
      _$this._tauxAugmentationForce = tauxAugmentationForce;

  CarteModelBuilder();

  CarteModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _nom = $v.nom;
      _description = $v.description;
      _competences = $v.competences?.toBuilder();
      _image = $v.image;
      _prix = $v.prix;
      _tauxAugmentation = $v.tauxAugmentation;
      _niveau = $v.niveau;
      _estAchete = $v.estAchete;
      _force = $v.force;
      _tauxAugmentationForce = $v.tauxAugmentationForce;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CarteModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CarteModel;
  }

  @override
  void update(void Function(CarteModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CarteModel build() => _build();

  _$CarteModel _build() {
    _$CarteModel _$result;
    try {
      _$result = _$v ??
          new _$CarteModel._(
              id: id,
              nom: BuiltValueNullFieldError.checkNotNull(
                  nom, r'CarteModel', 'nom'),
              description: BuiltValueNullFieldError.checkNotNull(
                  description, r'CarteModel', 'description'),
              competences: _competences?.build(),
              image: BuiltValueNullFieldError.checkNotNull(
                  image, r'CarteModel', 'image'),
              prix: BuiltValueNullFieldError.checkNotNull(
                  prix, r'CarteModel', 'prix'),
              tauxAugmentation: BuiltValueNullFieldError.checkNotNull(
                  tauxAugmentation, r'CarteModel', 'tauxAugmentation'),
              niveau: BuiltValueNullFieldError.checkNotNull(
                  niveau, r'CarteModel', 'niveau'),
              estAchete: BuiltValueNullFieldError.checkNotNull(
                  estAchete, r'CarteModel', 'estAchete'),
              force: BuiltValueNullFieldError.checkNotNull(
                  force, r'CarteModel', 'force'),
              tauxAugmentationForce: BuiltValueNullFieldError.checkNotNull(
                  tauxAugmentationForce,
                  r'CarteModel',
                  'tauxAugmentationForce'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'competences';
        _competences?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'CarteModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
