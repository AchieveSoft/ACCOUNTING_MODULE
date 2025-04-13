import 'package:flutter/material.dart';

class _IconButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Function onPressed;

  const _IconButton({
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => IconButton(
    onPressed: () {
      onPressed();
    },
    icon: Icon(icon, color: Colors.white),
    style: IconButton.styleFrom(backgroundColor: color),
  );
}

class EditIconButton extends _IconButton {
  const EditIconButton({required super.onPressed})
    : super(icon: Icons.edit, color: Colors.greenAccent);
}

class DeleteIconButton extends _IconButton {
  const DeleteIconButton({required super.onPressed})
    : super(icon: Icons.delete, color: Colors.redAccent);
}
