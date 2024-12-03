import 'dart:convert';

import 'dart:developer';

import 'package:pagel/data/provider_data/notes_provider.dart';
import 'package:pagel/model/notes_model.dart';
import 'package:pagel/screen/create_note_screen.dart';

class NotesRepo {
  final NotesProvider notesProvider;
  NotesRepo(this.notesProvider);
  Future<List<NotesModel>> getData() async {
    String apiData = await notesProvider.getApiData();
    List list = await jsonDecode(apiData);
    // List<Map<String, dynamic>> list =
    //     List<Map<String, dynamic>>.from(jsonDecode(apiData));
    List<NotesModel> notesmodelList =
        list.map((item) => NotesModel.fromMap(item)).toList();
    notesList = notesmodelList;

    return notesmodelList;
  }
}
