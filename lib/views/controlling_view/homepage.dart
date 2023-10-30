import 'package:dictionary_app_1110/models/new_word_model.dart';
import 'package:dictionary_app_1110/views/gen/generic_typedef_func.dart';
import 'package:dictionary_app_1110/views/entry_tile/word_tile.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatelessWidget {
  final Iterable<DictionaryEntry> data;
  final TileTap func;
  const HomePage({super.key, required this.data, required this.func});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: data.toListView(func),
    );
  }
}
