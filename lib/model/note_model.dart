
const String tableNote = 'tbl_note';
const String tableNoteColId = 'id';
const String tableNoteColTitle = 'title';
const String tableNoteColNote = 'note';
const String tableNoteColTime = 'time';
// const String tableNoteColIsFavourite = 'isFav';

class NoteModel {
  int? id;
  String? title;
  String note;
  String time;
  // bool isFav;

  NoteModel({
    this.id,
    this.title,
    required this.note,
    required this.time,
    // this.isFav = false,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      tableNoteColTitle: title,
      tableNoteColNote: note,
      tableNoteColTime: time,
      // tableNoteColIsFavourite: isFav,
    };
    if (id != null) {
      map[tableNoteColId] = id;
    }
    return map;
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) => NoteModel(
        id: map[tableNoteColId],
        title: map[tableNoteColTitle],
        note: map[tableNoteColNote],
        time: map[tableNoteColTime],
        // isFav: map[tableNoteColIsFavourite],
  );

  @override
  String toString() {
    return 'NoteModel{id: $id, title: $title, note: $note}';
  }
}