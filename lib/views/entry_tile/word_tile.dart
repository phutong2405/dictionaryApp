import 'package:dictionary_app_1110/models/new_word_model.dart';
import 'package:dictionary_app_1110/views/gen/generic_typedef_func.dart';
import 'package:dictionary_app_1110/views/gen/generic_widgets.dart';
import 'package:flutter/material.dart';

Widget wordTile(DictionaryEntry entry, TileTap func) {
  return Container(
    padding: const EdgeInsets.only(bottom: 0),
    child: Column(
      children: [
        ListTile(
          splashColor: Colors.blue,
          onTap: () {
            func(entry);
          },
          title: Row(
            children: [
              Text(
                entry.word,
                style: const TextStyle(fontSize: 17),
              ),
              Text(
                ' - ${entry.pronunciation.ipa} ',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              ),
              inHisNFavCheck(entry.inHistory, InType.inHistory),
              inHisNFavCheck(entry.inFavorite, InType.inFavorite),
            ],
          ),
          subtitle: Text(
            entry.meanings.first.values.first,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ), //entry.meaning),
          trailing: Container(
            width: entry.meanings.length >= 2 ? 73 : 30,
            alignment: Alignment.centerRight,
            child: shortEntryType(
                meanings: entry.meanings,
                textSize: entry.meanings.length > 2 ? 16 : 18,
                fontWeight: FontWeight.w500),
          ),
        ),
        divineLine(
            colors: [Colors.transparent, Colors.grey.shade100],
            space: 0,
            start: Alignment.centerLeft)
      ],
    ),
  );
}

extension ListDictionary on Iterable<DictionaryEntry> {
  toListView(TileTap func) {
    return ListView.builder(
      itemCount: length,
      itemBuilder: (context, index) {
        return wordTile(elementAt(index), func);
      },
    );
  }
}

Widget inHisNFavCheck(bool inCheck, InType type) {
  final bool historyFlag = type == InType.inHistory ? true : false;
  return inCheck
      ? Text(
          historyFlag ? ' ✓' : ' ♥',
          style: TextStyle(
              color: historyFlag ? Colors.green : Colors.pink,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        )
      : const Text('');
}

Widget shortEntryType(
    {required List<Meaning> meanings,
    double? textSize,
    FontWeight? fontWeight}) {
  List<TextSpan> shortEntryType = [];
  for (var element in meanings) {
    switch (element.tag) {
      case 'noun':
        shortEntryType.add(
          TextSpan(
            text: ' n ',
            style: TextStyle(
                fontSize: textSize ?? 16,
                color: Colors.green,
                fontWeight: fontWeight ?? FontWeight.w400),
          ),
        );
      case 'verb':
        shortEntryType.add(
          TextSpan(
            text: ' v ',
            style: TextStyle(
                fontSize: textSize ?? 16,
                color: Colors.amber,
                fontWeight: fontWeight ?? FontWeight.w400),
          ),
        );
      case 'adjective':
        shortEntryType.add(
          TextSpan(
            text: ' adj ',
            style: TextStyle(
                fontSize: textSize ?? 16,
                color: Colors.blue,
                fontWeight: fontWeight ?? FontWeight.w400),
          ),
        );
      case 'adverb':
        shortEntryType.add(
          TextSpan(
            text: ' adv ',
            style: TextStyle(
                fontSize: textSize ?? 16,
                color: Colors.pink,
                fontWeight: fontWeight ?? FontWeight.w400),
          ),
        );
      default:
        shortEntryType.add(
          TextSpan(
            text: element.tag,
            style: TextStyle(
                fontSize: textSize ?? 16,
                color: Colors.black,
                fontWeight: fontWeight ?? FontWeight.w400),
          ),
        );
    }
  }
  return RichText(
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    text: TextSpan(
      children: shortEntryType,
    ),
  );
}
