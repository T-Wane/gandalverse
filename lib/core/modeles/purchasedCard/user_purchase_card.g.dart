// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_purchase_card.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<UserPurchaseCard> _$userPurchaseCardSerializer =
    new _$UserPurchaseCardSerializer();

class _$UserPurchaseCardSerializer
    implements StructuredSerializer<UserPurchaseCard> {
  @override
  final Iterable<Type> types = const [UserPurchaseCard, _$UserPurchaseCard];
  @override
  final String wireName = 'UserPurchaseCard';

  @override
  Iterable<Object?> serialize(Serializers serializers, UserPurchaseCard object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'categorie_carte',
      serializers.serialize(object.categorieCarte,
          specifiedType: const FullType(String)),
      'est_achete',
      serializers.serialize(object.estAchete,
          specifiedType: const FullType(bool)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'niveau',
      serializers.serialize(object.niveau, specifiedType: const FullType(int)),
      'nom',
      serializers.serialize(object.nom, specifiedType: const FullType(String)),
      'profilParHeure',
      serializers.serialize(object.profilParHeure,
          specifiedType: const FullType(double)),
    ];

    return result;
  }

  @override
  UserPurchaseCard deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserPurchaseCardBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'categorie_carte':
          result.categorieCarte = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'est_achete':
          result.estAchete = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'niveau':
          result.niveau = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'nom':
          result.nom = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'profilParHeure':
          result.profilParHeure = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
      }
    }

    return result.build();
  }
}

class _$UserPurchaseCard extends UserPurchaseCard {
  @override
  final String categorieCarte;
  @override
  final bool estAchete;
  @override
  final String id;
  @override
  final int niveau;
  @override
  final String nom;
  @override
  final double profilParHeure;

  factory _$UserPurchaseCard(
          [void Function(UserPurchaseCardBuilder)? updates]) =>
      (new UserPurchaseCardBuilder()..update(updates))._build();

  _$UserPurchaseCard._(
      {required this.categorieCarte,
      required this.estAchete,
      required this.id,
      required this.niveau,
      required this.nom,
      required this.profilParHeure})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        categorieCarte, r'UserPurchaseCard', 'categorieCarte');
    BuiltValueNullFieldError.checkNotNull(
        estAchete, r'UserPurchaseCard', 'estAchete');
    BuiltValueNullFieldError.checkNotNull(id, r'UserPurchaseCard', 'id');
    BuiltValueNullFieldError.checkNotNull(
        niveau, r'UserPurchaseCard', 'niveau');
    BuiltValueNullFieldError.checkNotNull(nom, r'UserPurchaseCard', 'nom');
    BuiltValueNullFieldError.checkNotNull(
        profilParHeure, r'UserPurchaseCard', 'profilParHeure');
  }

  @override
  UserPurchaseCard rebuild(void Function(UserPurchaseCardBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserPurchaseCardBuilder toBuilder() =>
      new UserPurchaseCardBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserPurchaseCard &&
        categorieCarte == other.categorieCarte &&
        estAchete == other.estAchete &&
        id == other.id &&
        niveau == other.niveau &&
        nom == other.nom &&
        profilParHeure == other.profilParHeure;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, categorieCarte.hashCode);
    _$hash = $jc(_$hash, estAchete.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, niveau.hashCode);
    _$hash = $jc(_$hash, nom.hashCode);
    _$hash = $jc(_$hash, profilParHeure.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UserPurchaseCard')
          ..add('categorieCarte', categorieCarte)
          ..add('estAchete', estAchete)
          ..add('id', id)
          ..add('niveau', niveau)
          ..add('nom', nom)
          ..add('profilParHeure', profilParHeure))
        .toString();
  }
}

class UserPurchaseCardBuilder
    implements Builder<UserPurchaseCard, UserPurchaseCardBuilder> {
  _$UserPurchaseCard? _$v;

  String? _categorieCarte;
  String? get categorieCarte => _$this._categorieCarte;
  set categorieCarte(String? categorieCarte) =>
      _$this._categorieCarte = categorieCarte;

  bool? _estAchete;
  bool? get estAchete => _$this._estAchete;
  set estAchete(bool? estAchete) => _$this._estAchete = estAchete;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  int? _niveau;
  int? get niveau => _$this._niveau;
  set niveau(int? niveau) => _$this._niveau = niveau;

  String? _nom;
  String? get nom => _$this._nom;
  set nom(String? nom) => _$this._nom = nom;

  double? _profilParHeure;
  double? get profilParHeure => _$this._profilParHeure;
  set profilParHeure(double? profilParHeure) =>
      _$this._profilParHeure = profilParHeure;

  UserPurchaseCardBuilder();

  UserPurchaseCardBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _categorieCarte = $v.categorieCarte;
      _estAchete = $v.estAchete;
      _id = $v.id;
      _niveau = $v.niveau;
      _nom = $v.nom;
      _profilParHeure = $v.profilParHeure;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserPurchaseCard other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UserPurchaseCard;
  }

  @override
  void update(void Function(UserPurchaseCardBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UserPurchaseCard build() => _build();

  _$UserPurchaseCard _build() {
    final _$result = _$v ??
        new _$UserPurchaseCard._(
            categorieCarte: BuiltValueNullFieldError.checkNotNull(
                categorieCarte, r'UserPurchaseCard', 'categorieCarte'),
            estAchete: BuiltValueNullFieldError.checkNotNull(
                estAchete, r'UserPurchaseCard', 'estAchete'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'UserPurchaseCard', 'id'),
            niveau: BuiltValueNullFieldError.checkNotNull(
                niveau, r'UserPurchaseCard', 'niveau'),
            nom: BuiltValueNullFieldError.checkNotNull(
                nom, r'UserPurchaseCard', 'nom'),
            profilParHeure: BuiltValueNullFieldError.checkNotNull(
                profilParHeure, r'UserPurchaseCard', 'profilParHeure'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
