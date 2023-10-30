import 'package:dictionary_app_1110/bloc/bloc_app/bloc_app.dart';
import 'package:dictionary_app_1110/bloc/bloc_app/bloc_events.dart';
import 'package:dictionary_app_1110/bloc/bloc_chat/bloc_chat.dart';
import 'package:dictionary_app_1110/bloc/bloc_chat/chat_events.dart';
import 'package:dictionary_app_1110/data/strings.dart';
import 'package:dictionary_app_1110/views/ai_chat_view/ai_chat_view.dart';
import 'package:dictionary_app_1110/views/gen/generic_widgets.dart';
import 'package:flutter/material.dart';

class SearchFieldView extends StatefulWidget {
  final AppBloc appBloc;
  final ChatBloc chatBloc;
  const SearchFieldView(
      {super.key, required this.appBloc, required this.chatBloc});

  @override
  State<SearchFieldView> createState() => _SearchFieldViewState();
}

class _SearchFieldViewState extends State<SearchFieldView> {
  late final TextEditingController textController;
  @override
  void initState() {
    textController = TextEditingController();
    super.initState();
  }

  void searchProcess() {
    if (textController.text.length > 10 ||
        textController.text.trim().contains(' ')) {
      widget.chatBloc.add(ChatSendButtonEvent(content: textController.text));
      textController.clear();
      widget.appBloc.add(const SearchingEvent(value: ''));
    } else {
      widget.chatBloc.add(
          ChatSendButtonEvent(content: "$stringLookUp ${textController.text}"));
      textController.clear();
      widget.appBloc.add(const SearchingEvent(value: ''));
    }

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => AIChating(chatBloc: widget.chatBloc),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      alignment: Alignment.center,
      child: TextField(
        controller: textController,
        // textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        maxLines: 1,
        decoration: InputDecoration(
          // hintText: 'Dicktionary',
          isDense: true,
          filled: true,
          prefixIcon: textController.text.isEmpty
              ? const Icon(
                  Icons.search_outlined,
                  size: 22,
                )
              : IconButton(
                  onPressed: () {
                    textController.clear();
                    widget.appBloc.add(const SearchingEvent(value: ''));
                  },
                  icon: const Icon(
                    Icons.clear,
                    size: 22,
                    color: Colors.grey,
                  ),
                ),
          suffixIcon: textController.text.isEmpty
              ? IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          AIChating(chatBloc: widget.chatBloc),
                    ));
                  },
                  icon: const Icon(
                    Icons.chat_bubble,
                    color: Colors.lightBlue,
                    size: 22,
                  ),
                )
              : InkWell(
                  onTap: () {
                    searchProcess();
                  },
                  child: SizedBox(
                    width: 78,
                    child: Row(
                      children: [
                        divineSpace(width: 3),
                        const Text(
                          'Ask',
                          style: TextStyle(color: Colors.blue, fontSize: 15),
                        ),
                        IconButton(
                          onPressed: () {
                            searchProcess();
                          },
                          icon: const Icon(
                            Icons.chat_bubble,
                            color: Colors.lightBlue,
                            size: 22,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          fillColor: Colors.white,
          iconColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
        ),
        onChanged: (value) {
          textController.text = value;
          widget.appBloc.add(
            SearchingEvent(value: value),
          );
        },
      ),
    );
  }
}
