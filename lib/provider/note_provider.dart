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
}