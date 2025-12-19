import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ygoprodeck_api/ygoprodeck_api.dart' hide Card;
import 'package:ygoprodeck_api/ygoprodeck_api.dart' as ygo;

import 'cubit/cache_cubit.dart';
import 'cubit/cache_state.dart';
import 'cubit/deck_cubit.dart';
import 'cubit/deck_state.dart';
import 'cubit/extras_cubit.dart';
import 'cubit/extras_state.dart';
import 'cubit/search_cubit.dart';
import 'cubit/search_state.dart';
import 'cubit/status_cubit.dart';
import 'cubit/status_state.dart';
import 'data/ygo_service.dart';
import 'di.dart';
import 'screens/card_detail_screen.dart';
import 'screens/card_list_screen.dart';

class YgoExampleApp extends StatelessWidget {
  const YgoExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchCubit>(
          create: (_) => SearchCubit(getIt<YgoService>()),
        ),
        BlocProvider<ExtrasCubit>(
          create: (_) => ExtrasCubit(getIt<YgoService>()),
        ),
        BlocProvider<DeckCubit>(
          create: (_) => DeckCubit(getIt<YgoService>()),
        ),
        BlocProvider<StatusCubit>(
          create: (_) => StatusCubit(getIt<YgoService>()),
        ),
        BlocProvider<CacheCubit>(
          create: (_) => CacheCubit(getIt<YgoService>()),
        ),
      ],
      child: MaterialApp(
        title: 'YGOPRODeck Example',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
          useMaterial3: true,
        ),
        home: const _HomePage(),
      ),
    );
  }
}

class _HomePage extends StatefulWidget {
  const _HomePage();

  @override
  State<_HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage> {
  final TextEditingController _nameController =
      TextEditingController(text: 'Tornado Dragon');
  final TextEditingController _archetypeController = TextEditingController();
  final TextEditingController _cardSetController = TextEditingController();
  final TextEditingController _levelController = TextEditingController();
  final TextEditingController _pageSizeController =
      TextEditingController(text: '20');

  String? _attribute;
  String? _type;
  String? _format;
  String? _sort;
  String? _banlist;
  String? _language;
  StatComparator _levelComparator = StatComparator.eq;
  bool _misc = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _triggerSearch(resetOffset: true);
      context.read<CacheCubit>().loadEntries();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _archetypeController.dispose();
    _cardSetController.dispose();
    _levelController.dispose();
    _pageSizeController.dispose();
    super.dispose();
  }

  int _pageSize() {
    final raw = int.tryParse(_pageSizeController.text.trim());
    if (raw == null || raw <= 0) {
      return 20;
    }
    return raw;
  }

  CardInfoQuery _buildQuery({required int offset}) {
    final name = _nameController.text.trim();
    final archetype = _archetypeController.text.trim();
    final cardSet = _cardSetController.text.trim();
    final levelRaw = _levelController.text.trim();
    final levelValue = int.tryParse(levelRaw);

    return CardInfoQuery(
      name: name.isEmpty ? null : [name],
      archetype: archetype.isEmpty ? null : archetype,
      cardSet: cardSet.isEmpty ? null : cardSet,
      attribute: _attribute == null ? null : [_attribute!],
      type: _type == null ? null : [_type!],
      format: _format,
      sort: _sort,
      banlist: _banlist,
      language: _language,
      level: levelValue == null
          ? null
          : StatFilter(value: levelValue, comparator: _levelComparator),
      misc: _misc,
      num: _pageSize(),
      offset: offset,
    );
  }

  void _triggerSearch({required bool resetOffset}) {
    final cubit = context.read<SearchCubit>();
    if (resetOffset) {
      cubit.updatePageSize(_pageSize());
    }
    final offset = resetOffset ? 0 : cubit.state.offset;
    final query = _buildQuery(offset: offset);
    cubit.search(query, resetOffset: resetOffset);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('YGOPRODeck API Example'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Search'),
              Tab(text: 'Extras'),
              Tab(text: 'Status'),
              Tab(text: 'Cache'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildSearchTab(),
            _buildExtrasTab(),
            _buildStatusTab(),
            _buildCacheTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchTab() {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Card name',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (_) => _triggerSearch(resetOffset: true),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: state.loading
                          ? null
                          : () => _triggerSearch(resetOffset: true),
                      child: const Text('Search'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: state.loading
                          ? null
                          : () {
                              _nameController.clear();
                              _archetypeController.clear();
                              _cardSetController.clear();
                              _levelController.clear();
                              _attribute = null;
                              _type = null;
                              _format = null;
                              _sort = null;
                              _banlist = null;
                              _language = null;
                              _levelComparator = StatComparator.eq;
                              _misc = true;
                              setState(() {});
                              _triggerSearch(resetOffset: true);
                            },
                      child: const Text('Reset'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ExpansionTile(
                title: const Text('Filters'),
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isNarrow = constraints.maxWidth < 520;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          children: [
                            _buildFilterField(
                              controller: _archetypeController,
                              label: 'Archetype',
                            ),
                            _buildFilterField(
                              controller: _cardSetController,
                              label: 'Card set (exact name)',
                            ),
                            const SizedBox(height: 8),
                            if (isNarrow) ...[
                              _singleDropdown(
                                value: _attribute,
                                label: 'Attribute',
                                items: _attributes,
                                onChanged: (value) =>
                                    setState(() => _attribute = value),
                              ),
                              const SizedBox(height: 8),
                              _singleDropdown(
                                value: _type,
                                label: 'Type',
                                items: _types,
                                onChanged: (value) =>
                                    setState(() => _type = value),
                              ),
                              const SizedBox(height: 8),
                              _singleDropdown(
                                value: _format,
                                label: 'Format',
                                items: _formats,
                                onChanged: (value) =>
                                    setState(() => _format = value),
                              ),
                              const SizedBox(height: 8),
                              _singleDropdown(
                                value: _sort,
                                label: 'Sort',
                                items: _sorts,
                                onChanged: (value) =>
                                    setState(() => _sort = value),
                              ),
                              const SizedBox(height: 8),
                              _singleDropdown(
                                value: _banlist,
                                label: 'Banlist',
                                items: _banlists,
                                onChanged: (value) =>
                                    setState(() => _banlist = value),
                              ),
                              const SizedBox(height: 8),
                              _singleDropdown(
                                value: _language,
                                label: 'Language',
                                items: _languages,
                                onChanged: (value) =>
                                    setState(() => _language = value),
                              ),
                              const SizedBox(height: 8),
                              _singleDropdownComparator(),
                              const SizedBox(height: 8),
                              _levelField(),
                              const SizedBox(height: 8),
                              _pageSizeField(),
                              SwitchListTile(
                                value: _misc,
                                title: const Text('Include misc info'),
                                onChanged: (value) {
                                  setState(() => _misc = value);
                                  _triggerSearch(resetOffset: true);
                                },
                              ),
                            ] else ...[
                              Row(
                                children: [
                                  Expanded(
                                    child: _singleDropdown(
                                      value: _attribute,
                                      label: 'Attribute',
                                      items: _attributes,
                                      onChanged: (value) =>
                                          setState(() => _attribute = value),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: _singleDropdown(
                                      value: _type,
                                      label: 'Type',
                                      items: _types,
                                      onChanged: (value) =>
                                          setState(() => _type = value),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: _singleDropdown(
                                      value: _format,
                                      label: 'Format',
                                      items: _formats,
                                      onChanged: (value) =>
                                          setState(() => _format = value),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: _singleDropdown(
                                      value: _sort,
                                      label: 'Sort',
                                      items: _sorts,
                                      onChanged: (value) =>
                                          setState(() => _sort = value),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: _singleDropdown(
                                      value: _banlist,
                                      label: 'Banlist',
                                      items: _banlists,
                                      onChanged: (value) =>
                                          setState(() => _banlist = value),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: _singleDropdown(
                                      value: _language,
                                      label: 'Language',
                                      items: _languages,
                                      onChanged: (value) =>
                                          setState(() => _language = value),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(child: _singleDropdownComparator()),
                                  const SizedBox(width: 12),
                                  Expanded(child: _levelField()),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(child: _pageSizeField()),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: SwitchListTile(
                                      value: _misc,
                                      title: const Text('Include misc info'),
                                      onChanged: (value) {
                                        setState(() => _misc = value);
                                        _triggerSearch(resetOffset: true);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (state.error != null)
                Text(
                  state.error!,
                  style: const TextStyle(color: Colors.red),
                ),
              if (state.loading) const LinearProgressIndicator(minHeight: 2),
              const SizedBox(height: 8),
              _buildPaginationRow(state),
              const SizedBox(height: 8),
              Expanded(
                child: _buildResultsList(state),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPaginationRow(SearchState state) {
    final meta = state.response?.meta;
    return Row(
      children: [
        OutlinedButton(
          onPressed: state.loading
              ? null
              : () => context
                  .read<SearchCubit>()
                  .prevPage(_buildQuery(offset: state.offset)),
          child: const Text('Prev'),
        ),
        const SizedBox(width: 12),
        OutlinedButton(
          onPressed: state.loading || meta?.nextPageOffset == null
              ? null
              : () => context
                  .read<SearchCubit>()
                  .nextPage(_buildQuery(offset: state.offset)),
          child: const Text('Next'),
        ),
        const SizedBox(width: 12),
        if (meta != null) Text('Rows: ${meta.currentRows}/${meta.totalRows}'),
      ],
    );
  }

  Widget _buildResultsList(SearchState state) {
    final cards = state.response?.data ?? [];
    if (cards.isEmpty && !state.loading) {
      return const Center(child: Text('No results.'));
    }
    return ListView.separated(
      itemCount: cards.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        final card = cards[index];
        final thumbUrl = card.cardImages?.isNotEmpty == true
            ? card.cardImages!.first.imageUrlSmall
            : null;
        return ListTile(
          leading: thumbUrl == null || kIsWeb
              ? const Icon(Icons.image_not_supported)
              : ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    thumbUrl,
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.broken_image),
                  ),
                ),
          title: Text(card.name),
          subtitle: Text('${card.type} • ${card.race ?? 'Unknown race'}'),
          trailing: Text('ATK ${card.atk ?? '-'}'),
          onTap: () => _openCardDetails(card),
        );
      },
    );
  }

  void _openCardDetails(ygo.Card card) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CardDetailScreen(card: card),
      ),
    );
  }

  Widget _buildExtrasTab() {
    return BlocBuilder<ExtrasCubit, ExtrasState>(
      builder: (context, state) {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ListTile(
              title: const Text('Random Card'),
              subtitle: const Text('randomcard.php (no parameters)'),
              trailing: ElevatedButton(
                onPressed: state.loadingRandom
                    ? null
                    : context.read<ExtrasCubit>().loadRandomCard,
                child: const Text('Fetch'),
              ),
            ),
            if (state.loadingRandom)
              const LinearProgressIndicator(minHeight: 2),
            if (state.randomError != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  state.randomError!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            if (state.randomCard != null)
              Card(
                margin: const EdgeInsets.only(top: 12),
                child: ListTile(
                  title: Text(state.randomCard!.name),
                  subtitle: Text(state.randomCard!.type),
                  onTap: () => _openCardDetails(state.randomCard!),
                ),
              ),
            const SizedBox(height: 16),
            const Text(
              'Random Deck',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            BlocBuilder<DeckCubit, DeckState>(
              builder: (context, deckState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: deckState.loading
                          ? null
                          : context.read<DeckCubit>().buildRandomDeck,
                      child: const Text('Generate 40/15/15 deck'),
                    ),
                    if (deckState.loading)
                      const LinearProgressIndicator(minHeight: 2),
                    if (deckState.error != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          deckState.error!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    if (deckState.mainDeck != null) ...[
                      const SizedBox(height: 8),
                      _deckSection(
                        title: 'Main Deck',
                        cards: deckState.mainDeck!,
                      ),
                    ],
                    if (deckState.extraDeck != null) ...[
                      const SizedBox(height: 8),
                      _deckSection(
                        title: 'Extra Deck',
                        cards: deckState.extraDeck!,
                      ),
                    ],
                    if (deckState.sideDeck != null) ...[
                      const SizedBox(height: 8),
                      _deckSection(
                        title: 'Side Deck',
                        cards: deckState.sideDeck!,
                      ),
                    ],
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Archetypes'),
              subtitle: const Text('archetypes.php (cached for 1 day)'),
              trailing: ElevatedButton(
                onPressed: state.loadingArchetypes
                    ? null
                    : context.read<ExtrasCubit>().loadArchetypes,
                child: const Text('Load'),
              ),
            ),
            if (state.loadingArchetypes)
              const LinearProgressIndicator(minHeight: 2),
            if (state.archetypesError != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  state.archetypesError!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            if (state.archetypes != null)
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: state.archetypes!
                    .take(20)
                    .map((item) => Chip(label: Text(item.archetypeName)))
                    .toList(),
              ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Card Sets'),
              subtitle: const Text('cardsets.php (cached for 1 day)'),
              trailing: ElevatedButton(
                onPressed: state.loadingSets
                    ? null
                    : context.read<ExtrasCubit>().loadSets,
                child: const Text('Load'),
              ),
            ),
            if (state.loadingSets) const LinearProgressIndicator(minHeight: 2),
            if (state.setsError != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  state.setsError!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            if (state.sets != null)
              Column(
                children: state.sets!
                    .take(10)
                    .map(
                      (set) => ListTile(
                        title: Text(set.setName),
                        subtitle: Text('Code: ${set.setCode}'),
                        trailing: Text('${set.numOfCards} cards'),
                      ),
                    )
                    .toList(),
              ),
          ],
        );
      },
    );
  }

  Widget _deckSection({required String title, required List<ygo.Card> cards}) {
    return ExpansionTile(
      title: Text(title),
      subtitle: Text('${cards.length} cards'),
      children: cards
          .map(
            (card) => ListTile(
              title: Text(card.name),
              subtitle: Text(card.type),
              onTap: () => _openCardDetails(card),
            ),
          )
          .toList(),
    );
  }

  Widget _buildStatusTab() {
    return BlocBuilder<StatusCubit, StatusState>(
      builder: (context, state) {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Client settings',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<CacheMode>(
              initialValue: state.cacheMode,
              decoration: const InputDecoration(
                labelText: 'Cache mode',
                border: OutlineInputBorder(),
              ),
              items: CacheMode.values
                  .map(
                    (mode) => DropdownMenuItem(
                      value: mode,
                      child: Text(mode.name),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  context.read<StatusCubit>().updateCacheMode(value);
                }
              },
            ),
            const SizedBox(height: 12),
            SwitchListTile(
              value: state.showDebugLogs,
              title: const Text('Show debug logs'),
              onChanged: (value) =>
                  context.read<StatusCubit>().updateDebugLogs(value),
            ),
            SwitchListTile(
              value: state.verboseLogging,
              title: const Text('Verbose response logging'),
              onChanged: (value) =>
                  context.read<StatusCubit>().updateVerboseLogging(value),
            ),
            const SizedBox(height: 16),
            const Text(
              'Database version',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: state.loadingDb
                  ? null
                  : context.read<StatusCubit>().loadDbVersion,
              child: const Text('Check DB Version'),
            ),
            if (state.loadingDb) const LinearProgressIndicator(minHeight: 2),
            if (state.error != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  state.error!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            if (state.dbVersion != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'Version ${state.dbVersion!.databaseVersion} • ${state.dbVersion!.databaseVersionDate}',
                ),
              ),
            const SizedBox(height: 16),
            const Text(
              'Notes',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Do not hotlink images. Download and host them yourself to avoid IP blocks.',
            ),
          ],
        );
      },
    );
  }

  Widget _buildCacheTab() {
    return BlocBuilder<CacheCubit, CacheState>(
      builder: (context, state) {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: state.loading
                        ? null
                        : context.read<CacheCubit>().loadEntries,
                    child: const Text('Refresh cache list'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (state.loading) const LinearProgressIndicator(minHeight: 2),
            if (state.error != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  state.error!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            if (!state.loading && state.entries.isEmpty)
              const Padding(
                padding: EdgeInsets.only(top: 12),
                child: Text('No cached entries found.'),
              ),
            if (state.entries.isNotEmpty)
              ...state.entries.map(
                (entry) {
                  final parsed = _describeCacheEntry(entry);
                  return ListTile(
                    title: Text(parsed.title),
                    subtitle: Text(parsed.subtitle),
                    trailing: Text('${entry.entry.body.length}B'),
                    onTap: parsed.cards == null
                        ? null
                        : () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => CardListScreen(
                                  title: parsed.title,
                                  cards: parsed.cards!,
                                ),
                              ),
                            );
                          },
                  );
                },
              ),
          ],
        );
      },
    );
  }

  List<DropdownMenuItem<String?>> _dropdownItems(List<String> values) {
    return [
      const DropdownMenuItem<String?>(
        value: null,
        child: Text('Any'),
      ),
      ...values.map(
        (value) => DropdownMenuItem<String?>(value: value, child: Text(value)),
      ),
    ];
  }

  Widget _singleDropdown({
    required String? value,
    required String label,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String?>(
      key: ValueKey(value ?? 'any-$label'),
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      items: _dropdownItems(items),
      onChanged: onChanged,
    );
  }

  Widget _singleDropdownComparator() {
    return DropdownButtonFormField<StatComparator>(
      key: ValueKey(_levelComparator),
      initialValue: _levelComparator,
      decoration: const InputDecoration(
        labelText: 'Level comparator',
        border: OutlineInputBorder(),
      ),
      items: StatComparator.values
          .map(
            (value) => DropdownMenuItem(
              value: value,
              child: Text(value.name),
            ),
          )
          .toList(),
      onChanged: (value) {
        if (value != null) {
          setState(() => _levelComparator = value);
        }
      },
    );
  }

  Widget _levelField() {
    return TextField(
      controller: _levelController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: 'Level',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _pageSizeField() {
    return TextField(
      controller: _pageSizeController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: 'Page size',
        border: OutlineInputBorder(),
      ),
      onSubmitted: (_) => _triggerSearch(resetOffset: true),
    );
  }

  Widget _buildFilterField({
    required TextEditingController controller,
    required String label,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  _CacheEntryView _describeCacheEntry(CacheEntryInfo entry) {
    final key = entry.key;
    String title = 'Cached item';
    String subtitle = 'Expires: ${entry.entry.expiresAt.toLocal()}';
    List<ygo.Card>? cards;

    Uri? uri;
    try {
      uri = Uri.parse(key);
    } catch (_) {
      uri = null;
    }

    if (uri != null && uri.scheme.startsWith('http')) {
      title = uri.pathSegments.isNotEmpty ? uri.pathSegments.last : uri.path;
      if (uri.queryParameters.isNotEmpty) {
        subtitle = _summarizeQuery(uri.queryParameters);
      }
    }

    try {
      final decoded = jsonDecode(entry.entry.body);
      final data = decoded is Map<String, dynamic> ? decoded['data'] : decoded;
      if (data is List && data.isNotEmpty) {
        if (data.first is Map<String, dynamic> &&
            (data.first as Map<String, dynamic>)['name'] is String) {
          cards = data
              .whereType<Map<String, dynamic>>()
              .map((item) => ygo.Card.fromJson(item))
              .toList();
          final names = cards.map((item) => item.name).take(3).toList();
          if (names.isNotEmpty) {
            subtitle = 'Cards: ${names.join(', ')}'
                '${cards.length > names.length ? ' +${cards.length - names.length}' : ''}';
          }
        } else if (data.first is Map<String, dynamic> &&
            (data.first as Map<String, dynamic>)['set_name'] is String) {
          subtitle = 'Card sets: ${data.length}';
        } else if (data.first is Map<String, dynamic> &&
            (data.first as Map<String, dynamic>)['archetype_name'] is String) {
          subtitle = 'Archetypes: ${data.length}';
        }
      } else if (decoded is Map<String, dynamic> &&
          decoded.containsKey('database_version')) {
        subtitle = 'DB version: ${decoded['database_version']}';
      }
    } catch (_) {}

    return _CacheEntryView(title: title, subtitle: subtitle, cards: cards);
  }

  String _summarizeQuery(Map<String, String> query) {
    final parts = <String>[];
    if (query.containsKey('name')) {
      parts.add('name=${query['name']}');
    }
    if (query.containsKey('archetype')) {
      parts.add('archetype=${query['archetype']}');
    }
    if (query.containsKey('cardset')) {
      parts.add('set=${query['cardset']}');
    }
    if (query.containsKey('type')) {
      parts.add('type=${query['type']}');
    }
    if (query.containsKey('format')) {
      parts.add('format=${query['format']}');
    }
    if (parts.isEmpty) {
      parts.add('Cached query');
    }
    return parts.join(' • ');
  }
}

class _CacheEntryView {
  _CacheEntryView({
    required this.title,
    required this.subtitle,
    this.cards,
  });

  final String title;
  final String subtitle;
  final List<ygo.Card>? cards;
}

const List<String> _attributes = [
  'dark',
  'earth',
  'fire',
  'light',
  'water',
  'wind',
  'divine',
];

const List<String> _types = [
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
  'Fusion Monster',
  'Link Monster',
  'Pendulum Effect Fusion Monster',
  'Synchro Monster',
  'Synchro Pendulum Effect Monster',
  'Synchro Tuner Monster',
  'XYZ Monster',
  'XYZ Pendulum Effect Monster',
  'Skill Card',
  'Token',
];

const List<String> _formats = [
  'tcg',
  'goat',
  'ocg goat',
  'speed duel',
  'master duel',
  'rush duel',
  'duel links',
  'genesys',
];

const List<String> _sorts = [
  'atk',
  'def',
  'name',
  'type',
  'level',
  'id',
  'new',
  'random',
];

const List<String> _banlists = ['tcg', 'ocg', 'goat'];

const List<String> _languages = ['fr', 'de', 'it', 'pt'];
