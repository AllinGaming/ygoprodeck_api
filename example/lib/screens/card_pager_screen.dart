import 'package:flutter/material.dart';
import 'package:ygoprodeck_api/ygoprodeck_api.dart' as ygo;

import 'card_detail_screen.dart';

class CardPagerScreen extends StatefulWidget {
  const CardPagerScreen({
    super.key,
    required this.title,
    required this.cards,
    this.initialIndex = 0,
  });

  final String title;
  final List<ygo.Card> cards;
  final int initialIndex;

  @override
  State<CardPagerScreen> createState() => _CardPagerScreenState();
}

class _CardPagerScreenState extends State<CardPagerScreen> {
  late final PageController _controller;
  late int _index;

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex.clamp(0, widget.cards.length - 1);
    _controller = PageController(initialPage: _index);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.title} (${_index + 1}/${widget.cards.length})'),
      ),
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: widget.cards.length,
            onPageChanged: (value) => setState(() => _index = value),
            itemBuilder: (context, index) {
              return CardDetailScreen(
                card: widget.cards[index],
                showAppBar: false,
              );
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 12,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.swipe, color: Colors.white, size: 16),
                    SizedBox(width: 6),
                    Text(
                      'Swipe left/right',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
