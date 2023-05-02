import 'dart:convert';

import 'package:marvel/app/data/models/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MarvelRepository {
  Future<void> saveData(String key, String encoded) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, encoded);
  }

  Future<List<Character>?> readCacheData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getString(key);
    if (data != null) {
      var decodedData = jsonDecode(data);
      List<Character> characters =
          decodedData.map<Character>((e) => Character.fromJson(e)).toList();
      return characters;
    } else {
      return null;
    }
  }

  Future<void> deleteData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
