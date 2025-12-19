// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_state.dart';

mixin _$SearchState {
  bool get loading => throw UnimplementedError();
  int get offset => throw UnimplementedError();
  int get pageSize => throw UnimplementedError();
  CardInfoResponse? get response => throw UnimplementedError();
  String? get error => throw UnimplementedError();

  $SearchStateCopyWith<SearchState> get copyWith =>
      throw UnimplementedError();
}

abstract class $SearchStateCopyWith<$Res> {
  factory $SearchStateCopyWith(
          SearchState value, $Res Function(SearchState) then) =
      _$SearchStateCopyWithImpl<$Res>;
  $Res call({
    bool loading,
    int offset,
    int pageSize,
    CardInfoResponse? response,
    String? error,
  });
}

class _$SearchStateCopyWithImpl<$Res> implements $SearchStateCopyWith<$Res> {
  _$SearchStateCopyWithImpl(this._value, this._then);

  final SearchState _value;
  final $Res Function(SearchState) _then;

  @override
  $Res call({
    Object? loading = null,
    Object? offset = null,
    Object? pageSize = null,
    Object? response = freezed,
    Object? error = freezed,
  }) {
    return _then(
      _value.copyWith(
        loading: loading == null ? _value.loading : loading as bool,
        offset: offset == null ? _value.offset : offset as int,
        pageSize: pageSize == null ? _value.pageSize : pageSize as int,
        response: response == freezed
            ? _value.response
            : response as CardInfoResponse?,
        error: error == freezed ? _value.error : error as String?,
      ),
    );
  }
}

abstract class _SearchState implements SearchState {
  const factory _SearchState({
    bool loading,
    int offset,
    int pageSize,
    CardInfoResponse? response,
    String? error,
  }) = _$_SearchState;
}

class _$_SearchState implements _SearchState {
  const _$_SearchState({
    this.loading = false,
    this.offset = 0,
    this.pageSize = 20,
    this.response,
    this.error,
  });

  @override
  final bool loading;
  @override
  final int offset;
  @override
  final int pageSize;
  @override
  final CardInfoResponse? response;
  @override
  final String? error;

  @override
  String toString() {
    return 'SearchState(loading: $loading, offset: $offset, pageSize: $pageSize, response: $response, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is _$_SearchState &&
            other.loading == loading &&
            other.offset == offset &&
            other.pageSize == pageSize &&
            other.response == response &&
            other.error == error);
  }

  @override
  int get hashCode => Object.hash(
        loading,
        offset,
        pageSize,
        response,
        error,
      );

  @override
  _$_SearchStateCopyWith<_$_SearchState> get copyWith =>
      _$_SearchStateCopyWithImpl<_$_SearchState>(this, (value) => value);
}

abstract class _$_SearchStateCopyWith<$Res>
    implements $SearchStateCopyWith<$Res> {
  factory _$_SearchStateCopyWith(
          _$_SearchState value, $Res Function(_$_SearchState) then) =
      _$_SearchStateCopyWithImpl<$Res>;
  @override
  $Res call({
    bool loading,
    int offset,
    int pageSize,
    CardInfoResponse? response,
    String? error,
  });
}

class _$_SearchStateCopyWithImpl<$Res>
    extends _$SearchStateCopyWithImpl<$Res>
    implements _$_SearchStateCopyWith<$Res> {
  _$_SearchStateCopyWithImpl(
      _$_SearchState value, $Res Function(_$_SearchState) then)
      : super(value, (value) => then(value as _$_SearchState));

  @override
  _$_SearchState get _value => super._value as _$_SearchState;

  @override
  $Res call({
    Object? loading = null,
    Object? offset = null,
    Object? pageSize = null,
    Object? response = freezed,
    Object? error = freezed,
  }) {
    return _then(
      _$_SearchState(
        loading: loading == null ? _value.loading : loading as bool,
        offset: offset == null ? _value.offset : offset as int,
        pageSize: pageSize == null ? _value.pageSize : pageSize as int,
        response: response == freezed
            ? _value.response
            : response as CardInfoResponse?,
        error: error == freezed ? _value.error : error as String?,
      ),
    );
  }
}

const Object? freezed = null;
