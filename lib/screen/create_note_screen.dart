import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagel/bloc/notes_bloc.dart';
import 'package:pagel/model/notes_model.dart';
import 'package:uuid/uuid.dart';

List<NotesModel> notesList = [];

class CreateNoteScreen extends StatefulWidget {
  final bool isUpdate;
  final NotesModel? notes;
  CreateNoteScreen({required this.isUpdate, this.notes, super.key});

  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  @override
  void initState() {
    updatetitleData();
    super.initState();
  }

  TextEditingController titleCtrl = TextEditingController();
  TextEditingController contentCtrl = TextEditingController();
  FocusNode focusNode = FocusNode();

  updatetitleData() {
    if (widget.isUpdate) {
      titleCtrl.text = widget.notes!.title.toString();
      contentCtrl.text = widget.notes!.content.toString();
    } else {
      return null;
    }
  }

  updateNote() {
    NotesModel notesModel = NotesModel(
      id: widget.notes!.id.toString(),
      userid: widget.notes!.userid.toString(),
      title: titleCtrl.text.trim(),
      content: contentCtrl.text.trim(),
      date: DateTime.now(),
    );

    BlocProvider.of<NotesBloc>(context)
        .add(UpdateNotesEvent(notesModel: notesModel));
    // var data = notesList
    //     .where((element) => element.userId == widget.notes!.userId)
    //     .indexed;
    // log("this is updated data message $data");
  }

  addNote() {
    NotesModel notesModel = NotesModel(
      id: const Uuid().v1(),
      userid: "deep34@gmail.com",
      title: titleCtrl.text.trim(),
      content: contentCtrl.text.trim(),
      date: DateTime.now(),
    );

    BlocProvider.of<NotesBloc>(context, listen: false)
        .add(AddNotesEvent(addNotes: notesModel));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.isUpdate
            ? const Text("Update Notes")
            : const Text("Add new Notes"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          TextField(
            controller: titleCtrl,
            onSubmitted: (newTitle) {
              setState(() {});
              focusNode.requestFocus();
            },
            onChanged: (value) {
              if (value.isNotEmpty) {
                context
                    .read<NotesBloc>()
                    .add(AddFloationgButtionEvent(istitle: true));
              } else {
                context
                    .read<NotesBloc>()
                    .add(AddFloationgButtionEvent(istitle: false));
              }
            },
            decoration: const InputDecoration(
                hintText: "Title",
                hintStyle: TextStyle(
                  fontSize: 22,
                ),
                border: InputBorder.none),
          ),
          Expanded(
            child: TextField(
              maxLines: null,
              focusNode: focusNode,
              controller: contentCtrl,
              decoration: const InputDecoration(
                  hintText: "Content",
                  hintStyle: TextStyle(
                    fontSize: 12,
                  ),
                  border: InputBorder.none),
            ),
          ),
        ]),
      ),
      floatingActionButton: BlocBuilder<NotesBloc, NotesState>(
        builder: (context, state) {
          if (state.isTitle) {
            return FloatingActionButton(
              onPressed: () {
                if (widget.isUpdate) {
                  updateNote();
                  Navigator.pop(context);
                } else {
                  addNote();
                  Navigator.pop(context);
                }
              },
              child: const Icon(Icons.done),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
