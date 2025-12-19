import 'card.dart';
import 'meta_info.dart';

/// Response wrapper for card info requests.
class CardInfoResponse {
  CardInfoResponse({
    required this.data,
    this.meta,
  });

  /// Returned card list.
  final List<Card> data;

  /// Pagination metadata (if provided).
  final MetaInfo? meta;

  factory CardInfoResponse.fromJson(Map<String, dynamic> json) {
    return CardInfoResponse(
      data: (json['data'] as List<dynamic>)
          .map((item) => Card.fromJson(item as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] == null
          ? null
          : MetaInfo.fromJson(json['meta'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((item) => item.toJson()).toList(),
      if (meta != null) 'meta': meta!.toJson(),
    };
  }
}
