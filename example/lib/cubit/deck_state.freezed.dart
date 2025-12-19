// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deck_state.dart';

mixin _$DeckState {
  bool get loading => throw UnimplementedError();
  List<Card>? get mainDeck => throw UnimplementedError();
  List<Card>? get extraDeck => throw UnimplementedError();
  List<Card>? get sideDeck => throw UnimplementedError();
  String? get error => throw UnimplementedError();

  $DeckStateCopyWith<DeckState> get copyWith => throw UnimplementedError();
}

abstract class $DeckStateCopyWith<$Res> {
  factory $DeckStateCopyWith(DeckState value, $Res Function(DeckState) then) =
      _$DeckStateCopyWithImpl<$Res>;
  $Res call({
    bool loading,
    List<Card>? mainDeck,
    List<Card>? extraDeck,
    List<Card>? sideDeck,
    String? error,
  });
}

class _$DeckStateCopyWithImpl<$Res> implements $DeckStateCopyWith<$Res> {
  _$DeckStateCopyWithImpl(this._value, this._then);

  final DeckState _value;
  final $Res Function(DeckState) _then;

  @override
  $Res call({
    Object? loading = null,
    Object? mainDeck = freezed,
    Object? extraDeck = freezed,
    Object? sideDeck = freezed,
    Object? error = freezed,
  }) {
    return _then(
      _value.copyWith(
        loading: loading == null ? _value.loading : loading as bool,
        mainDeck:
            mainDeck == freezed ? _value.mainDeck : mainDeck as List<Card>?,
        extraDeck:
            extraDeck == freezed ? _value.extraDeck : extraDeck as List<Card>?,
        sideDeck:
            sideDeck == freezed ? _value.sideDeck : sideDeck as List<Card>?,
        error: error == freezed ? _value.error : error as String?,
      ),
    );
  }
}

abstract class _DeckState implements DeckState {
  const factory _DeckState({
    bool loading,
    List<Card>? mainDeck,
    List<Card>? extraDeck,
    List<Card>? sideDeck,
    String? error,
  }) = _$_DeckState;
}

class _$_DeckState implements _DeckState {
  const _$_DeckState({
    this.loading = false,
    this.mainDeck,
    this.extraDeck,
    this.sideDeck,
    this.error,
  });

  @override
  final bool loading;
  @override
  final List<Card>? mainDeck;
  @override
  final List<Card>? extraDeck;
  @override
  final List<Card>? sideDeck;
  @override
  final String? error;

  @override
  String toString() {
    return 'DeckState(loading: $loading, mainDeck: $mainDeck, extraDeck: $extraDeck, sideDeck: $sideDeck, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is _$_DeckState &&
            other.loading == loading &&
            other.mainDeck == mainDeck &&
            other.extraDeck == extraDeck &&
            other.sideDeck == sideDeck &&
            other.error == error);
  }

  @override
  int get hashCode => Object.hash(
        loading,
        mainDeck,
        extraDeck,
        sideDeck,
        error,
      );

  @override
  _$_DeckStateCopyWith<_$_DeckState> get copyWith =>
      _$_DeckStateCopyWithImpl<_$_DeckState>(this, (value) => value);
}

abstract class _$_DeckStateCopyWith<$Res>
    implements $DeckStateCopyWith<$Res> {
  factory _$_DeckStateCopyWith(
          _$_DeckState value, $Res Function(_$_DeckState) then) =
      _$_DeckStateCopyWithImpl<$Res>;
  @override
  $Res call({
    bool loading,
    List<Card>? mainDeck,
    List<Card>? extraDeck,
    List<Card>? sideDeck,
    String? error,
  });
}

class _$_DeckStateCopyWithImpl<$Res>
    extends _$DeckStateCopyWithImpl<$Res>
    implements _$_DeckStateCopyWith<$Res> {
  _$_DeckStateCopyWithImpl(
      _$_DeckState value, $Res Function(_$_DeckState) then)
      : super(value, (value) => then(value as _$_DeckState));

  @override
  _$_DeckState get _value => super._value as _$_DeckState;

  @override
  $Res call({
    Object? loading = null,
    Object? mainDeck = freezed,
    Object? extraDeck = freezed,
    Object? sideDeck = freezed,
    Object? error = freezed,
  }) {
    return _then(
      _$_DeckState(
        loading: loading == null ? _value.loading : loading as bool,
        mainDeck:
            mainDeck == freezed ? _value.mainDeck : mainDeck as List<Card>?,
        extraDeck:
            extraDeck == freezed ? _value.extraDeck : extraDeck as List<Card>?,
        sideDeck:
            sideDeck == freezed ? _value.sideDeck : sideDeck as List<Card>?,
        error: error == freezed ? _value.error : error as String?,
      ),
    );
  }
}

const Object? freezed = null;
