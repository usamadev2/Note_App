import 'package:flutter/material.dart';

Widget buildDialogButton(String text, VoidCallback onTap) {
  return ElevatedButton(
    onPressed: onTap,
    child: Text(text),
  );
}
