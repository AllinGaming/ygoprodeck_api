import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ygoprodeck_api/ygoprodeck_api.dart';

part 'deck_state.freezed.dart';

@freezed
class DeckState with _$DeckState {
  const factory DeckState({
    @Default(false) bool loading,
    List<Card>? mainDeck,
    List<Card>? extraDeck,
    List<Card>? sideDeck,
    String? error,
  }) = _DeckState;
}
