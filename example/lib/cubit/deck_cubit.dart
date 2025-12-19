import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ygoprodeck_api/ygoprodeck_api.dart';

import '../data/ygo_service.dart';
import 'deck_state.dart';

class DeckCubit extends Cubit<DeckState> {
  DeckCubit(this._service) : super(const DeckState());

  final YgoService _service;

  Future<void> buildRandomDeck({
    int mainCount = 40,
    int extraCount = 15,
    int sideCount = 15,
  }) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      final main = await _service.getCards(
        CardInfoQuery(
          type: _mainDeckTypes,
          sort: 'random',
          num: mainCount,
          offset: 0,
        ),
      );
      final extra = await _service.getCards(
        CardInfoQuery(
          type: _extraDeckTypes,
          sort: 'random',
          num: extraCount,
          offset: 0,
        ),
      );
      final side = await _service.getCards(
        CardInfoQuery(
          sort: 'random',
          num: sideCount,
          offset: 0,
        ),
      );

      emit(
        state.copyWith(
          loading: false,
          mainDeck: main.data,
          extraDeck: extra.data,
          sideDeck: side.data,
        ),
      );
    } on Exception catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }
}

const List<String> _mainDeckTypes = [
  'Effect Monster',
  'Flip Effect Monster',
  'Flip Tuner Effect Monster',
  'Gemini Monster',
  'Normal Monster',
  'Normal Tuner Monster',
  'Pendulum Effect Monster',
  'Pendulum Effect Ritual Monster',
  'Pendulum Flip Effect Monster',
  'Pendulum Normal Monster',
  'Pendulum Tuner Effect Monster',
  'Ritual Effect Monster',
  'Ritual Monster',
  'Spell Card',
  'Spirit Monster',
  'Toon Monster',
  'Trap Card',
  'Tuner Monster',
  'Union Effect Monster',
];

const List<String> _extraDeckTypes = [
  'Fusion Monster',
  'Link Monster',
  'Pendulum Effect Fusion Monster',
  'Synchro Monster',
  'Synchro Pendulum Effect Monster',
  'Synchro Tuner Monster',
  'XYZ Monster',
  'XYZ Pendulum Effect Monster',
];
