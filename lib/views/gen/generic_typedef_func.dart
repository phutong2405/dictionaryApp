import 'package:dictionary_app_1110/data/strings.dart';
import 'package:dictionary_app_1110/models/new_word_model.dart';
import 'package:flutter/material.dart';

Color typeColor(Meaning meaning) {
  if (meaning.tag == 'noun') {
    return Colors.green;
  } else if (meaning.tag == 'adjective') {
    return Colors.blue;
  } else if (meaning.tag == 'verb') {
    return Colors.orange;
  } else if (meaning.tag == 'adverb') {
    return Colors.pink;
  } else {
    return Colors.black;
  }
}

typedef TileTap = void Function(DictionaryEntry entry);

enum InType {
  inHistory,
  inFavorite,
}

enum Size { small, medium, large }

Map<Size, double> textButtonSize = {
  Size.small: 25.0,
  Size.medium: 30.0,
  Size.large: 35.0
};

enum ModalType { history, favorite, settings, translate, home }

Map<ModalType, String> bottomSheetName = {
  ModalType.favorite: stringNavigationFavorite,
  ModalType.history: stringNavigationHistory,
  ModalType.settings: stringNavigationSettings,
  ModalType.translate: stringNavigationTranslate,
  ModalType.home: stringNavigationHome
};

typedef BottomButtonSheet = void Function();

enum Languages {
  english,
  vietnamese,
}

const List<Widget> languages = <Widget>[
  Text('English'),
  Text('Tiếng Việt'),
];

extension AddItemAtFirstToIterable on Iterable<DictionaryEntry> {
  Iterable<DictionaryEntry> addAtFirst({required DictionaryEntry entry}) {
    Iterable<DictionaryEntry> updatedNumbers = [entry, ...this];
    return updatedNumbers;
  }
}

extension AddItemAtIndexIterable on Iterable<DictionaryEntry> {
  Iterable<DictionaryEntry> addAtElement(
      {required DictionaryEntry entry, required int indexToInsert}) {
    List<DictionaryEntry> tmp = toList();
    tmp.remove(entry);
    tmp.insert(indexToInsert, entry);
    Iterable<DictionaryEntry> iterable = tmp.asMap().values.map((e) => e);
    return iterable;
  }
}

extension RemoveItemToIterable on Iterable<DictionaryEntry> {
  Iterable<DictionaryEntry> remove({required DictionaryEntry entry}) {
    Iterable<DictionaryEntry> updatedIterable =
        where((element) => element != entry);

    return updatedIterable;
  }
}
