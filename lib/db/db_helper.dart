// ignore_for_file: depend_on_referenced_packages, unused_local_variable

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

  static Future<List<NoteModel>> getAllNotes() async {
    final db = await open();
    final List<Map<String, dynamic>> mapList = await db.query(tableNote);
    return List.generate(mapList.length, (index) => NoteModel.fromMap(mapList[index]));
  }

  static Future<int> deleteNote(int id) async{
    final db = await open();
    return db.delete(tableNote, where: '$tableNoteColId = ?', whereArgs: [id]);
  }
}