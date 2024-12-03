import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagel/bloc/notes_bloc.dart';
import 'package:pagel/data/provider_data/notes_provider.dart';
import 'package:pagel/data/repo/notes_repo.dart';

import 'screen/all_notes_show_Screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => NotesBloc(NotesRepo(NotesProvider()))),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const AllNotesShowScreen(),
      ),
    );
  }
}
