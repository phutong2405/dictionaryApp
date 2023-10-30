import 'dart:async';

import 'package:dictionary_app_1110/bloc/bloc_app/bloc_app.dart';
import 'package:dictionary_app_1110/controller/controller_bottomsheet.dart';
import 'package:dictionary_app_1110/data/dummy_translation_data.dart';
import 'package:dictionary_app_1110/data/strings.dart';
import 'package:dictionary_app_1110/views/bottomSheet/languages_choices/translation_bottom_sheet.dart';
import 'package:flutter/material.dart';

class LanguageChoicesSheet {
  LanguageChoicesSheet._sharedInstance();
  static final LanguageChoicesSheet _shared =
      LanguageChoicesSheet._sharedInstance();
  factory LanguageChoicesSheet.instance() => _shared;

  BottomSheetController? controller;

  void show(
      {required BuildContext context,
      required AppBloc appBloc,
      required Iterable<LanguagesItem> languageIterable}) {
    if (controller?.updateOptions(appBloc.languageChoices.state[1]) ?? false) {
      return;
    } else {
      controller = showDetailBottomSheet(
          context: context,
          appBloc: appBloc,
          languageIterable: languageIterable);
    }
  }

  void hide() {
    controller?.closeOptions();
    controller = null;
  }

  BottomSheetController showDetailBottomSheet(
      {required BuildContext context,
      required AppBloc appBloc,
      required Iterable<LanguagesItem> languageIterable}) {
    final languageStream = StreamController<Iterable<LanguagesItem>>();
    languageStream.add(languageIterable);

    languageChoices(
        context: context, appBloc: appBloc, controller: languageStream);

    return BottomSheetController(
      closeOptions: () {
        languageStream.close();
        return true;
      },
      updateOptions: (state) {
        languageStream.add(state);
        return true;
      },
    );
  }
}

void languageChoices({
  required BuildContext context,
  required AppBloc appBloc,
  required StreamController<Iterable<LanguagesItem>> controller,
}) {
  showModalBottomSheet(
    enableDrag: true,
    showDragHandle: true,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35), topRight: Radius.circular(35))),
    context: context,
    builder: (context) {
      return FractionallySizedBox(
        heightFactor: 0.4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
              child: Text(
                stringNavigationTranslate,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<Iterable<LanguagesItem>>(
                stream: controller.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return appBloc.languageChoices.state[0]
                        .toListViewTranslation(
                            id: snapshot.data!.elementAt(0).id,
                            appBloc: appBloc);
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
