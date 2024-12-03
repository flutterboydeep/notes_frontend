import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pagel/data/repo/notes_repo.dart';
import 'package:pagel/model/notes_model.dart';
import 'package:pagel/screen/create_note_screen.dart';
import 'package:pagel/services/api_services.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NotesRepo notesRepo;
  NotesBloc(this.notesRepo) : super(NotesState()) {
    on<AddNotesEvent>(addNoteEvent);
    on<ShowAllNotesEvent>(showAllNotesEvent);
    on<AddFloationgButtionEvent>(addFloationgButtionEvent);
    on<UpdateNotesEvent>(updateNotesEvent);
    on<DeleteNotesEvent>(deleteNotesEvent);
  }

  addNoteEvent(AddNotesEvent event, Emitter<NotesState> emit) {
    ApiServices.addDataApi(event.addNotes);
    notesList.add(event.addNotes);

    // emit(state.copyWith(notesList: notesList, status: Status.loaded));
  }

  updateNotesEvent(UpdateNotesEvent event, Emitter<NotesState> emit) async {
    ApiServices.updateDataApi(event.notesModel);
    log(event.notesModel.toMap().toString());
    var index =
        notesList.indexWhere((element) => element.id == event.notesModel.id);
    notesList[index] = event.notesModel;

    emit(state.copyWith(notesList: notesList, status: Status.loaded));
  }

  deleteNotesEvent(DeleteNotesEvent event, Emitter<NotesState> emit) {
    var index =
        notesList.indexWhere((element) => element.id == event.notesModel.id);

    var data = state.notesList.removeAt(index);
    ApiServices.deleteDataApi(event.notesModel);
    emit(state.copyWith(notesList: notesList, status: Status.loaded));
  }

  addFloationgButtionEvent(
      AddFloationgButtionEvent event, Emitter<NotesState> emit) {
    emit(state.copyWith(isTitle: event.istitle, status: Status.loaded));
  }

  showAllNotesEvent(ShowAllNotesEvent event, Emitter<NotesState> emit) async {
    // log("noteslis is = ${notesRepo.getData()}");
    List<NotesModel> list = await notesRepo.getData();
    log("This is notes title ${list[0].title}");
    emit(state.copyWith(
        notesList: await notesRepo.getData(), status: Status.loaded));
  }
}
