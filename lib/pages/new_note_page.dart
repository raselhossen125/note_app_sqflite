// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, unnecessary_null_comparison, unused_local_variable, use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:note_app_sqflite/pages/note_list_page.dart';
import 'package:note_app_sqflite/provider/note_provider.dart';
import 'package:provider/provider.dart';
import '../model/note_model.dart';
import '../until/helper_function.dart';

class NewNotePage extends StatelessWidget {
  static const routeName = '/new-note';

  bool noteValue = true;

  final titleController = TextEditingController();
  final noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.black,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'New Note',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            onPressed: noteValue
                ? () {
                    _saveBtn(context);
                  }
                : null,
            icon: Icon(
              Icons.check_outlined,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColor,
                  fontSize: 24,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Title',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                    fontSize: 24,
                  ),
                ),
              ),
              TextFormField(
                controller: noteController,
                maxLines: 60,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Do something...',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveBtn(BuildContext context) async {
    if (noteController.text==null || noteController.text.isEmpty) {
      showMsg(context, 'Please write do something...');
      return;
    }
    if (noteController.text != null || noteController.text.isNotEmpty) {
      final noteModel = NoteModel(
        title: titleController.text,
        note: noteController.text,
        time: DateTime.now().toString(),
      );
      print(noteModel.toString());
      final status = await Provider.of<NoteProvider>(context, listen: false)
          .addNewNote(noteModel);
      if (status) {
        Navigator.of(context).pushReplacementNamed(NoteListPage.routeName);
        print(noteModel.toString());
      }
    }
  }
}
