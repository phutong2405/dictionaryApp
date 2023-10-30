import 'package:dictionary_app_1110/bloc/bloc_app/bloc_app.dart';
import 'package:dictionary_app_1110/bloc/bloc_app/bloc_events.dart';
import 'package:dictionary_app_1110/bloc/bloc_app/bloc_states.dart';
import 'package:dictionary_app_1110/bloc/bloc_chat/bloc_chat.dart';
import 'package:dictionary_app_1110/bloc/bloc_chat/chat_events.dart';
import 'package:dictionary_app_1110/bloc/data_in_cubit.dart';
import 'package:dictionary_app_1110/data/strings.dart';
import 'package:dictionary_app_1110/models/new_word_model.dart';
import 'package:dictionary_app_1110/views/controlling_view/bottom_navbar.dart';
import 'package:dictionary_app_1110/views/controlling_view/homepage.dart';
import 'package:dictionary_app_1110/views/controlling_view/search_view.dart';
import 'package:dictionary_app_1110/views/state_handle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late AppBloc appBloc;
  late ChatBloc chatBloc;

  @override
  void initState() {
    super.initState();
    appBloc = AppBloc();
    appBloc.languageChoices = LanguageChoices();

    appBloc.add(const InitialEvent());
    chatBloc = ChatBloc();
    chatBloc.add(const ChatInitialEvent());
  }

  Widget mainView({required Iterable<DictionaryEntry> entries, Widget? body}) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.withOpacity(0.8),
        toolbarHeight: 60,
        title: Container(
          height: 50,
          width: 320,
          padding: const EdgeInsets.all(1),
          margin: const EdgeInsets.all(10),
          child: SearchFieldView(
            appBloc: appBloc,
            chatBloc: chatBloc,
          ),
        ),
      ),
      body: body,
      bottomNavigationBar: BottomNav(
        appBloc: appBloc,
        data: entries,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: appBloc,
      listenWhen: (previous, current) => current is MainActionState,
      buildWhen: (previous, current) =>
          current is! MainActionState ||
          previous is SearchingState ||
          previous is LanguageChoicesChangesState,
      listener: (context, state) {
        stateHandle(
          context,
          appBloc,
          chatBloc,
          state,
        );
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case LoadedState:
            state as LoadedState;
            final entries = state.entries;
            return mainView(
              entries: entries,
              body: HomePage(
                  data: entries,
                  func: (DictionaryEntry entry) {
                    appBloc.add(TapToItemEvent(entry: entry));
                  }),
            );

          case LoadingState:
            return mainView(
              entries: [],
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            );

          case ErrorState:
            return mainView(
                entries: [],
                body: const Center(
                  child: Text(stringErrorState),
                ));

          default:
            return mainView(
              entries: [],
            );
        }
      },
    );
  }
}
