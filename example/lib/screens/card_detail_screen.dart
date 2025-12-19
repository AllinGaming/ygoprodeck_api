import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ygoprodeck_api/ygoprodeck_api.dart' as ygo;

class CardDetailScreen extends StatelessWidget {
  const CardDetailScreen({
    super.key,
    required this.card,
    this.showAppBar = true,
  });

  final ygo.Card card;
  final bool showAppBar;

  @override
  Widget build(BuildContext context) {
    final image =
        card.cardImages?.isNotEmpty == true ? card.cardImages!.first : null;
    final imageUrl = image?.imageUrlSmall ?? image?.imageUrl;
    final body = ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (imageUrl != null && !kIsWeb)
          LayoutBuilder(
            builder: (context, constraints) {
              final maxWidth = constraints.maxWidth;
              final width = maxWidth < 420 ? maxWidth : 240.0;
              return Center(
                child: SizedBox(
                  width: width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: image?.imageUrl ?? imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, _) => const AspectRatio(
                        aspectRatio: 0.7,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, _, __) => const AspectRatio(
                        aspectRatio: 0.7,
                        child: Center(child: Icon(Icons.broken_image)),
                      ),
                    ),
                  ),
                ),
              );
            },
          )
        else if (imageUrl != null && kIsWeb)
          const Text(
            'Image loading is disabled on web due to CORS.',
          )
        else
          const Text('No image available.'),
        const SizedBox(height: 16),
        Text(
          card.name,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 8,
          runSpacing: 6,
          children: [
            Chip(label: Text(card.type)),
            if (card.race != null) Chip(label: Text(card.race!)),
            if (card.attribute != null) Chip(label: Text(card.attribute!)),
            if (card.level != null) Chip(label: Text('Level ${card.level}')),
            if (card.archetype != null) Chip(label: Text(card.archetype!)),
          ],
        ),
        const SizedBox(height: 12),
        Text(card.desc),
        const SizedBox(height: 16),
        _sectionCard(child: _statsSection()),
        if (card.banlistInfo != null) ...[
          const SizedBox(height: 12),
          _sectionCard(child: _banlistSection()),
        ],
        if (card.cardPrices != null && card.cardPrices!.isNotEmpty) ...[
          const SizedBox(height: 12),
          _sectionCard(child: _pricesSection()),
        ],
        if (card.cardSets != null && card.cardSets!.isNotEmpty) ...[
          const SizedBox(height: 12),
          _sectionCard(child: _setsSection()),
        ],
        if (card.miscInfo != null && card.miscInfo!.isNotEmpty) ...[
          const SizedBox(height: 12),
          _sectionCard(child: _miscSection()),
        ],
        const SizedBox(height: 16),
        const Text(
          'Do not hotlink images. Download and host them yourself to avoid IP blocks.',
        ),
      ],
    );

    if (!showAppBar) {
      return body;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(card.name),
      ),
      body: body,
    );
  }

  Widget _statsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Stats',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 12,
          runSpacing: 6,
          children: [
            _chip('ATK', card.atk?.toString() ?? '-'),
            _chip('DEF', card.def?.toString() ?? '-'),
            _chip('Level', card.level?.toString() ?? '-'),
            _chip('Race', card.race ?? '-'),
            _chip('Attribute', card.attribute ?? '-'),
            if (card.scale != null) _chip('Scale', '${card.scale}'),
            if (card.linkval != null) _chip('Link', '${card.linkval}'),
          ],
        ),
      ],
    );
  }

  Widget _banlistSection() {
    final ban = card.banlistInfo!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Banlist',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Text('TCG: ${ban.banTcg ?? '-'}'),
        Text('OCG: ${ban.banOcg ?? '-'}'),
        Text('GOAT: ${ban.banGoat ?? '-'}'),
      ],
    );
  }

  Widget _pricesSection() {
    final prices = card.cardPrices!.first;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Prices',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 8,
          runSpacing: 6,
          children: [
            _chip('TCGPlayer', '\$${prices.tcgplayerPrice}'),
            _chip('Cardmarket', '€${prices.cardmarketPrice}'),
            _chip('eBay', '\$${prices.ebayPrice}'),
            _chip('Amazon', '\$${prices.amazonPrice}'),
            _chip('CoolStuffInc', '\$${prices.coolstuffincPrice}'),
          ],
        ),
      ],
    );
  }

  Widget _setsSection() {
    final sets = card.cardSets!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sets (first 5)',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        ...sets.take(5).map(
              (set) => Text(
                '${set.setName} • ${set.setCode} • ${set.setRarity}',
              ),
            ),
      ],
    );
  }

  Widget _miscSection() {
    final misc = card.miscInfo!.first;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Misc',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        if (misc.tcgDate != null) Text('TCG date: ${misc.tcgDate}'),
        if (misc.ocgDate != null) Text('OCG date: ${misc.ocgDate}'),
        if (misc.konamiId != null) Text('Konami ID: ${misc.konamiId}'),
        if (misc.mdRarity != null) Text('Master Duel rarity: ${misc.mdRarity}'),
        if (misc.hasEffect != null)
          Text('Has effect: ${misc.hasEffect == 1 ? 'Yes' : 'No'}'),
      ],
    );
  }

  Widget _chip(String label, String value) {
    return Chip(label: Text('$label: $value'));
  }

  Widget _sectionCard({required Widget child}) {
    return Card(
      elevation: 0,
      color: Colors.grey.shade100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: child,
      ),
    );
  }
}
