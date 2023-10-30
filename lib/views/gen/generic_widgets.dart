import 'package:flutter/material.dart';

Widget divineSpace({double? height, double? width}) {
  return SizedBox(
    height: height,
    width: width,
  );
}

Widget divineLine(
    {required List<Color> colors,
    required double space,
    double? spaceTop,
    double? spaceBot,
    required AlignmentGeometry start}) {
  return Column(
    children: [
      SizedBox(
        height: spaceTop ?? space,
      ),
      Container(
        height: 1,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: colors, begin: start),
        ),
      ),
      SizedBox(
        height: spaceBot ?? space,
      ),
    ],
  );
}

typedef TextButtonTapped = void Function();

TextButton genericTextButton(
    {required IconData icon,
    required String text,
    required Color bgcolor,
    Color? colorTapped,
    required double sized,
    bool? tapped,
    required TextButtonTapped func}) {
  tapped ??= false;
  return TextButton.icon(
    style: ButtonStyle(
      overlayColor:
          MaterialStateColor.resolveWith((states) => Colors.blueAccent),
      backgroundColor:
          MaterialStatePropertyAll(!tapped ? bgcolor : colorTapped),
      shape: const MaterialStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    ),
    onPressed: () {
      func();
    },
    icon: Icon(
      size: sized,
      icon,
      color: Colors.white,
    ),
    label: Text(
      text,
      style: const TextStyle(
        color: Colors.white,
      ),
    ),
  );
}
