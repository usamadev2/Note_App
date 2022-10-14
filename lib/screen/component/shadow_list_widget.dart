import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:intl/intl.dart';
import 'package:notes_flutter/model/notes.dart';

class ShadowListWidget extends StatelessWidget {
  const ShadowListWidget({
    Key? key,
    required this.size,
    required this.notes,
    required this.onTap,
  }) : super(key: key);

  final Notes notes;
  final Size size;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Offset offset = const Offset(3, 3);
    double blur = 2.0;
    return Container(
      margin: EdgeInsets.only(top: size.height * 0.03),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
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
                  fontSize: size.width * 0.060,
                ),
              ),
              SizedBox(
                width: size.width * double.infinity,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  DateFormat.yMMMd().format(notes.time!),
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: size.width * 0.035,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
