// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_flutter/bloc/bloc.dart';
import 'package:notes_flutter/bloc/event.dart';
import 'package:notes_flutter/model/notes.dart';
import 'package:notes_flutter/screen/add_update_screen.dart';
import 'package:notes_flutter/screen/component/action_icon.dart';
import 'package:notes_flutter/screen/component/delete_alert_dialog.dart';

class ShowNoteScreen extends StatefulWidget {
  const ShowNoteScreen({Key? key, required this.note}) : super(key: key);

  final Notes note;

  @override
  State<ShowNoteScreen> createState() => _ShowNoteScreenState();
}

class _ShowNoteScreenState extends State<ShowNoteScreen> {
  late Notes _notes;
  late Size _size;

  @override
  void initState() {
    _notes = widget.note;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      shadowColor: Colors.transparent,
      leading: buildActionIcon(
          icon: Icons.arrow_back,
          onTap: () {
            Navigator.pop(context);
          },
          rightMargin: 0.0,
          leftMargin: 12.0),
      actions: [
        buildActionIcon(
            icon: Icons.delete,
            onTap: () async {
              bool confirm = await showDeleteAllNotesDialog(context);
              if (confirm) {
                context.read<NotesBloc>().add(DeleteNotesEvent(_notes.id!));
                Navigator.pop(context);
              }
            },
            rightMargin: 12.0),
        buildActionIcon(
            icon: Icons.edit,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return AddUpdateScreen(
                    notes: _notes,
                  );
                },
              ));
            },
            rightMargin: 16.0)
      ],
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.only(
        left: _size.height * 0.04,
        right: _size.height * 0.04,
        top: _size.height * 0.04,
      ),
      child: Column(
        children: [
          _buildTitleText(),
          SizedBox(
            height: _size.height * 0.05,
          ),
          Expanded(
            child: SingleChildScrollView(
                child: SizedBox(
              width: double.infinity,
              child: _buildDescriptionText(),
            )),
          )
        ],
      ),
    );
  }

  Widget _buildDescriptionText() {
    return Text(
        textAlign: TextAlign.left,
        maxLines: null,
        style: TextStyle(fontSize: _size.height * 0.06),
        _notes.description!);
  }

  Widget _buildTitleText() {
    return SizedBox(
      width: double.infinity,
      child: Text(
          textAlign: TextAlign.start,
          maxLines: null,
          style: TextStyle(fontSize: _size.height * 0.06),
          _notes.title!),
    );
  }
}
