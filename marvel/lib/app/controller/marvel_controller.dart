import 'dart:convert';

import 'package:get/get.dart';
import 'package:marvel/app/data/models/model.dart';
import 'package:marvel/app/data/repository/marvel_repository.dart';
import 'package:marvel/app/services/marvel_services.dart';

class MarvelController extends GetxController {
  MarvelController();
  final _services = MarvelServices();
  final _repository = MarvelRepository();

  Future<List<Character>> fetchDataFromApi() async {
    final data = await _services.fetchCharacters();
    if (data.isEmpty || data == null) {
      return [];
    }
    if (data is String) {
      return [];
    }
    _repository.saveData("marvel_heroes", jsonEncode(data));
    return data;
  }

  Future<List<Character>> fetchDataFromCache() async {
    await _repository.readCacheData("marvel_heroes");
    return [];
  }

  void deleteData() async {
    await _repository.deleteData("marvel_heroes");
  }
}
