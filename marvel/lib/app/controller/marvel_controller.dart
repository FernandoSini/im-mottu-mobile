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

    _repository.saveData("marvel_heroes", jsonEncode(data));
    return data;
  }

  Future<List<Character>> fetchDataFromCache() async {
    final data = await _repository.readCacheData("marvel_heroes");
    return data ?? [];
  }

  void deleteData() async {
    await _repository.deleteData("marvel_heroes");
  }

  List<List<Character>> search(List<Character> data, String value) {
    var characters = data
        .where((element) =>
            element.name!.toLowerCase().contains(value) ||
            element.comics!.items!.any(
                (element) => element.name!.toLowerCase().contains(value)) ||
            element.description!.toLowerCase().contains(value))
        .toList();

    return groupCharacters(characters);
  }

  List<List<Character>> groupCharacters(List<Character> characters) {
    var newList = [];

    List<List<Character>> characterList = <List<Character>>[];
    for (var character in characters) {
      if (!newList.contains(character.id)) {
        newList.add(character);

        characterList.add(characters
            .where((element) =>
                element.id == character.id ||
                element.name == character.name ||
                element.description == character.description ||
                element.comics!.items!.any(
                    (element) => character.comics!.items!.contains(element)))
            .toList()
            .obs
          ..sort(
            (a, b) => a.name!.compareTo(b.name!),
          ));
      }
    }

    return characterList
        .where((element) => element.isNotEmpty && element != null)
        .toList()
        .obs;
  }
}
