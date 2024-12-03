import 'dart:convert';
import 'dart:developer';

import 'package:pagel/model/notes_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static String _baseUrl = "https://notes-backend-wj58.onrender.com/notes";

  static Future<void> showDataApi(NotesModel notesModel) async {
    var response = await http.get(Uri.parse(_baseUrl));
    var decodeData = jsonDecode(response.body);
  }

  static Future<void> addDataApi(NotesModel notesModel) async {
    Uri requestUri = Uri.parse(_baseUrl + "/add");
    var response = await http.post(requestUri, body: notesModel.toMap());
    var decodeData = jsonDecode(response.body);
  }

  static Future<void> deleteDataApi(NotesModel notesModel) async {
    Uri requestUri = Uri.parse(_baseUrl + "/delete");
    var response = await http.delete(requestUri, body: notesModel.toMap());
    var decodeData = jsonDecode(response.body);
  }

  static Future<void> updateDataApi(NotesModel notesModel) async {
    Uri reqestUri = Uri.parse(_baseUrl + "/update");
    log(notesModel.toMap().toString());
    var response = await http.put(reqestUri, body: notesModel.toMap());
    var decodeData = jsonDecode(response.body);
  }
}
