import 'package:flutter/material.dart';

Widget buildPageHeaderText(String text) => Text(
  text,
  style: TextStyle(
    color: Color(0XFF3b3c66),
    fontSize: 32,
    fontWeight: FontWeight.bold,
  ),
);

Widget buildHeaderText(String text, {Color? color}) => Text(
  text,
  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color),
);

Widget buildSecondaryHeaderText(String text, {Color? color}) => Text(
  text,
  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color),
);

Widget buildBoldText(String text, {Color? color}) =>
    Text(text, style: TextStyle(fontWeight: FontWeight.bold, color: color));

Widget buildNormalRequiredText(String text) => Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    Text(text),
    SizedBox(width: 2),
    Text('*', style: TextStyle(color: Colors.redAccent)),
  ],
);
