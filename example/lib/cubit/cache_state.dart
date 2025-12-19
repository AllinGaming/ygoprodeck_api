import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ygoprodeck_api/ygoprodeck_api.dart';

part 'cache_state.freezed.dart';

@freezed
class CacheState with _$CacheState {
  const factory CacheState({
    @Default(false) bool loading,
    @Default(<CacheEntryInfo>[]) List<CacheEntryInfo> entries,
    String? error,
  }) = _CacheState;
}
