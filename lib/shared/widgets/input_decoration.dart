import 'package:flutter/material.dart';

final Color _primaryBorderColor = Color(0XFFdadbe6);
final BorderSide _borderSide = BorderSide(color: _primaryBorderColor);
final OutlineInputBorder _border = OutlineInputBorder(borderSide: _borderSide);
final InputDecoration commonInputDecoration = InputDecoration(
  border: _border,
  enabledBorder: _border,
  focusedBorder: _border,
);

InputDecoration buildCommonInputDecoration({
  String? labelText,
  Widget? label,
  Widget? suffix,
  Widget? suffixIcon,
}) => InputDecoration(
  border: _border,
  enabledBorder: _border,
  focusedBorder: _border,
  labelText: labelText,
  label: label,
  suffix: suffix,
  suffixIcon: suffixIcon,
);
