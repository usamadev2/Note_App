import 'package:flutter/material.dart';
import 'package:notes_flutter/screen/component/dialog_button.dart';

Future<bool> showDeleteAllNotesDialog(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Delete'),
        content: const Text(
          'Do you really want to delete all the notes?',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          buildDialogButton(
            'No',
            () => Navigator.pop(context, false),
          ),
          buildDialogButton(
            'Yes',
            () => Navigator.pop(context, true),
          ),
        ],
      );
    },
  );
}
