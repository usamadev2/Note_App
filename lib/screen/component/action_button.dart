import 'package:flutter/material.dart';

buildActionButton(
  BuildContext context, {
  required String text,
  required VoidCallback onTap,
}) {
  return Container(
    margin: const EdgeInsets.only(
      top: 10.0,
      bottom: 10.0,
      right: 15.0,
      left: 0.0,
    ),
    clipBehavior: Clip.hardEdge,
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 173, 169, 169),
      borderRadius: BorderRadius.circular(12),
    ),
    alignment: Alignment.center,
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 15.0,
          ),
          child: Text(text, style: const TextStyle(color: Colors.white)),
        ),
      ),
    ),
  );
}
