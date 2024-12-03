part of 'notes_bloc.dart';

@immutable
sealed class NotesEvent {}

class ShowAllNotesEvent extends NotesEvent {}

class AddFloationgButtionEvent extends NotesEvent {
  final istitle;

  AddFloationgButtionEvent({required this.istitle});
}

class AddNotesEvent extends NotesEvent {
  final NotesModel addNotes;

  AddNotesEvent({required this.addNotes});
}

class DeleteNotesEvent extends NotesEvent {
  final NotesModel notesModel;
  DeleteNotesEvent({required this.notesModel});
}

class UpdateNotesEvent extends NotesEvent {
  final NotesModel notesModel;
  UpdateNotesEvent({required this.notesModel});
}
