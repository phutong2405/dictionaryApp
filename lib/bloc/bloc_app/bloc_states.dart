import 'package:dictionary_app_1110/models/new_word_model.dart';
import 'package:dictionary_app_1110/views/gen/generic_typedef_func.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AppState {
  const AppState();
}

class MainActionState implements AppState {
  const MainActionState();
}

class InitialState implements AppState {
  const InitialState();
}

class LoadingState implements AppState {
  const LoadingState();
}

class LoadedState implements AppState {
  final Iterable<DictionaryEntry> entries;

  const LoadedState({required this.entries});
}

class ErrorState implements AppState {
  const ErrorState();
}

class SettingsState implements MainActionState {
  final bool darkMode;
  final bool simpleMode;
  final bool autoLookup;
  final Languages language;
  const SettingsState(
      {required this.darkMode,
      required this.simpleMode,
      required this.autoLookup,
      required this.language});
}

class OutState implements MainActionState {
  const OutState();
}

class TapToItemState implements MainActionState {
  final DictionaryEntry entry;
  const TapToItemState({required this.entry});
}

class HistorySheetState implements MainActionState {
  const HistorySheetState();
}

class FavoriteSheetState implements MainActionState {
  const FavoriteSheetState();
}

class TranslateSheetState implements MainActionState {
  const TranslateSheetState();
}

class FavoriteButtonTappedState implements MainActionState {
  final ModalType type;
  final DictionaryEntry entry;
  const FavoriteButtonTappedState({required this.entry, required this.type});
}

class DeleteAllState implements MainActionState {
  const DeleteAllState();
}

class SettingsChangesState implements MainActionState {
  final Iterable<dynamic> settingsData;
  const SettingsChangesState(this.settingsData);
}

class LanguageChoicesChangesState implements MainActionState {
  final Iterable<dynamic> languageChoices;
  const LanguageChoicesChangesState({required this.languageChoices});
}

class SearchingState implements MainActionState {
  final Iterable<DictionaryEntry> searchIterable;
  const SearchingState({required this.searchIterable});
}
