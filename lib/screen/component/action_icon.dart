import 'package:flutter/material.dart';

Widget buildActionIcon({
  String? iconPath,
  IconData? icon,
  required VoidCallback onTap,
  required double rightMargin,
  double leftMargin = 0.0,
}) {
  return Container(
    margin: EdgeInsets.only(
      top: 10.0,
      bottom: 10.0,
      right: rightMargin,
      left: leftMargin,
    ),
    clipBehavior: Clip.hardEdge,
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 160, 157, 157),
      borderRadius: BorderRadius.circular(12),
    ),
    alignment: Alignment.center,
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(icon, size: 20),
        ),
      ),
    ),
  );
}
