// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cache_state.dart';

mixin _$CacheState {
  bool get loading => throw UnimplementedError();
  List<CacheEntryInfo> get entries => throw UnimplementedError();
  String? get error => throw UnimplementedError();

  $CacheStateCopyWith<CacheState> get copyWith =>
      throw UnimplementedError();
}

abstract class $CacheStateCopyWith<$Res> {
  factory $CacheStateCopyWith(CacheState value, $Res Function(CacheState) then) =
      _$CacheStateCopyWithImpl<$Res>;
  $Res call({bool loading, List<CacheEntryInfo> entries, String? error});
}

class _$CacheStateCopyWithImpl<$Res> implements $CacheStateCopyWith<$Res> {
  _$CacheStateCopyWithImpl(this._value, this._then);

  final CacheState _value;
  final $Res Function(CacheState) _then;

  @override
  $Res call({
    Object? loading = null,
    Object? entries = null,
    Object? error = freezed,
  }) {
    return _then(
      _value.copyWith(
        loading: loading == null ? _value.loading : loading as bool,
        entries: entries == null
            ? _value.entries
            : entries as List<CacheEntryInfo>,
        error: error == freezed ? _value.error : error as String?,
      ),
    );
  }
}

abstract class _CacheState implements CacheState {
  const factory _CacheState({
    bool loading,
    List<CacheEntryInfo> entries,
    String? error,
  }) = _$_CacheState;
}

class _$_CacheState implements _CacheState {
  const _$_CacheState({
    this.loading = false,
    this.entries = const <CacheEntryInfo>[],
    this.error,
  });

  @override
  final bool loading;
  @override
  final List<CacheEntryInfo> entries;
  @override
  final String? error;

  @override
  String toString() {
    return 'CacheState(loading: $loading, entries: $entries, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is _$_CacheState &&
            other.loading == loading &&
            other.entries == entries &&
            other.error == error);
  }

  @override
  int get hashCode => Object.hash(loading, entries, error);

  @override
  _$_CacheStateCopyWith<_$_CacheState> get copyWith =>
      _$_CacheStateCopyWithImpl<_$_CacheState>(this, (value) => value);
}

abstract class _$_CacheStateCopyWith<$Res>
    implements $CacheStateCopyWith<$Res> {
  factory _$_CacheStateCopyWith(
          _$_CacheState value, $Res Function(_$_CacheState) then) =
      _$_CacheStateCopyWithImpl<$Res>;
  @override
  $Res call({bool loading, List<CacheEntryInfo> entries, String? error});
}

class _$_CacheStateCopyWithImpl<$Res>
    extends _$CacheStateCopyWithImpl<$Res>
    implements _$_CacheStateCopyWith<$Res> {
  _$_CacheStateCopyWithImpl(
      _$_CacheState value, $Res Function(_$_CacheState) then)
      : super(value, (value) => then(value as _$_CacheState));

  @override
  _$_CacheState get _value => super._value as _$_CacheState;

  @override
  $Res call({
    Object? loading = null,
    Object? entries = null,
    Object? error = freezed,
  }) {
    return _then(
      _$_CacheState(
        loading: loading == null ? _value.loading : loading as bool,
        entries: entries == null
            ? _value.entries
            : entries as List<CacheEntryInfo>,
        error: error == freezed ? _value.error : error as String?,
      ),
    );
  }
}

const Object? freezed = null;
