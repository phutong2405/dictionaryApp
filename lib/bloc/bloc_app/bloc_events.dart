import 'package:dictionary_app_1110/models/new_word_model.dart';
import 'package:dictionary_app_1110/views/gen/generic_typedef_func.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AppEvent {
  const AppEvent();
}

class InitialEvent implements AppEvent {
  const InitialEvent();
}

class TapToItemEvent implements AppEvent {
  final DictionaryEntry entry;
  const TapToItemEvent({
    required this.entry,
  });
}

class HistoryTappedEvent implements AppEvent {
  const HistoryTappedEvent();
}

class FavoriteTappedEvent implements AppEvent {
  final Iterable<DictionaryEntry> entries;
  const FavoriteTappedEvent({required this.entries});
}

class TranslateTappedEvent implements AppEvent {
  const TranslateTappedEvent();
}

class SettingsTappedEvent implements AppEvent {
  const SettingsTappedEvent();
}

class ChatTappedEvent implements AppEvent {
  const ChatTappedEvent();
}

@immutable
abstract class DetailItemEvent implements AppEvent {
  const DetailItemEvent();
}

class FavoriteButtonTappedEvent implements DetailItemEvent {
  final ModalType type;
  final DictionaryEntry entry;
  const FavoriteButtonTappedEvent({
    required this.entry,
    required this.type,
  });
}

class CopyButtonTappedEvent implements DetailItemEvent {
  final DictionaryEntry entry;
  const CopyButtonTappedEvent({
    required this.entry,
  });
}

class ShareButtonTappedEvent implements DetailItemEvent {
  final DictionaryEntry entry;
  const ShareButtonTappedEvent({
    required this.entry,
  });
}

class AskButtonTappedEvent implements DetailItemEvent {
  final DictionaryEntry entry;
  const AskButtonTappedEvent({
    required this.entry,
  });
}

class DeleteAllEvent implements DetailItemEvent {
  const DeleteAllEvent();
}

enum SwitchType { darkMode, simpleMode, autoLookup, languages }

class SettingsChangesEvent implements AppEvent {
  final dynamic data;
  final SwitchType type;
  const SettingsChangesEvent({required this.type, required this.data});
}

class LanguageChoicesChangesEvent implements AppEvent {
  final String id;
  LanguageChoicesChangesEvent({required this.id});
}

class SearchingEvent implements AppEvent {
  final String value;
  const SearchingEvent({required this.value});
}
