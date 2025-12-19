import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/ygo_service.dart';
import 'cache_state.dart';

class CacheCubit extends Cubit<CacheState> {
  CacheCubit(this._service) : super(const CacheState());

  final YgoService _service;

  Future<void> loadEntries() async {
    emit(state.copyWith(loading: true, error: null));
    try {
      final entries = await _service.listCacheEntries();
      emit(state.copyWith(loading: false, entries: entries));
    } on Exception catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }
}
