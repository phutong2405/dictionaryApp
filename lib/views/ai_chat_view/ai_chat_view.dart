import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dictionary_app_1110/bloc/bloc_chat/bloc_chat.dart';
import 'package:dictionary_app_1110/bloc/bloc_chat/chat_events.dart';
import 'package:dictionary_app_1110/bloc/bloc_chat/chat_states.dart';
import 'package:dictionary_app_1110/data/dummy_chat_data.dart';
import 'package:dictionary_app_1110/data/strings.dart';
import 'package:dictionary_app_1110/views/ai_chat_view/message_text_field_view.dart';
import 'package:dictionary_app_1110/views/gen/generic_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AIChating extends StatelessWidget {
  final ChatBloc chatBloc;
  const AIChating({super.key, required this.chatBloc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: chatAppBar(context: context, chatBloc: chatBloc),
        ),
      ),
      body: BlocBuilder(
        bloc: chatBloc,
        buildWhen: (previous, current) =>
            current is ChatState && current is! MessageLoadded,
        builder: (context, state) {
          switch (state.runtimeType) {
            case ChatLoaddingState:
              return const Center(
                child: CircularProgressIndicator(),
              );

            case ChatLoaddedState:
              return chatBloc.messageCubit.state.isEmpty ||
                      // ignore: unrelated_type_equality_checks
                      chatBloc.messageCubit.state == []
                  ? const Center(
                      child: Text(
                      stringNoChat,
                      style: TextStyle(color: Colors.black54),
                    ))
                  : chatList(chatBloc: chatBloc, isAnimate: true);

            case MessageLoadded:
              return chatList(chatBloc: chatBloc, isAnimate: false);

            default:
              return const SizedBox();
          }
        },
      ),
      bottomSheet: MessageTextField(chatBloc: chatBloc),
    );
  }
}

Widget chatAppBar({required BuildContext context, required ChatBloc chatBloc}) {
  return Container(
    padding: const EdgeInsets.only(
      right: 16,
    ),
    child: Row(
      children: <Widget>[
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black54,
          ),
        ),
        divineSpace(width: 15),
        const Text(
          stringChatTitle,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.blue),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            chatBloc.add(const ChatCleanEvent());
          },
          icon: const Icon(
            Icons.cleaning_services_outlined,
            color: Colors.black54,
          ),
        ),
      ],
    ),
  );
}

Widget chatList({required ChatBloc chatBloc, required bool isAnimate}) {
  final messages = chatBloc.messageCubit.state;
  return SingleChildScrollView(
    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
    reverse: true,
    padding: const EdgeInsets.only(bottom: 100),
    child: ListView.builder(
      itemCount: messages.length,
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return chatBox(
            messages: messages,
            chatBloc: chatBloc,
            index: index,
            animation: isAnimate);
      },
    ),
  );
}

Widget chatBox(
    {required Iterable<ChatMessage> messages,
    required ChatBloc chatBloc,
    required int index,
    required bool animation}) {
  final bool isSender =
      messages.elementAt(index).messageType == MessageType.sender;

  return Container(
    margin: isSender
        ? const EdgeInsets.only(left: 50, right: 14, top: 10, bottom: 10)
        : const EdgeInsets.only(left: 14, right: 50, top: 10, bottom: 10),
    child: Align(
      alignment: !isSender ? Alignment.topLeft : Alignment.topRight,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: (messages.elementAt(index).messageType == MessageType.receiver
              ? Colors.grey.shade200
              : Colors.blue[200]),
        ),
        padding: const EdgeInsets.all(16),
        child: (index == messages.length - 1 && animation != false)
            ? AnimatedTextKit(
                isRepeatingAnimation: false,
                displayFullTextOnTap: true,
                totalRepeatCount: 0,
                animatedTexts: [
                  chatBloc.isLoading
                      ? TyperAnimatedText('',
                          speed: const Duration(microseconds: 1))
                      : TyperAnimatedText('﹒﹒﹒',
                          textStyle: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                          speed: const Duration(seconds: 1)),
                  TyperAnimatedText(
                      speed: const Duration(milliseconds: 35),
                      messages.elementAt(index).messageContent,
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      )),
                ],
              )
            : Text(
                messages.elementAt(index).messageContent,
                style: const TextStyle(fontSize: 15),
              ),
      ),
    ),
  );
}
