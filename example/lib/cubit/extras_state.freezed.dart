// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extras_state.dart';

mixin _$ExtrasState {
  bool get loadingRandom => throw UnimplementedError();
  bool get loadingArchetypes => throw UnimplementedError();
  bool get loadingSets => throw UnimplementedError();
  Card? get randomCard => throw UnimplementedError();
  List<CardArchetype>? get archetypes => throw UnimplementedError();
  List<CardSetListItem>? get sets => throw UnimplementedError();
  String? get randomError => throw UnimplementedError();
  String? get archetypesError => throw UnimplementedError();
  String? get setsError => throw UnimplementedError();

  $ExtrasStateCopyWith<ExtrasState> get copyWith =>
      throw UnimplementedError();
}

abstract class $ExtrasStateCopyWith<$Res> {
  factory $ExtrasStateCopyWith(
          ExtrasState value, $Res Function(ExtrasState) then) =
      _$ExtrasStateCopyWithImpl<$Res>;
  $Res call({
    bool loadingRandom,
    bool loadingArchetypes,
    bool loadingSets,
    Card? randomCard,
    List<CardArchetype>? archetypes,
    List<CardSetListItem>? sets,
    String? randomError,
    String? archetypesError,
    String? setsError,
  });
}

class _$ExtrasStateCopyWithImpl<$Res> implements $ExtrasStateCopyWith<$Res> {
  _$ExtrasStateCopyWithImpl(this._value, this._then);

  final ExtrasState _value;
  final $Res Function(ExtrasState) _then;

  @override
  $Res call({
    Object? loadingRandom = null,
    Object? loadingArchetypes = null,
    Object? loadingSets = null,
    Object? randomCard = freezed,
    Object? archetypes = freezed,
    Object? sets = freezed,
    Object? randomError = freezed,
    Object? archetypesError = freezed,
    Object? setsError = freezed,
  }) {
    return _then(
      _value.copyWith(
        loadingRandom: loadingRandom == null
            ? _value.loadingRandom
            : loadingRandom as bool,
        loadingArchetypes: loadingArchetypes == null
            ? _value.loadingArchetypes
            : loadingArchetypes as bool,
        loadingSets:
            loadingSets == null ? _value.loadingSets : loadingSets as bool,
        randomCard:
            randomCard == freezed ? _value.randomCard : randomCard as Card?,
        archetypes: archetypes == freezed
            ? _value.archetypes
            : archetypes as List<CardArchetype>?,
        sets: sets == freezed ? _value.sets : sets as List<CardSetListItem>?,
        randomError:
            randomError == freezed ? _value.randomError : randomError as String?,
        archetypesError: archetypesError == freezed
            ? _value.archetypesError
            : archetypesError as String?,
        setsError:
            setsError == freezed ? _value.setsError : setsError as String?,
      ),
    );
  }
}

abstract class _ExtrasState implements ExtrasState {
  const factory _ExtrasState({
    bool loadingRandom,
    bool loadingArchetypes,
    bool loadingSets,
    Card? randomCard,
    List<CardArchetype>? archetypes,
    List<CardSetListItem>? sets,
    String? randomError,
    String? archetypesError,
    String? setsError,
  }) = _$_ExtrasState;
}

class _$_ExtrasState implements _ExtrasState {
  const _$_ExtrasState({
    this.loadingRandom = false,
    this.loadingArchetypes = false,
    this.loadingSets = false,
    this.randomCard,
    this.archetypes,
    this.sets,
    this.randomError,
    this.archetypesError,
    this.setsError,
  });

  @override
  final bool loadingRandom;
  @override
  final bool loadingArchetypes;
  @override
  final bool loadingSets;
  @override
  final Card? randomCard;
  @override
  final List<CardArchetype>? archetypes;
  @override
  final List<CardSetListItem>? sets;
  @override
  final String? randomError;
  @override
  final String? archetypesError;
  @override
  final String? setsError;

  @override
  String toString() {
    return 'ExtrasState(loadingRandom: $loadingRandom, loadingArchetypes: $loadingArchetypes, loadingSets: $loadingSets, randomCard: $randomCard, archetypes: $archetypes, sets: $sets, randomError: $randomError, archetypesError: $archetypesError, setsError: $setsError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is _$_ExtrasState &&
            other.loadingRandom == loadingRandom &&
            other.loadingArchetypes == loadingArchetypes &&
            other.loadingSets == loadingSets &&
            other.randomCard == randomCard &&
            other.archetypes == archetypes &&
            other.sets == sets &&
            other.randomError == randomError &&
            other.archetypesError == archetypesError &&
            other.setsError == setsError);
  }

  @override
  int get hashCode => Object.hash(
        loadingRandom,
        loadingArchetypes,
        loadingSets,
        randomCard,
        archetypes,
        sets,
        randomError,
        archetypesError,
        setsError,
      );

  @override
  _$_ExtrasStateCopyWith<_$_ExtrasState> get copyWith =>
      _$_ExtrasStateCopyWithImpl<_$_ExtrasState>(this, (value) => value);
}

abstract class _$_ExtrasStateCopyWith<$Res>
    implements $ExtrasStateCopyWith<$Res> {
  factory _$_ExtrasStateCopyWith(
          _$_ExtrasState value, $Res Function(_$_ExtrasState) then) =
      _$_ExtrasStateCopyWithImpl<$Res>;
  @override
  $Res call({
    bool loadingRandom,
    bool loadingArchetypes,
    bool loadingSets,
    Card? randomCard,
    List<CardArchetype>? archetypes,
    List<CardSetListItem>? sets,
    String? randomError,
    String? archetypesError,
    String? setsError,
  });
}

class _$_ExtrasStateCopyWithImpl<$Res>
    extends _$ExtrasStateCopyWithImpl<$Res>
    implements _$_ExtrasStateCopyWith<$Res> {
  _$_ExtrasStateCopyWithImpl(
      _$_ExtrasState value, $Res Function(_$_ExtrasState) then)
      : super(value, (value) => then(value as _$_ExtrasState));

  @override
  _$_ExtrasState get _value => super._value as _$_ExtrasState;

  @override
  $Res call({
    Object? loadingRandom = null,
    Object? loadingArchetypes = null,
    Object? loadingSets = null,
    Object? randomCard = freezed,
    Object? archetypes = freezed,
    Object? sets = freezed,
    Object? randomError = freezed,
    Object? archetypesError = freezed,
    Object? setsError = freezed,
  }) {
    return _then(
      _$_ExtrasState(
        loadingRandom: loadingRandom == null
            ? _value.loadingRandom
            : loadingRandom as bool,
        loadingArchetypes: loadingArchetypes == null
            ? _value.loadingArchetypes
            : loadingArchetypes as bool,
        loadingSets:
            loadingSets == null ? _value.loadingSets : loadingSets as bool,
        randomCard:
            randomCard == freezed ? _value.randomCard : randomCard as Card?,
        archetypes: archetypes == freezed
            ? _value.archetypes
            : archetypes as List<CardArchetype>?,
        sets: sets == freezed ? _value.sets : sets as List<CardSetListItem>?,
        randomError:
            randomError == freezed ? _value.randomError : randomError as String?,
        archetypesError: archetypesError == freezed
            ? _value.archetypesError
            : archetypesError as String?,
        setsError:
            setsError == freezed ? _value.setsError : setsError as String?,
      ),
    );
  }
}

const Object? freezed = null;
