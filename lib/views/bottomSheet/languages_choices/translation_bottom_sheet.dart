import 'package:dictionary_app_1110/bloc/bloc_app/bloc_app.dart';
import 'package:dictionary_app_1110/bloc/bloc_app/bloc_events.dart';
import 'package:dictionary_app_1110/data/dummy_translation_data.dart';
import 'package:flutter/material.dart';

Widget translationTile(
    {required String title,
    required String icon,
    required bool status,
    required bool chosen,
    required Function() func}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
    decoration: chosen
        ? BoxDecoration(
            border: Border.all(width: 2, color: Colors.green),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          )
        : null,
    child: ListTile(
      onTap: () {
        func();
      },
      leading: Text(
        icon,
        style: const TextStyle(fontSize: 18),
      ),
      title: Text(
        title,
        style: TextStyle(
            fontSize: 16, color: chosen ? Colors.green : Colors.black),
      ),
      trailing: status
          ? const Icon(Icons.download_done_rounded)
          : const Icon(Icons.download_sharp),
    ),
  );
}

extension TranslateIterableView on Iterable<LanguagesItem> {
  toListViewTranslation({required String id, required AppBloc appBloc}) {
    return ListView.builder(
      itemCount: length,
      itemBuilder: (context, index) {
        final data = elementAt(index);
        if (data.id == id) {
          return translationTile(
            title: data.title,
            icon: data.icon,
            status: data.status,
            chosen: true,
            func: () {
              appBloc.add(LanguageChoicesChangesEvent(id: data.id));
            },
          );
        } else {
          return translationTile(
            title: data.title,
            icon: data.icon,
            status: data.status,
            chosen: false,
            func: () {
              appBloc.add(LanguageChoicesChangesEvent(id: data.id));
            },
          );
        }
      },
    );
  }
}
