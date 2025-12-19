import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ygoprodeck_api/ygoprodeck_api.dart';

import 'data/ygo_service.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  if (getIt.isRegistered<YgoService>()) {
    return;
  }
  final cacheStore = await _buildCacheStore();
  getIt.registerSingleton<YgoService>(
    YgoService(cacheStore: cacheStore),
  );
}

Future<CacheStore?> _buildCacheStore() async {
  if (kIsWeb) {
    return WebStorageCacheStore(prefix: 'ygoprodeck_example');
  }
  final dir = await getApplicationDocumentsDirectory();
  return FileCacheStore(basePath: '${dir.path}/ygoprodeck_cache');
}
