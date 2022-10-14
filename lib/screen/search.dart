// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_flutter/bloc_search/search_bloc.dart';
import 'package:notes_flutter/bloc_search/search_event.dart';
import 'package:notes_flutter/bloc_search/search_state.dart';
import 'package:notes_flutter/model/notes.dart';
import 'package:notes_flutter/screen/component/action_icon.dart';
import 'package:notes_flutter/screen/component/shadow_list_widget.dart';
import 'package:notes_flutter/screen/show_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _searchController;
  late List<Notes> notesList;
  late List<Notes> searchList;
  late Size _size;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    context.read<SearchBloc>().add(SearchAllNotesEvent());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFE7ECEF),
      appBar: _buildAppBar(),
      body: buildBody(),
    );
  }

  _buildAppBar() {
    return AppBar(
      // centerTitle: true,
      title: const Text(
        'Search Screen',
        style: TextStyle(fontSize: 24.0, color: Colors.black),
      ),
      shadowColor: Colors.transparent,
      backgroundColor: const Color(0xFFE7ECEF),
      leading: buildActionIcon(
        onTap: () {
          Navigator.pop(context);
        },
        rightMargin: 0.0,
        leftMargin: 10.0,
        icon: Icons.arrow_back,
      ),
    );
  }

  Widget buildBody() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 10.0,
      ),
      child: Column(
        children: [
          BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              return buildSearch();
            },
          ),
          BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state is InitialsearchState || state is LoadingsearchState) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              } else if (state is LoadedsearchState) {
                notesList = state.notesList;
                searchList = notesList;
                return buildSearchListView();
              } else if (state is SearchGetNotesStateWithText) {
                searchList = state.searchList;
                return buildSearchListView();
              } else if (state is SearchErrorState) {
                return Center(
                  child: Text(state.message),
                );
              } else {
                return const Center(
                  child: Text('Something went wrong'),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  buildSearch() {
    return TextField(
      controller: _searchController,
      onChanged: buildChangedtext,
      cursorColor: Colors.yellowAccent,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(255, 168, 168, 168),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        hintText: 'search on keyboard...',
        hintStyle: const TextStyle(color: Colors.white),
        suffixIcon: _searchController.text.isEmpty
            ? const Icon(Icons.search, color: Colors.white)
            : IconButton(
                onPressed: () {
                  _searchController.clear();
                  context.read<SearchBloc>().add(SearchAllNotesEvent());
                },
                icon: const Icon(
                  Icons.cancel,
                  color: Colors.white,
                ),
              ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(100)),
        ),
        focusedBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(100.0)),
        errorBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(100.0)),
      ),
    );
  }

  buildSearchListView() {
    return Expanded(
        child: Padding(
      padding: EdgeInsets.only(top: _size.width * 0.05),
      child: ListView.builder(
        itemCount: searchList.length,
        itemBuilder: (context, index) {
          return ShadowListWidget(
            size: _size,
            notes: searchList[index],
            onTap: onItemTap(index),
          );
        },
      ),
    ));
  }

  VoidCallback onItemTap(int index) {
    return () async {
      _searchController.clear();
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ShowNoteScreen(
            note: searchList[index],
          ),
        ),
      );
      context.read<SearchBloc>().add(SearchAllNotesEvent());
    };
  }

  void buildChangedtext(String text) {
    context
        .read<SearchBloc>()
        .add(SearchGetNotesEventWithText(text, notesList));
  }
}
