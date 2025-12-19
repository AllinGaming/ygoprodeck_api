import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ygoprodeck_api/ygoprodeck_api.dart';

part 'search_state.freezed.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState({
    @Default(false) bool loading,
    @Default(0) int offset,
    @Default(20) int pageSize,
    CardInfoResponse? response,
    String? error,
  }) = _SearchState;
}
