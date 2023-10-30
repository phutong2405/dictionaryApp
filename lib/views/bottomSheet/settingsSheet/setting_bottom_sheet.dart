import 'dart:async';
import 'package:dictionary_app_1110/bloc/bloc_app/bloc_app.dart';
import 'package:dictionary_app_1110/controller/controller_bottomsheet.dart';
import 'package:dictionary_app_1110/views/bottomSheet/settingsSheet/setting_modal_bottom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsBottomSheet {
  SettingsBottomSheet._sharedInstance();
  static final SettingsBottomSheet _shared =
      SettingsBottomSheet._sharedInstance();
  factory SettingsBottomSheet.instance() => _shared;

  BottomSheetController? controller;

  void show(
      {required BuildContext context,
      required AppBloc appBloc,
      required Iterable<dynamic> settingsData}) {
    if (controller?.updateOptions(appBloc.settingsCubit.state) ?? false) {
      return;
    } else {
      controller = showDetailBottomSheet(
          context: context, appBloc: appBloc, settingsData: settingsData);
    }
  }

  void hide() {
    controller?.closeOptions();
    controller = null;
  }

  BottomSheetController showDetailBottomSheet(
      {required BuildContext context,
      required AppBloc appBloc,
      required Iterable<dynamic> settingsData}) {
    final settingsStream = StreamController<Iterable<dynamic>>();
    settingsStream.add(settingsData);

    showSettingsBottomSheet(context, appBloc, settingsStream);

    return BottomSheetController(
      closeOptions: () {
        settingsStream.close();
        return true;
      },
      updateOptions: (state) {
        settingsStream.add(state);
        return true;
      },
    );
  }
}
