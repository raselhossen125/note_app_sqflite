// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures, avoid_print, unused_local_variable, sized_box_for_whitespace, unnecessary_cast

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:note_app_sqflite/pages/new_note_page.dart';
import 'package:note_app_sqflite/provider/note_provider.dart';
import 'package:provider/provider.dart';

class NoteListPage extends StatefulWidget {
  static const routeName = '/note-list';

  @override
  State<NoteListPage> createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
  bool isDown = false;
  bool isInit = true;

  @override
  void didChangeDependencies() {
    if (isInit) Provider.of<NoteProvider>(context, listen: false).getAllNotes();
    isInit = false;
    super.didChangeDependencies();
  }

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
          child: Consumer<NoteProvider>(
            builder: (context, nProvider, child) => Provider.of<NoteProvider>(context, listen: false).noteList.isNotEmpty ? ListView.builder(
              padding: EdgeInsets.all(0),
              itemCount: nProvider.noteList.length,
              itemBuilder: (context, index) {
                final noteM = nProvider.noteList[index];
                return Padding(
                  padding: const EdgeInsets.only(
                      top: 0, left: 10, right: 10, bottom: 8),
                  child: Container(
                      height: 81,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          color: Colors.grey.withOpacity(0.2)),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 10, top: 5, bottom: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    noteM.title == null || noteM.title!.isEmpty
                                        ? 'No title here'
                                        : noteM.title.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    noteM.note,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 1),
                                  Row(
                                    children: [
                                      Text(
                                        DateFormat('MMM dd yyyy  ||  hh mm a').format(DateTime.parse(noteM.time)),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 81,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  nProvider.deleteNote(noteM.id!);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          )
                        ],
                      )),
                );
              },
            ) : Center(child: Text('No note added yet..')),
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
