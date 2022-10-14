import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_flutter/bloc/bloc.dart';
import 'package:notes_flutter/bloc/event.dart';
import 'package:notes_flutter/model/notes.dart';
import 'package:notes_flutter/screen/component/action_button.dart';
import 'package:notes_flutter/screen/component/action_icon.dart';

class AddUpdateScreen extends StatefulWidget {
  const AddUpdateScreen({Key? key, this.notes}) : super(key: key);

  final Notes? notes;

  @override
  State<AddUpdateScreen> createState() => _AddUpdateScreenState();
}

class _AddUpdateScreenState extends State<AddUpdateScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late Notes _note;
  late Size _size;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();

    _titleController.text = widget.notes?.title ?? '';
    _descriptionController.text = widget.notes?.description ?? '';
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFE7ECEF),
      appBar: buildAppBar(),
      body: _buildBody(),
    );
  }

  buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      shadowColor: Colors.transparent,
      backgroundColor: const Color(0xFFE7ECEF),
      leading: buildActionIcon(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
            Navigator.pop(context);
          },
          icon: Icons.arrow_back,
          rightMargin: 8.0,
          leftMargin: 8.0),
      actions: [
        buildActionButton(context, text: 'save', onTap: onSave),
      ],
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _globalKey,
        child: Column(
          children: [
            TextFormField(
              style: TextStyle(fontSize: _size.height * 0.05),
              autofocus: true,
              controller: _titleController,
              maxLength: 90,
              maxLines: 2,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Title',
                  hintStyle: TextStyle(
                      color: const Color.fromARGB(255, 135, 134, 134),
                      fontSize: _size.height * 0.06)),
            ),
            Expanded(child: buildDiscriptionText())
          ],
        ),
      ),
    );
  }

  Widget buildDiscriptionText() {
    return TextFormField(
      style: TextStyle(fontSize: _size.height * 0.05),
      controller: _descriptionController,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Type Somthing...',
          hintStyle: TextStyle(
              color: const Color.fromARGB(255, 134, 133, 133),
              fontSize: _size.height * 0.05)),
    );
  }

  void onSave() {
    bool validat = _globalKey.currentState!.validate();
    if (validat) {
      if (widget.notes != null) {
        update();
        Navigator.pop(context, _note);
      } else {
        insert();
        Navigator.pop(context);
      }
    }
  }

  void update() {
    _note = widget.notes!.copyWith(
      title: _titleController.text,
      description: _descriptionController.text,
    );
    context.read<NotesBloc>().add(UpdateNotesEvent(_note));
  }

  void insert() {
    context.read<NotesBloc>().add(
          AddNoteEvent(
            Notes(
              title: _titleController.text,
              description: _descriptionController.text,
              time: DateTime.now(),
            ),
          ),
        );
  }
}
