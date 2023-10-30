import 'dart:async';

import 'package:dictionary_app_1110/bloc/bloc_app/bloc_app.dart';
import 'package:dictionary_app_1110/bloc/bloc_app/bloc_events.dart';
import 'package:dictionary_app_1110/data/strings.dart';
import 'package:dictionary_app_1110/views/gen/generic_typedef_func.dart';
import 'package:dictionary_app_1110/views/gen/generic_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ListTile settingTile(
    {required String title,
    required IconData icon,
    String? subtitle,
    required bool value,
    required SwitchType type,
    required AppBloc appBloc}) {
  return ListTile(
    leading: Icon(icon),
    title: Text(title),
    subtitle: subtitle != null ? Text(subtitle) : null,
    trailing: CupertinoSwitch(
      value: value,
      onChanged: (newValue) {
        appBloc.add(SettingsChangesEvent(type: type, data: newValue));
      },
    ),
  );
}

Widget customToggle(
    {required String title,
    required List<Widget> listTextWidget,
    required List<bool> toggleList,
    required AppBloc appBloc}) {
  return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    const Text(
      stringNavigationTranslate,
      style: TextStyle(
        fontSize: 17,
      ),
    ),
    divineSpace(height: 10),
    ToggleButtons(
      onPressed: (int index) {
        for (int i = 0; i < toggleList.length; i++) {
          toggleList[i] = i == index;
        }
        if (toggleList[0] == true) {
          //choose english
          appBloc.add(
            const SettingsChangesEvent(
              type: SwitchType.languages,
              data: [true, false],
            ),
          );
        } else {
          //chose vietnamese
          appBloc.add(
            const SettingsChangesEvent(
              type: SwitchType.languages,
              data: [false, true],
            ),
          );
        }
      },
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      selectedColor: Colors.black87,
      fillColor: Colors.blue[200],
      color: Colors.grey,
      textStyle: const TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
      constraints: const BoxConstraints(
        minHeight: 50.0,
        minWidth: 100.0,
      ),
      isSelected: toggleList,
      children: listTextWidget,
    ),
  ]);
}

dynamic showSettingsBottomSheet(BuildContext context, AppBloc appBloc,
    StreamController<Iterable<dynamic>> streamController) {
  return showModalBottomSheet(
      enableDrag: true,
      showDragHandle: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35), topRight: Radius.circular(35))),
      context: context,
      builder: (context) {
        return StreamBuilder(
            stream: streamController.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data;
                return FractionallySizedBox(
                  heightFactor: 0.6,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 4),
                        child: Row(
                          children: [
                            const Text(
                              'Settings',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            genericTextButton(
                              icon: Icons.logout_rounded,
                              text: 'Log Out',
                              bgcolor: Colors.red,
                              sized: textButtonSize[Size.medium]!,
                              func: () {},
                            )
                          ],
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.account_circle),
                        title: Text(data!.elementAt(0)),
                      ),
                      divineLine(
                          colors: [Colors.transparent, Colors.grey.shade400],
                          space: 5,
                          start: Alignment.centerLeft),
                      settingTile(
                          title: 'Dark Mode',
                          icon: Icons.dark_mode,
                          value: data.elementAt(1),
                          type: SwitchType.darkMode,
                          appBloc: appBloc),
                      settingTile(
                          title: 'Simple Mode',
                          subtitle: 'Reduce the color of the app.',
                          icon: Icons.square,
                          value: data.elementAt(2),
                          type: SwitchType.simpleMode,
                          appBloc: appBloc),
                      settingTile(
                          title: 'Auto Lookup',
                          subtitle:
                              'Auto paste from clipboard into search bar.',
                          icon: Icons.search_outlined,
                          value: data.elementAt(3),
                          type: SwitchType.autoLookup,
                          appBloc: appBloc),
                      divineLine(
                          colors: [Colors.transparent, Colors.grey.shade400],
                          space: 10,
                          start: Alignment.centerLeft),
                      customToggle(
                        title: 'Languages',
                        listTextWidget: languages,
                        appBloc: appBloc,
                        toggleList: List.of(data.elementAt(4)),
                      ),
                    ],
                  ),
                );
              } else {
                return Container();
              }
            });
      });
}
