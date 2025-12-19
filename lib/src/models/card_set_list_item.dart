class CardSetListItem {
  CardSetListItem({
    required this.setName,
    required this.setCode,
    required this.numOfCards,
    required this.tcgDate,
  });

  final String setName;
  final String setCode;
  final int numOfCards;
  final String? tcgDate;

  factory CardSetListItem.fromJson(Map<String, dynamic> json) {
    return CardSetListItem(
      setName: json['set_name'] as String,
      setCode: json['set_code'] as String,
      numOfCards: json['num_of_cards'] as int,
      tcgDate: json['tcg_date'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'set_name': setName,
      'set_code': setCode,
      'num_of_cards': numOfCards,
      if (tcgDate != null) 'tcg_date': tcgDate,
    };
  }
}
