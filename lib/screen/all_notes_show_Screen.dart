import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagel/screen/create_note_screen.dart';

import '../bloc/notes_bloc.dart';

class AllNotesShowScreen extends StatelessWidget {
  const AllNotesShowScreen({super.key});

  showNotes(context) {
    BlocProvider.of<NotesBloc>(context).add(ShowAllNotesEvent());
  }

  @override
  Widget build(BuildContext context) {
    showNotes(context);
    return Scaffold(
      appBar: AppBar(title: const Text("All Notes")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<NotesBloc, NotesState>(builder: (context, state) {
          log(" this is the all data screeen ${state.notesList.toString()}");
          // if (state.status != Status.loaded) {
          //   return const Center(child: CircularProgressIndicator());
          // }
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                mainAxisExtent: 200,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20),
            itemBuilder: ((context, index) {
              return Container(
                // decoration: BoxDecoration(border: Border.all(width: 2)),
                child: Card(
                  color: Colors.blue.shade100,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        state.notesList[index].title.toString(),
                        style: const TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 53, 51, 51)),
                      ),
                      Text(
                        maxLines: 6,
                        overflow: TextOverflow.ellipsis,
                        state.notesList[index].content.toString(),
                        style: const TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 53, 51, 51)),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                                onPressed: () {
                                  var onTapNotesDataModel =
                                      state.notesList[index];

                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: ((context) =>
                                              CreateNoteScreen(
                                                isUpdate: true,
                                                notes: onTapNotesDataModel,
                                              ))));
                                },
                                icon: const Icon(Icons.edit)),
                            IconButton(
                                onPressed: () {
                                  var onTapNotesDataModel = notesList[index];

                                  BlocProvider.of<NotesBloc>(context).add(
                                      DeleteNotesEvent(
                                          notesModel: onTapNotesDataModel));
                                },
                                icon: const Icon(Icons.delete)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
            itemCount: state.notesList.length,
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  fullscreenDialog: true,
                  builder: ((context) => CreateNoteScreen(
                        isUpdate: false,
                      ))));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
