import 'dart:async';
import 'package:dictionary_app_1110/bloc/bloc_app/bloc_events.dart';
import 'package:dictionary_app_1110/bloc/bloc_app/bloc_states.dart';
import 'package:dictionary_app_1110/bloc/data_in_cubit.dart';
import 'package:dictionary_app_1110/models/new_word_model.dart';
import 'package:dictionary_app_1110/repositories/fetching_entry.dart';
import 'package:dictionary_app_1110/repositories/url_entry.dart';
import 'package:dictionary_app_1110/views/gen/generic_typedef_func.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  late final HistoryCubit historyCubit;
  late final AllDataCubit allDataCubit;
  late final FavoriteCubit favoriteCubit;
  late final SettingsCubit settingsCubit;
  late final LanguageChoices languageChoices;
  late List<DictionaryEntry> searchList;

  AppBloc() : super(const InitialState()) {
    on<InitialEvent>(initialEvent);
    on<TapToItemEvent>(tapToItemEvent);
    on<SettingsTappedEvent>(settingsTappedEvent);
    on<HistoryTappedEvent>(historyTappedEvent);
    on<FavoriteTappedEvent>(favoriteTappedEvent);
    on<TranslateTappedEvent>(translateTappedEvent);
    on<FavoriteButtonTappedEvent>(favoriteButtonTappedEvent);
    on<DeleteAllEvent>(deleteAllEvent);
    on<SettingsChangesEvent>(settingsChangesEvent);
    on<LanguageChoicesChangesEvent>(languageChoicesChangesEvent);

    on<SearchingEvent>(searchingEvent);
  }

  FutureOr<void> initialEvent(
      InitialEvent event, Emitter<AppState> emit) async {
    emit(const LoadingState());
    historyCubit = HistoryCubit();
    allDataCubit = AllDataCubit();
    favoriteCubit = FavoriteCubit();
    settingsCubit = SettingsCubit();
    searchList = [];

    allDataCubit.englishDictionary = await fetchWord(urlEnglish);
    allDataCubit.vietnameseDictionary = await fetchWord(urlVietnamese);
    allDataCubit.update(allDataCubit.englishDictionary);

    Future.delayed(const Duration(seconds: 5));
    if (allDataCubit.state.isEmpty) {
      emit(const ErrorState());
    } else {
      emit(
        LoadedState(entries: allDataCubit.state),
      );
    }
  }

  FutureOr<void> tapToItemEvent(TapToItemEvent event, Emitter<AppState> emit) {
    historyCubit.add(entry: event.entry);
    emit(TapToItemState(entry: event.entry));
    emit(const OutState());
  }

  FutureOr<void> settingsTappedEvent(
      SettingsTappedEvent event, Emitter<AppState> emit) {
    emit(const SettingsState(
        darkMode: false,
        autoLookup: false,
        language: Languages.english,
        simpleMode: false));
    emit(const OutState());
  }

  FutureOr<void> historyTappedEvent(
      HistoryTappedEvent event, Emitter<AppState> emit) {
    emit(const HistorySheetState());
    emit(const OutState());
  }

  FutureOr<void> translateTappedEvent(
      TranslateTappedEvent event, Emitter<AppState> emit) async {
    emit(const TranslateSheetState());
    emit(const OutState());
  }

  FutureOr<void> favoriteTappedEvent(
      FavoriteTappedEvent event, Emitter<AppState> emit) {
    emit(const FavoriteSheetState());
    emit(const OutState());
  }

  FutureOr<void> favoriteButtonTappedEvent(
      FavoriteButtonTappedEvent event, Emitter<AppState> emit) {
    event.entry.inFavorite = !event.entry.inFavorite;
    if (event.entry.inFavorite == true) {
      favoriteCubit.add(entry: event.entry);
    } else {
      favoriteCubit.remove(entry: event.entry);
    }
    allDataCubit.setInFavorite(entry: event.entry);
    if (searchList.isEmpty) {
      emit(
        LoadedState(entries: allDataCubit.state),
      );
      emit(
        FavoriteButtonTappedState(entry: event.entry, type: event.type),
      );
    } else {
      emit(
        LoadedState(entries: searchList),
      );
      emit(FavoriteButtonTappedState(entry: event.entry, type: event.type));
    }
  }

  FutureOr<void> deleteAllEvent(
      DeleteAllEvent event, Emitter<AppState> emit) async {
    if (historyCubit.state.isNotEmpty) {
      historyCubit.removeAll();
      emit(const DeleteAllState());
    }
  }

  FutureOr<void> settingsChangesEvent(
      SettingsChangesEvent event, Emitter<AppState> emit) {
    final data = event.data;
    switch (event.type) {
      case SwitchType.darkMode:
        settingsCubit.setDarkMode(data);
      case SwitchType.simpleMode:
        settingsCubit.setSimpleMode(simpleMode: data);
      case SwitchType.autoLookup:
        settingsCubit.setAutoLookup(autoLookup: data);
      case SwitchType.languages:
        settingsCubit.setLanguages(list: data);
      default:
    }
    emit(SettingsChangesState(settingsCubit.state));
  }

  FutureOr<void> languageChoicesChangesEvent(
      LanguageChoicesChangesEvent event, Emitter<AppState> emit) {
    languageChoices.chooseById(id: event.id);
    emit(LanguageChoicesChangesState(
        languageChoices: languageChoices.state.elementAt(1)));
    if (languageChoices.state.elementAt(1).first.title == 'English') {
      emit(LoadedState(entries: allDataCubit.englishDictionary));
    } else {
      emit(LoadedState(entries: allDataCubit.vietnameseDictionary));
    }
  }

  FutureOr<void> searchingEvent(SearchingEvent event, Emitter<AppState> emit) {
    searchList = [];
    final value = event.value.toLowerCase();
    if (value == '') {
      emit(
        SearchingState(searchIterable: allDataCubit.state),
      );
      emit(
        LoadedState(entries: allDataCubit.state),
      );
    } else {
      for (var item in allDataCubit.state) {
        if (item.word.startsWith(value)) {
          searchList.add(item);
        }
      }
      emit(
        SearchingState(searchIterable: searchList),
      );
      emit(
        LoadedState(entries: searchList),
      );
    }
  }
}
