import 'dart:async';
import 'package:dictionary_app_1110/bloc/bloc_app/bloc_app.dart';
import 'package:dictionary_app_1110/bloc/bloc_app/bloc_events.dart';
import 'package:dictionary_app_1110/data/strings.dart';
import 'package:dictionary_app_1110/models/new_word_model.dart';
import 'package:dictionary_app_1110/views/entry_tile/word_tile.dart';
import 'package:dictionary_app_1110/views/gen/generic_typedef_func.dart';
import 'package:dictionary_app_1110/views/gen/generic_widgets.dart';
import 'package:flutter/material.dart';

Future listModalBottom(
    BuildContext context,
    StreamController<Iterable<DictionaryEntry>> controller,
    ModalType type,
    TileTap func,
    AppBloc? appBloc) {
  return showModalBottomSheet(
    enableDrag: true,
    showDragHandle: true,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35), topRight: Radius.circular(35))),
    context: context,
    builder: (context) {
      return StreamBuilder<Iterable<DictionaryEntry>>(
          stream: controller.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final entries = snapshot.data;
              return FractionallySizedBox(
                heightFactor: entries!.isNotEmpty ? 0.93 : 0.18,
                child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 4),
                          child: Row(
                            children: [
                              Text(
                                bottomSheetName[type]!,
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              type == ModalType.history
                                  ? genericTextButton(
                                      icon: Icons.delete_forever,
                                      text: 'Delete All',
                                      bgcolor: entries.isNotEmpty
                                          ? Colors.red
                                          : Colors.grey,
                                      sized: textButtonSize[Size.medium]!,
                                      func: () {
                                        if (appBloc != null) {
                                          appBloc.add(const DeleteAllEvent());
                                        }
                                      },
                                    )
                                  : const Spacer()
                            ],
                          ),
                        ),
                        entries.isNotEmpty
                            ? Expanded(child: entries.toListView((entry) {
                                func(entry);
                              }))
                            : const Center(
                                child: Text(
                                  stringNoItems,
                                  style: TextStyle(
                                      fontSize: 22, color: Colors.grey),
                                ),
                              )
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Container(
                  margin: const EdgeInsets.all(20),
                  height: 400,
                  alignment: Alignment.center,
                  child: const Text(
                    stringNoItems,
                    style: TextStyle(fontSize: 30),
                  ));
            }
          });
    },
  );
}
