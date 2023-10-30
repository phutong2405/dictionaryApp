import 'dart:convert';
import 'package:dictionary_app_1110/models/new_word_model.dart';
import 'package:http/http.dart' as http;

Future<Iterable<DictionaryEntry>> fetchWord(String url) async {
  try {
    final response = await http.get(Uri.parse(url));
    List<dynamic> data = jsonDecode(response.body)['dictionary'];
    return data.map<DictionaryEntry>((e) => DictionaryEntry.fromJson(e));
  } catch (e) {
    return [];
  }
}
