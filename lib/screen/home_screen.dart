// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_flutter/bloc/bloc.dart';
import 'package:notes_flutter/bloc/event.dart';
import 'package:notes_flutter/bloc/state.dart';
import 'package:notes_flutter/model/notes.dart';
import 'package:notes_flutter/screen/add_update_screen.dart';
import 'package:notes_flutter/screen/component/action_icon.dart';
import 'package:notes_flutter/screen/component/delete_alert_dialog.dart';
import 'package:notes_flutter/screen/component/shado_grid.dart';
import 'package:notes_flutter/screen/component/shadow_list_widget.dart';
import 'package:notes_flutter/screen/search.dart';
import 'package:notes_flutter/screen/show_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Notes> _notesList;
  late Size _size;
  bool showGrid = true;
  bool confirmDeletelistItem = false;

  @override
  void dispose() {
    closedb();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFE7ECEF),
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _builFAB(),
    );
  }

  _buildAppBar() {
    return AppBar(
      shadowColor: Colors.transparent,
      backgroundColor: const Color(0xFFE7ECEF),
      title: Text(
        'NotesKeeper',
        style: TextStyle(color: Colors.black, fontSize: _size.height * 0.045),
      ),
      actions: [
        buildActionIcon(
          icon: Icons.delete,
          onTap: () async {
            bool delete = await showDeleteAllNotesDialog(context);
            if (delete) {
              context.read<NotesBloc>().add(DeleteAllNotesEvent());
            }
          },
          rightMargin: 16.0,
        ),
        buildActionIcon(
          icon: Icons.search,
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return const SearchScreen();
              },
            ));
          },
          rightMargin: 16.0,
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.only(
        left: _size.height * 0.015,
        right: _size.height * 0.015,
        bottom: _size.height * 0.015,
      ),
      child: Column(
        children: [
          _buildRow(),
          Expanded(child: BlocBuilder<NotesBloc, NoteState>(
            builder: (context, state) {
              if (state is LoadingNotesState || state is InitialNoteState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is LoadedNoteState) {
                _notesList = state.notes;
                return _buildItemViewOrEmpty();
              } else if (state is DeleteNotesState) {
                _notesList = state.notes;
                return _buildItemViewOrEmpty();
              } else if (state is AllDeleteNotesState) {
                _notesList = [];
                return _buildItemViewOrEmpty();
              } else if (state is UpdateNotesState) {
                _notesList = state.notes;
                return _buildItemViewOrEmpty();
              } else if (state is ShowNotesViewState) {
                showGrid = state.grid;
                return _buildItemViewOrEmpty();
              } else if (state is AddNotesState) {
                _notesList = state.notes;
                return _buildItemViewOrEmpty();
              } else if (state is ErrorNotesState) {
                return Text(state.message);
              } else {
                return const Text('Somthing wrong went');
              }
            },
          )),
        ],
      ),
    );
  }

  Widget _buildRow() {
    return Padding(
      padding: EdgeInsets.only(
        left: _size.height * 0.015,
        right: _size.height * 0.015,
        bottom: _size.height * 0.015,
      ),
      child: Row(
        children: [
          Expanded(child: _buildRowText()),
          IconButton(
            icon: const Icon(Icons.grid_view_rounded),
            onPressed: () {
              if (showGrid) {
                return;
              } else {
                context.read<NotesBloc>().add(ShowInGridNoteEvent());
              }
            },
          ),
          IconButton(
              onPressed: () {
                if (!showGrid) {
                  return;
                } else {
                  context.read<NotesBloc>().add(ShowInListNotesEvent());
                }
              },
              icon: const Icon(Icons.menu)),
        ],
      ),
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      itemCount: _notesList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 16.0, mainAxisSpacing: 16.0),
      itemBuilder: (context, index) {
        return ShadowGridWidget(
            notes: _notesList[index],
            onGridItemTap: _buildonTapItem(index),
            onGridItemLongPress: _buildOnLongPressedItem(index));
      },
    );
  }

  Widget _builListView() {
    return ListView.builder(
      itemCount: _notesList.length,
      itemBuilder: (context, index) {
        return Dismissible(
            key: ObjectKey(_notesList[index]),
            confirmDismiss: deleteConfirmDismissList(index),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              color: Colors.red,
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            child: ShadowListWidget(
                size: _size,
                notes: _notesList[index],
                onTap: _buildonTapItem(index)));
      },
    );
  }

  Widget _buildRowText() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black, width: 2.0)),
        ),
        child: const Text('All Notes',
            style: TextStyle(
                fontSize: 18.0, color: Color.fromARGB(255, 123, 122, 122))),
      ),
    );
  }

  Widget _builFAB() {
    return FloatingActionButton(
      backgroundColor: const Color.fromARGB(255, 134, 134, 134),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return const AddUpdateScreen();
          },
        ));
      },
      child: const Icon(Icons.add),
    );
  }

  Widget _buildItemViewOrEmpty() {
    if (_notesList.isEmpty) {
      return const Center(
          child: Text(
        'No Notes',
        style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
      ));
    } else {
      return showGrid ? _buildGridView() : _builListView();
    }
  }

  VoidCallback _buildonTapItem(int index) {
    return () async {
      await Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return ShowNoteScreen(
            note: _notesList[index],
          );
        },
      ));
    };
  }

  VoidCallback _buildOnLongPressedItem(int index) {
    return () async {
      bool deleteGridItem = await showDeleteAllNotesDialog(context);
      if (deleteGridItem) {
        context.read<NotesBloc>().add(DeleteNotesEvent(_notesList[index].id!));
        deleteGridItem = false;
      }
    };
  }

  ConfirmDismissCallback deleteConfirmDismissList(int index) {
    return (direction) async {
      confirmDeletelistItem = await showDeleteAllNotesDialog(context);

      if (confirmDeletelistItem) {
        context.read<NotesBloc>().add(DeleteNotesEvent(_notesList[index].id!));
        confirmDeletelistItem = false;
        return true;
      }
      return false;
    };
  }

  void closedb() {
    context.read<NotesBloc>().add(CloseDBEvent());
  }
}
