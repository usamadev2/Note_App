import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:intl/intl.dart';

import 'package:notes_flutter/model/notes.dart';

class ShadowGridWidget extends StatelessWidget {
  const ShadowGridWidget(
      {Key? key,
      required this.notes,
      required this.onGridItemTap,
      required this.onGridItemLongPress})
      : super(key: key);

  final Notes notes;
  final VoidCallback onGridItemTap;
  final VoidCallback onGridItemLongPress;

  @override
  Widget build(BuildContext context) {
    Offset offset = const Offset(10, 10);
    double blur = 5.0;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: const Color(0xFFE7ECEF),
          boxShadow: [
            BoxShadow(
                offset: -offset,
                blurRadius: blur,
                color: Colors.white,
                inset: true),
            BoxShadow(
                offset: offset,
                blurRadius: blur,
                color: const Color(0xFFA7A9AF),
                inset: true),
          ]),
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
                          fontSize: innerConstraints.maxHeight * 0.125),
                    ),
                  ),
                ),
                Text(
                  DateFormat.yMMMd().format(notes.time!),
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: innerConstraints.maxHeight * 0.09,
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
