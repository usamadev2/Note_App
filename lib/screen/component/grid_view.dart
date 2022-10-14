import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:notes_flutter/model/notes.dart';

class GridViewWidget extends StatelessWidget {
  GridViewWidget(
      {Key? key,
      required this.notes,
      required this.onGridItemTap,
      required this.onGridItemLongPress})
      : super(key: key);

  final Random random = Random();
  final Notes notes;
  final VoidCallback onGridItemTap;
  final VoidCallback onGridItemLongPress;
  List<Color> colorList = [
    Colors.amber,
    Colors.red,
    Colors.blue,
    Colors.deepPurpleAccent,
    Colors.brown,
    Colors.indigoAccent,
    Colors.lime,
    Colors.green,
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      color: colorList[random.nextInt(colorList.length)],
      child: InkWell(
        onTap: onGridItemTap,
        enableFeedback: true,
        onLongPress: onGridItemLongPress,
        splashColor: Colors.white,
        child: LayoutBuilder(builder: (context, innerConstraints) {
          return Padding(
            padding: EdgeInsets.all(innerConstraints.maxHeight * 0.08),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      notes.title ?? '',
                      maxLines: 4,
                      style: TextStyle(
                          fontSize: innerConstraints.maxHeight * 0.115),
                    ),
                  ),
                ),
                Text(
                  DateFormat.yMMMd().format(notes.time!),
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: innerConstraints.maxHeight * 0.08,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
