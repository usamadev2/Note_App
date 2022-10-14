import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_flutter/bloc/bloc.dart';
import 'package:notes_flutter/bloc/event.dart';
import 'package:notes_flutter/bloc_search/search_bloc.dart';
import 'package:notes_flutter/bloc_search/search_event.dart';
import 'package:notes_flutter/screen/home_screen.dart';

void main(List<String> args) {
  runApp(MultiBlocProvider(providers: [
    BlocProvider<NotesBloc>(
      create: (context) {
        return NotesBloc()..add(ShowAllNotesEvent());
      },
    ),
    BlocProvider<SearchBloc>(
      create: (context) {
        return SearchBloc()..add(SearchAllNotesEvent());
      },
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
