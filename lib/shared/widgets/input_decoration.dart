import 'package:flutter/material.dart';

final Color _primaryBorderColor = Color(0XFFdadbe6);
final BorderSide _borderSide = BorderSide(color: _primaryBorderColor);
final OutlineInputBorder _border = OutlineInputBorder(borderSide: _borderSide);
final InputDecoration commonInputDecoration = InputDecoration(
  border: _border,
  enabledBorder: _border,
  focusedBorder: _border,
);
final InputDecoration inputDecorationBorderNone = InputDecoration(border: InputBorder.none);

InputDecoration buildCommonInputDecoration({
  String? labelText,
  Widget? label,
  Widget? suffix,
  Widget? suffixIcon,
  bool? isDense,
  String? hintText,
}) => InputDecoration(
  border: _border,
  enabledBorder: _border,
  focusedBorder: _border,
  labelText: labelText,
  label: label,
  suffix: suffix,
  suffixIcon: suffixIcon,
  isDense: isDense,
  hintText: hintText,
);
