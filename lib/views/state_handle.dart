import 'package:dictionary_app_1110/bloc/bloc_app/bloc_app.dart';
import 'package:dictionary_app_1110/bloc/bloc_app/bloc_states.dart';
import 'package:dictionary_app_1110/bloc/bloc_chat/bloc_chat.dart';
import 'package:dictionary_app_1110/views/bottomSheet/detail_bottom_sheet/detail_bottom_sheet.dart';
import 'package:dictionary_app_1110/views/bottomSheet/list_bottom_sheet/list_bottom_sheet.dart';
import 'package:dictionary_app_1110/views/bottomSheet/settingsSheet/setting_bottom_sheet.dart';
import 'package:dictionary_app_1110/views/gen/generic_typedef_func.dart';
import 'package:dictionary_app_1110/views/bottomSheet/languages_choices/language_choices.dart';
import 'package:flutter/material.dart';

void stateHandle(
    BuildContext context, AppBloc appBloc, ChatBloc chatBloc, dynamic state) {
  if (state is TapToItemState) {
    DetailBottomSheet.instance().hide();
    DetailBottomSheet.instance().show(
      context: context,
      entry: state.entry,
      type: ModalType.home,
      appBloc: appBloc,
      chatBloc: chatBloc,
    );
  }
  if (state is FavoriteButtonTappedState) {
    switch (state.type) {
      case ModalType.history:
        DetailBottomSheet.instance().controller?.updateOptions(state.entry);
        ListBottomSheet.instance()
            .controller
            ?.updateOptions(appBloc.historyCubit.state);
      case ModalType.favorite:
        ListBottomSheet.instance()
            .controller
            ?.updateOptions(appBloc.favoriteCubit.state);
        Navigator.pop(context);
      default:
        DetailBottomSheet.instance().controller?.updateOptions(state.entry);
    }
  }
  if (state is DeleteAllState) {
    Navigator.pop(context);

    ListBottomSheet.instance().hide();
    ListBottomSheet.instance().show(
      context: context,
      entries: appBloc.historyCubit.state,
      type: ModalType.history,
      func: (entry) {
        DetailBottomSheet.instance().hide();
        DetailBottomSheet.instance().show(
          context: context,
          entry: entry,
          type: ModalType.history,
          appBloc: appBloc,
          chatBloc: chatBloc,
        );
      },
      appBloc: appBloc,
    );
  }

  if (state is HistorySheetState) {
    ListBottomSheet.instance().hide();
    ListBottomSheet.instance().show(
      context: context,
      entries: appBloc.historyCubit.state,
      type: ModalType.history,
      func: (entry) {
        DetailBottomSheet.instance().hide();
        DetailBottomSheet.instance().show(
          context: context,
          entry: entry,
          type: ModalType.history,
          appBloc: appBloc,
          chatBloc: chatBloc,
        );
      },
      appBloc: appBloc,
    );
  }
  if (state is FavoriteSheetState) {
    ListBottomSheet.instance().hide();
    ListBottomSheet.instance().show(
      context: context,
      entries: appBloc.favoriteCubit.state,
      type: ModalType.favorite,
      func: (entry) {
        DetailBottomSheet.instance().hide();
        DetailBottomSheet.instance().show(
          context: context,
          entry: entry,
          type: ModalType.favorite,
          appBloc: appBloc,
          chatBloc: chatBloc,
        );
      },
    );
  }
  if (state is SettingsState) {
    SettingsBottomSheet.instance().hide();
    SettingsBottomSheet.instance().show(
        context: context,
        appBloc: appBloc,
        settingsData: appBloc.settingsCubit.state);
  }
  if (state is SettingsChangesState) {
    SettingsBottomSheet.instance()
        .controller
        ?.updateOptions(appBloc.settingsCubit.state);
  }

  if (state is TranslateSheetState) {
    LanguageChoicesSheet.instance().hide();
    LanguageChoicesSheet.instance().show(
        context: context,
        appBloc: appBloc,
        languageIterable: appBloc.languageChoices.state[1]);
  }

  if (state is LanguageChoicesChangesState) {
    LanguageChoicesSheet.instance()
        .controller
        ?.updateOptions(state.languageChoices);
  }
}
