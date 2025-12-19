import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/ygo_service.dart';
import 'extras_state.dart';

class ExtrasCubit extends Cubit<ExtrasState> {
  ExtrasCubit(this._service) : super(const ExtrasState());

  final YgoService _service;

  Future<void> loadRandomCard() async {
    emit(state.copyWith(loadingRandom: true, randomError: null));
    try {
      final card = await _service.getRandomCard();
      emit(state.copyWith(loadingRandom: false, randomCard: card));
    } on Exception catch (e) {
      emit(state.copyWith(loadingRandom: false, randomError: e.toString()));
    }
  }

  Future<void> loadArchetypes() async {
    emit(state.copyWith(loadingArchetypes: true, archetypesError: null));
    try {
      final data = await _service.getArchetypes();
      emit(state.copyWith(loadingArchetypes: false, archetypes: data));
    } on Exception catch (e) {
      emit(
        state.copyWith(loadingArchetypes: false, archetypesError: e.toString()),
      );
    }
  }

  Future<void> loadSets() async {
    emit(state.copyWith(loadingSets: true, setsError: null));
    try {
      final data = await _service.getCardSets();
      emit(state.copyWith(loadingSets: false, sets: data));
    } on Exception catch (e) {
      emit(state.copyWith(loadingSets: false, setsError: e.toString()));
    }
  }
}
