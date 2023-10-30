import 'dart:async';
import 'package:dictionary_app_1110/bloc/bloc_app/bloc_app.dart';
import 'package:dictionary_app_1110/bloc/bloc_chat/bloc_chat.dart';
import 'package:dictionary_app_1110/controller/controller_bottomsheet.dart';
import 'package:dictionary_app_1110/models/new_word_model.dart';
import 'package:dictionary_app_1110/views/bottomSheet/detail_bottom_sheet/detail_modal_bottom.dart';
import 'package:dictionary_app_1110/views/gen/generic_typedef_func.dart';
import 'package:flutter/material.dart';

class DetailBottomSheet {
  DetailBottomSheet._sharedInstance();
  static final DetailBottomSheet _shared = DetailBottomSheet._sharedInstance();
  factory DetailBottomSheet.instance() => _shared;

  BottomSheetController? controller;

  void show(
      {required BuildContext context,
      required DictionaryEntry entry,
      required ModalType type,
      required AppBloc appBloc,
      required ChatBloc chatBloc}) {
    if (controller?.updateOptions(entry) ?? false) {
      return;
    } else {
      controller = showDetailBottomSheet(
          context: context,
          entry: entry,
          type: type,
          appBloc: appBloc,
          chatBloc: chatBloc);
    }
  }

  void hide() {
    controller?.closeOptions();
    controller = null;
  }

  BottomSheetController showDetailBottomSheet({
    required BuildContext context,
    required DictionaryEntry entry,
    required ModalType type,
    required AppBloc appBloc,
    required ChatBloc chatBloc,
  }) {
    final entryStream = StreamController<DictionaryEntry>();
    entryStream.add(entry);

    detailModalBottom(context, entry, appBloc, chatBloc, type, entryStream);

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
