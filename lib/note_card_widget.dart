import 'package:first_desktop_app/models/note.dart';
import 'package:first_desktop_app/models/note_database.dart';
import 'package:first_desktop_app/pages/editing_note_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NoteCardGrid extends StatefulWidget {
  final Note note;
  const NoteCardGrid({super.key, required this.note});

  @override
  State<NoteCardGrid> createState() => _NoteCardGridState();
}

class _NoteCardGridState extends State<NoteCardGrid> {
  // Delete Note
  void deleteNote(int id) {
    context.read<NoteDatabase>().deleteNote(id);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            width: 200,
            child: Card(
              child: InkWell(
                onSecondaryTap: () {
                  deleteNote(widget.note.id);
                },
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditingNotePage(
                        note: widget.note,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        Text(widget.note.title),
      ],
    );
  }
}

class NoteCardList extends StatefulWidget {
  const NoteCardList({super.key});

  @override
  State<NoteCardList> createState() => NoteCardListState();
}

class NoteCardListState extends State<NoteCardList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(width: 0.5),
          // bottom: BorderSide(width: 0.5),
        ),
      ),
      child: InkWell(
        onTap: () {
          print("Hello World");
        },
        child: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text("Note Title"),
          ),
        ),
      ),
    );
  }
}
