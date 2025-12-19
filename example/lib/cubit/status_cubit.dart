import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ygoprodeck_api/ygoprodeck_api.dart';

import '../data/ygo_service.dart';
import 'status_state.dart';

class StatusCubit extends Cubit<StatusState> {
  StatusCubit(this._service)
      : super(
          StatusState(
            cacheMode: _service.cacheMode,
            showDebugLogs: _service.showDebugLogs,
            verboseLogging: _service.verboseLogging,
          ),
        );

  final YgoService _service;

  void updateCacheMode(CacheMode mode) {
    _service.updateSettings(cacheMode: mode);
    emit(state.copyWith(cacheMode: mode));
  }

  void updateDebugLogs(bool value) {
    _service.updateSettings(showDebugLogs: value);
    emit(state.copyWith(showDebugLogs: value));
  }

  void updateVerboseLogging(bool value) {
    _service.updateSettings(verboseLogging: value);
    emit(state.copyWith(verboseLogging: value));
  }

  Future<void> loadDbVersion() async {
    emit(state.copyWith(loadingDb: true, error: null));
    try {
      final version = await _service.checkDbVersion();
      emit(state.copyWith(loadingDb: false, dbVersion: version));
    } on Exception catch (e) {
      emit(state.copyWith(loadingDb: false, error: e.toString()));
    }
  }
}
