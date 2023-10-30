import 'package:dictionary_app_1110/bloc/bloc_app/bloc_app.dart';
import 'package:dictionary_app_1110/bloc/bloc_app/bloc_events.dart';
import 'package:dictionary_app_1110/models/new_word_model.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final AppBloc appBloc;
  final Iterable<DictionaryEntry> data;
  const BottomNav({super.key, required this.data, required this.appBloc});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 60,
      color: Colors.blue.withOpacity(0.8),
      shadowColor: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                appBloc.add(
                  const HistoryTappedEvent(),
                );
              },
              icon: const Icon(
                Icons.history,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            IconButton(
              onPressed: () {
                appBloc.add(
                  FavoriteTappedEvent(
                    entries: appBloc.favoriteCubit.state,
                  ),
                );
              },
              icon: const Icon(
                Icons.favorite,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            IconButton(
              onPressed: () {
                appBloc.add(const SettingsTappedEvent());
              },
              icon: const Icon(
                Icons.account_circle,
                color: Colors.white,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Container(
                decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      Colors.blue,
                      Colors.lightBlue,
                      Colors.blueAccent
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    border: Border.all(color: Colors.white12),
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.all(8),
                child: InkWell(
                  splashColor: Colors.blueAccent,
                  onTap: () {
                    appBloc.add(const TranslateTappedEvent());
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 150,
                    child: Text(
                      " ${appBloc.languageChoices.state.elementAt(1).elementAt(0).icon} ${appBloc.languageChoices.state.elementAt(1).elementAt(0).title}",
                      style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
