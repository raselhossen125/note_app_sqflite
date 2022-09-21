// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:note_app_sqflite/pages/new_note_page.dart';

class NoteListPage extends StatefulWidget {
  static const routeName = '/note-list';

  @override
  State<NoteListPage> createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
  bool isDown = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              floating: true,
              snap: true,
              centerTitle: true,
              toolbarHeight: 70,
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                'Your Note',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            )
          ];
        },
        body: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (notification.direction == ScrollDirection.forward) {
              if (isDown)
                setState(() {
                  isDown = false;
                });
            } else if (notification.direction == ScrollDirection.reverse) {
              if (!isDown)
                setState(() {
                  isDown = true;
                });
            }
            return true;
          },
          child: ListView.builder(
            padding: EdgeInsets.all(0),
            itemCount: 50,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 60,
                  color: Colors.grey.withOpacity(0.2),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: isDown
          ? SizedBox(
              height: 60,
              child: FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                onPressed: () {
                  Navigator.of(context).pushNamed(NewNotePage.routeName);
                },
                child: Icon(Icons.add),
              ),
            )
          : SizedBox(
              height: 60,
              child: FloatingActionButton.extended(
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                onPressed: () {
                  Navigator.of(context).pushNamed(NewNotePage.routeName);
                },
                label: Row(
                  children: [
                    Icon(Icons.add),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Add Note',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
