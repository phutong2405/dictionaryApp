import 'dart:async';
import 'package:dictionary_app_1110/bloc/bloc_app/bloc_app.dart';
import 'package:dictionary_app_1110/controller/controller_bottomsheet.dart';
import 'package:dictionary_app_1110/models/new_word_model.dart';
import 'package:dictionary_app_1110/views/bottomSheet/list_bottom_sheet/list_modal_bottom.dart';
import 'package:dictionary_app_1110/views/gen/generic_typedef_func.dart';
import 'package:flutter/material.dart';

class ListBottomSheet {
  ListBottomSheet._sharedInstance();
  static final ListBottomSheet _shared = ListBottomSheet._sharedInstance();
  factory ListBottomSheet.instance() => _shared;

  BottomSheetController? controller;

  void show({
    required BuildContext context,
    required Iterable<DictionaryEntry> entries,
    required ModalType type,
    required TileTap func,
    AppBloc? appBloc,
  }) {
    if (controller?.updateOptions(entries) ?? false) {
      return;
    } else {
      controller = showDetailBottomSheet(
          context: context,
          entries: entries,
          type: type,
          func: func,
          appBloc: appBloc);
    }
  }

  void hide() {
    controller?.closeOptions();
    controller = null;
  }

  BottomSheetController showDetailBottomSheet({
    required BuildContext context,
    required Iterable<DictionaryEntry> entries,
    required ModalType type,
    required TileTap func,
    AppBloc? appBloc,
  }) {
    final entryStream = StreamController<Iterable<DictionaryEntry>>();
    entryStream.add(entries);

    listModalBottom(context, entryStream, type, func, appBloc);

    return BottomSheetController(
      closeOptions: () {
        entryStream.close();
        return true;
      },
      updateOptions: (text) {
        entryStream.add(text);
        return true;
      },
    );
  }
}
