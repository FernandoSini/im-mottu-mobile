import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:marvel/app/data/models/model.dart';
import 'package:crypto/crypto.dart';

class MarvelServices {
  final String _privateKey = "9792c82cc0ad7aa7c060bef0d0f3831491206986";
  final String _apiKey = "a82bb24eb10c4d48cbcdb1c721e9704e";
  final _timestamp = DateTime.now().millisecond.toString();

  Future<List<Character>> fetchCharacters() async {
    final String _hash = md5.convert(utf8.encode(text)).toString() _timestamp + _privateKey + _apiKey;
    
    List<Character>? marvelHeroes = [];
    final url = String.fromEnvironment(
        "https://gateway.marvel.com:443/v1/public/characters?ts=${_timestamp}&apikey=${_apiKey}&hash=${_hash}",
        defaultValue:
            "https://gateway.marvel.com:443/v1/public/characters?ts=${_timestamp}&apikey=${_apiKey}&hash=${_hash}");

    final response = await http.get(Uri.parse(url));
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      var responseDecoded = jsonDecode(response.body);
      final data = ResponseModel.fromJson(responseDecoded);
      marvelHeroes = data.data?.results;
      if (marvelHeroes!.isEmpty || marvelHeroes == null) {
        return [];
      } else {
        return marvelHeroes;
      }
    } else {
      var responseDecoded = jsonDecode(response.body);
      return Future.error(responseDecoded["message"]);
    }
  }
}
