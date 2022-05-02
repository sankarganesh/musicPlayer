import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:san_music_player/Constants/IntegerConstants.dart';
import 'package:san_music_player/data/musicCatalog.dart';

class SongDetailModel extends ChangeNotifier {
  final List<MusicDataModel> _items = [];

  UnmodifiableListView<MusicDataModel> get items =>
      UnmodifiableListView(_items);

  SongDetailModel() {
    _fetchMusicCatalog();
  }

  Future<void> _fetchMusicCatalog() async {
    const catalogUrl = 'https://storage.googleapis.com/uamp/catalog.json';

    final dio = Dio();

    // Adding an interceptor to enable caching.
    dio.interceptors.add(
      DioCacheManager(
        CacheConfig(baseUrl: catalogUrl),
      ).interceptor,
    );

    final response = await dio.get(
      catalogUrl,
      options: buildCacheOptions(
        Duration(days: 7),
        options: (Options(contentType: 'application/json')),
      ),
    );

    if (response.statusCode == IntegerConstants.responseCode) {
      final data = response.data['music'] as List<dynamic>;
      final List<MusicDataModel> result =
          data.map((model) => MusicDataModel.fromJson(model)).toList();
      addAll(result);
    } else {
      throw Exception('Failed to load music catalog');
    }
  }

  void add(MusicDataModel item) {
    _items.add(item);

    notifyListeners();
  }

  void addAll(List<MusicDataModel> items) {
    _items.addAll(items);

    notifyListeners();
  }

  void removeAll() {
    _items.clear();

    notifyListeners();
  }
}
