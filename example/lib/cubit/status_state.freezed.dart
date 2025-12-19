// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_state.dart';

mixin _$StatusState {
  CacheMode get cacheMode => throw UnimplementedError();
  bool get showDebugLogs => throw UnimplementedError();
  bool get verboseLogging => throw UnimplementedError();
  bool get loadingDb => throw UnimplementedError();
  CheckDbVersion? get dbVersion => throw UnimplementedError();
  String? get error => throw UnimplementedError();

  $StatusStateCopyWith<StatusState> get copyWith => throw UnimplementedError();
}

abstract class $StatusStateCopyWith<$Res> {
  factory $StatusStateCopyWith(
          StatusState value, $Res Function(StatusState) then) =
      _$StatusStateCopyWithImpl<$Res>;
  $Res call({
    CacheMode cacheMode,
    bool showDebugLogs,
    bool verboseLogging,
    bool loadingDb,
    CheckDbVersion? dbVersion,
    String? error,
  });
}

class _$StatusStateCopyWithImpl<$Res> implements $StatusStateCopyWith<$Res> {
  _$StatusStateCopyWithImpl(this._value, this._then);

  final StatusState _value;
  final $Res Function(StatusState) _then;

  @override
  $Res call({
    Object? cacheMode = null,
    Object? showDebugLogs = null,
    Object? verboseLogging = null,
    Object? loadingDb = null,
    Object? dbVersion = freezed,
    Object? error = freezed,
  }) {
    return _then(
      _value.copyWith(
        cacheMode:
            cacheMode == null ? _value.cacheMode : cacheMode as CacheMode,
        showDebugLogs: showDebugLogs == null
            ? _value.showDebugLogs
            : showDebugLogs as bool,
        verboseLogging: verboseLogging == null
            ? _value.verboseLogging
            : verboseLogging as bool,
        loadingDb: loadingDb == null ? _value.loadingDb : loadingDb as bool,
        dbVersion: dbVersion == freezed
            ? _value.dbVersion
            : dbVersion as CheckDbVersion?,
        error: error == freezed ? _value.error : error as String?,
      ),
    );
  }
}

abstract class _StatusState implements StatusState {
  const factory _StatusState({
    required CacheMode cacheMode,
    required bool showDebugLogs,
    required bool verboseLogging,
    bool loadingDb,
    CheckDbVersion? dbVersion,
    String? error,
  }) = _$_StatusState;
}

class _$_StatusState implements _StatusState {
  const _$_StatusState({
    required this.cacheMode,
    required this.showDebugLogs,
    required this.verboseLogging,
    this.loadingDb = false,
    this.dbVersion,
    this.error,
  });

  @override
  final CacheMode cacheMode;
  @override
  final bool showDebugLogs;
  @override
  final bool verboseLogging;
  @override
  final bool loadingDb;
  @override
  final CheckDbVersion? dbVersion;
  @override
  final String? error;

  @override
  String toString() {
    return 'StatusState(cacheMode: $cacheMode, showDebugLogs: $showDebugLogs, verboseLogging: $verboseLogging, loadingDb: $loadingDb, dbVersion: $dbVersion, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is _$_StatusState &&
            other.cacheMode == cacheMode &&
            other.showDebugLogs == showDebugLogs &&
            other.verboseLogging == verboseLogging &&
            other.loadingDb == loadingDb &&
            other.dbVersion == dbVersion &&
            other.error == error);
  }

  @override
  int get hashCode => Object.hash(
        cacheMode,
        showDebugLogs,
        verboseLogging,
        loadingDb,
        dbVersion,
        error,
      );

  @override
  _$_StatusStateCopyWith<_$_StatusState> get copyWith =>
      _$_StatusStateCopyWithImpl<_$_StatusState>(this, (value) => value);
}

abstract class _$_StatusStateCopyWith<$Res>
    implements $StatusStateCopyWith<$Res> {
  factory _$_StatusStateCopyWith(
          _$_StatusState value, $Res Function(_$_StatusState) then) =
      _$_StatusStateCopyWithImpl<$Res>;
  @override
  $Res call({
    CacheMode cacheMode,
    bool showDebugLogs,
    bool verboseLogging,
    bool loadingDb,
    CheckDbVersion? dbVersion,
    String? error,
  });
}

class _$_StatusStateCopyWithImpl<$Res> extends _$StatusStateCopyWithImpl<$Res>
    implements _$_StatusStateCopyWith<$Res> {
  _$_StatusStateCopyWithImpl(
      _$_StatusState value, $Res Function(_$_StatusState) then)
      : super(value, (value) => then(value as _$_StatusState));

  @override
  _$_StatusState get _value => super._value as _$_StatusState;

  @override
  $Res call({
    Object? cacheMode = null,
    Object? showDebugLogs = null,
    Object? verboseLogging = null,
    Object? loadingDb = null,
    Object? dbVersion = freezed,
    Object? error = freezed,
  }) {
    return _then(
      _$_StatusState(
        cacheMode:
            cacheMode == null ? _value.cacheMode : cacheMode as CacheMode,
        showDebugLogs: showDebugLogs == null
            ? _value.showDebugLogs
            : showDebugLogs as bool,
        verboseLogging: verboseLogging == null
            ? _value.verboseLogging
            : verboseLogging as bool,
        loadingDb: loadingDb == null ? _value.loadingDb : loadingDb as bool,
        dbVersion: dbVersion == freezed
            ? _value.dbVersion
            : dbVersion as CheckDbVersion?,
        error: error == freezed ? _value.error : error as String?,
      ),
    );
  }
}

const Object? freezed = null;
