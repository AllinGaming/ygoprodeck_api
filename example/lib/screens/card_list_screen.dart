import 'package:flutter/material.dart';
import 'package:ygoprodeck_api/ygoprodeck_api.dart' as ygo;

import 'card_pager_screen.dart';

class CardListScreen extends StatelessWidget {
  const CardListScreen({
    super.key,
    required this.title,
    required this.cards,
  });

  final String title;
  final List<ygo.Card> cards;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.separated(
        itemCount: cards.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final card = cards[index];
          return ListTile(
            title: Text(card.name),
            subtitle: Text(card.type),
            trailing: Text('ATK ${card.atk ?? '-'}'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => CardPagerScreen(
                    title: title,
                    cards: cards,
                    initialIndex: index,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
