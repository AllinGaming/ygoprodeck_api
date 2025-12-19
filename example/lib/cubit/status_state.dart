import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ygoprodeck_api/ygoprodeck_api.dart';

part 'status_state.freezed.dart';

@freezed
class StatusState with _$StatusState {
  const factory StatusState({
    required CacheMode cacheMode,
    required bool showDebugLogs,
    required bool verboseLogging,
    @Default(false) bool loadingDb,
    CheckDbVersion? dbVersion,
    String? error,
  }) = _StatusState;
}
