import 'package:flutter/cupertino.dart';
import 'package:note_app_sqflite/db/db_helper.dart';
import '../model/note_model.dart';

class NoteProvider extends ChangeNotifier {
  List<NoteModel> noteList = [];

  Future<bool> addNewNote(NoteModel noteModel) async{
    final rowId = await DBHelper.insertNote(noteModel);
    if (rowId > 0) {
      noteModel.id = rowId;
      noteList.add(noteModel);
      return true;
    }
    return false;
  }

  getAllNotes() async{
    DBHelper.getAllNotes().then((value) {
      noteList = value;
      notifyListeners();
    });
  }

  updateNote(NoteModel noteModel) async{
    DBHelper.updateNote(noteModel);
    notifyListeners();
  }

  deleteNote(int id) async{
    final rowId = await DBHelper.deleteNote(id);
    if (rowId > 0) {
      noteList.removeWhere((element) => element.id == id);
      notifyListeners();
    }
  }
}