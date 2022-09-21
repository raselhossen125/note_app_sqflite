// ignore_for_file: depend_on_referenced_packages

import 'package:sqflite/sqflite.dart';
import '../model/note_model.dart';
import 'package:path/path.dart';

class DBHelper {
  static const createTableNote = '''
  create table $tableNote(
  $tableNoteColId integer primary key,
  $tableNoteColTitle text,
  $tableNoteColNote text,
  $tableNoteColTime text
  )
  ''';

  static Future<Database> open() async{
    final rootPath = await getDatabasesPath();
    final dbPath = join(rootPath, 'note.db');

    return openDatabase(dbPath, version: 1, onCreate: (db, version) {
      db.execute(createTableNote);
    });
  }

  static Future<int> insertNote(NoteModel noteModel) async{
    final db = await open();
    return db.insert(tableNote, noteModel.toMap());
  }
}