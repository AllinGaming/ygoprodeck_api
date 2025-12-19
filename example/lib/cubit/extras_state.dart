import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ygoprodeck_api/ygoprodeck_api.dart';

part 'extras_state.freezed.dart';

@freezed
class ExtrasState with _$ExtrasState {
  const factory ExtrasState({
    @Default(false) bool loadingRandom,
    @Default(false) bool loadingArchetypes,
    @Default(false) bool loadingSets,
    Card? randomCard,
    List<CardArchetype>? archetypes,
    List<CardSetListItem>? sets,
    String? randomError,
    String? archetypesError,
    String? setsError,
  }) = _ExtrasState;
}
