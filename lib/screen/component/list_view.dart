import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_flutter/model/notes.dart';

class NotesListItem extends StatelessWidget {
  NotesListItem({
    Key? key,
    required this.size,
    required this.notes,
    required this.onTap,
  }) : super(key: key);

  final Random random = Random();
  final Notes notes;
  final Size size;
  final VoidCallback onTap;
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
        onTap: onTap,
        splashColor: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                notes.title!,
                maxLines: 2,
                style: TextStyle(
                  fontSize: size.width * 0.050,
                ),
              ),
              SizedBox(
                width: size.width * double.infinity,
              ),
              Text(
                DateFormat.yMMMd().format(notes.time!),
                maxLines: 1,
                style: TextStyle(
                  fontSize: size.width * 0.035,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
