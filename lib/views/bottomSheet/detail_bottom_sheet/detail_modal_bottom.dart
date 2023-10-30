import 'dart:async';
import 'package:dictionary_app_1110/bloc/bloc_app/bloc_app.dart';
import 'package:dictionary_app_1110/bloc/bloc_app/bloc_events.dart';
import 'package:dictionary_app_1110/bloc/bloc_chat/bloc_chat.dart';
import 'package:dictionary_app_1110/bloc/bloc_chat/chat_events.dart';
import 'package:dictionary_app_1110/data/strings.dart';
import 'package:dictionary_app_1110/models/new_word_model.dart';
import 'package:dictionary_app_1110/views/ai_chat_view/ai_chat_view.dart';
import 'package:dictionary_app_1110/views/gen/generic_typedef_func.dart';
import 'package:dictionary_app_1110/views/gen/generic_widgets.dart';
import 'package:dictionary_app_1110/views/entry_tile/word_tile.dart';
import 'package:flutter/material.dart';

Future detailModalBottom(
    BuildContext context,
    DictionaryEntry entry,
    AppBloc appBloc,
    ChatBloc chatBloc,
    ModalType type,
    StreamController<DictionaryEntry> controller) {
  return showModalBottomSheet(
    enableDrag: true,
    showDragHandle: true,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35), topRight: Radius.circular(35))),
    context: context,
    builder: (context) {
      return StreamBuilder<DictionaryEntry>(
          stream: controller.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return FractionallySizedBox(
                heightFactor: 0.7,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      headerDetail(
                          snapshot: snapshot,
                          entry: entry,
                          bloc: appBloc,
                          type: type),
                      footerDetail(
                          chatBloc: chatBloc, entry: entry, context: context),
                      divineLine(colors: [
                        Colors.grey.shade200,
                        // Colors.transparent,
                        Colors.grey.shade200
                      ], space: 10, start: Alignment.center, spaceBot: 5),
                      SizedBox(height: 413, child: contentDetail(entry: entry)),
                    ],
                  ),
                ),
              );
            } else {
              return Container();
            }
          });
    },
  );
}

Widget footerDetail(
    {required ChatBloc chatBloc,
    required DictionaryEntry entry,
    required BuildContext context}) {
  return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
    genericTextButton(
      bgcolor: Colors.lightGreen,
      icon: Icons.volume_up_rounded,
      text: stringButtonPlaySound,
      sized: textButtonSize[Size.medium]!,
      func: () {},
    ),
    const Spacer(),
    genericTextButton(
      bgcolor: Colors.amber,
      icon: Icons.chat_bubble,
      text: stringButtonAsk,
      sized: textButtonSize[Size.medium]!,
      func: () {
        chatBloc.add(
          ChatSendButtonEvent(content: "$stringLookUp ${entry.word}"),
        );
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AIChating(chatBloc: chatBloc),
            ));
      },
    ),
    const Spacer(),
    genericTextButton(
      bgcolor: Colors.lightBlue,
      icon: Icons.share,
      text: stringButtonSharing,
      sized: textButtonSize[Size.medium]!,
      func: () {
        // Share.share('${entry.word} - ${entry.meanings.first}');
      },
    ),
  ]);
}

Widget headerDetail({
  required AsyncSnapshot<DictionaryEntry> snapshot,
  required DictionaryEntry entry,
  required AppBloc bloc,
  required ModalType type,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          divineSpace(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                snapshot.data!.word,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              divineSpace(height: 5),
              Row(
                children: [
                  Text(
                    entry.pronunciation.ipa,
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  divineSpace(width: 10),
                  shortEntryType(
                      meanings: entry.meanings,
                      textSize: 17,
                      fontWeight: FontWeight.w500),
                ],
              ),
            ],
          ),
          const Spacer(),
          genericTextButton(
            bgcolor: Colors.lightBlue,
            icon: Icons.favorite,
            colorTapped: Colors.pink,
            text: stringButtonFavorite,
            tapped: snapshot.data!.inFavorite,
            sized: textButtonSize[Size.small]!,
            func: () {
              bloc.add(FavoriteButtonTappedEvent(entry: entry, type: type));
            },
          )
        ],
      ),
      divineLine(
          colors: [Colors.transparent, Colors.grey.shade200],
          space: 15,
          start: Alignment.center),
    ],
  );
}

Widget contentDetail({required DictionaryEntry entry}) {
  return ListView(children: [
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...entry.meanings.map((e) => getContent(e)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              stringItemExamples,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
                fontSize: 17,
              ),
            ),
            divineSpace(height: 15),
            ...entry.examples.map(
              (e) {
                return Column(
                  children: [
                    Text(
                      '- $e',
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    divineSpace(height: 10),
                  ],
                );
              },
            ).toList(),
          ],
        ),
      ],
    ),
  ]);
}

Widget getContent(Meaning meaning) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          divineSpace(height: 5),
          Text(
            stringItemDefinition,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
              fontSize: 17,
            ),
          ),
          const Spacer(),
          Text(
            meaning.tag,
            style: TextStyle(
              fontSize: 17,
              color: typeColor(meaning),
            ),
          )
        ],
      ),
      divineSpace(height: 20),
      ...meaning.values.map(
        (e) {
          return Text(
            e,
            style: const TextStyle(
              fontSize: 15,
            ),
          );
        },
      ).toList(),
      divineLine(
          colors: [Colors.transparent, Colors.grey.shade200],
          space: 10,
          start: Alignment.center),
    ],
  );
}
