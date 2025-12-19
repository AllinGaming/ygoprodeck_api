import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ygoprodeck_api/ygoprodeck_api.dart';

import '../data/ygo_service.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this._service)
      : super(const SearchState(loading: false, offset: 0, pageSize: 20));

  final YgoService _service;

  Future<void> search(CardInfoQuery query, {bool resetOffset = false}) async {
    final nextOffset = resetOffset ? 0 : state.offset;
    emit(state.copyWith(loading: true, offset: nextOffset, error: null));
    try {
      final response = await _service.getCards(
        query.copyWith(num: state.pageSize, offset: nextOffset),
      );
      emit(state.copyWith(loading: false, response: response));
    } on Exception catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  Future<void> nextPage(CardInfoQuery query) async {
    final meta = state.response?.meta;
    if (meta?.nextPageOffset == null) {
      return;
    }
    emit(state.copyWith(offset: meta!.nextPageOffset!));
    await search(query);
  }

  Future<void> prevPage(CardInfoQuery query) async {
    final prev = state.offset - state.pageSize;
    if (prev < 0) {
      return;
    }
    emit(state.copyWith(offset: prev));
    await search(query);
  }

  void updatePageSize(int value) {
    emit(state.copyWith(pageSize: value));
  }
}

extension on CardInfoQuery {
  CardInfoQuery copyWith({int? num, int? offset}) {
    return CardInfoQuery(
      name: name,
      fuzzyName: fuzzyName,
      id: id,
      konamiId: konamiId,
      type: type,
      atk: atk,
      def: def,
      level: level,
      race: race,
      attribute: attribute,
      link: link,
      linkMarker: linkMarker,
      scale: scale,
      cardSet: cardSet,
      archetype: archetype,
      banlist: banlist,
      sort: sort,
      format: format,
      misc: misc,
      staple: staple,
      hasEffect: hasEffect,
      startDate: startDate,
      endDate: endDate,
      dateRegion: dateRegion,
      language: language,
      num: num ?? this.num,
      offset: offset ?? this.offset,
      tcgplayerData: tcgplayerData,
    );
  }
}
