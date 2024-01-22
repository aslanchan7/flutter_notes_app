import 'package:first_desktop_app/models/note.dart';
import 'package:first_desktop_app/models/note_database.dart';
import 'package:first_desktop_app/pages/editing_note_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
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

  // Truncate Note Title
  String truncate(String s) {
    if (s.length >= 15) {
      String returnString = "";
      for (var i = 0; i < 15; i++) {
        returnString += s[i];
      }
      return "$returnString...";
    } else {
      return s;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              Container(
                width: 200,
                child: Card(
                  child: InkWell(
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
              PopupMenuButton(
                iconSize: kDefaultIconSize,
                onSelected: (value) {
                  if (value == "Delete") {
                    deleteNote(widget.note.id);
                  }
                },
                itemBuilder: (context) => <PopupMenuEntry>[
                  const PopupMenuItem(
                    value: "Delete",
                    child: Text("Delete"),
                  ),
                ],
              )
            ],
          ),
        ),
        Text(truncate(widget.note.title)),
      ],
    );
  }
}

class NoteCardList extends StatefulWidget {
  final Note note;
  const NoteCardList({super.key, required this.note});

  @override
  State<NoteCardList> createState() => NoteCardListState();
}

class NoteCardListState extends State<NoteCardList> {
  // Delete Note
  void deleteNote(int id) {
    context.read<NoteDatabase>().deleteNote(id);
  }

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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditingNotePage(
                note: widget.note,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(widget.note.title),
              ),
              IconButton(
                onPressed: () {
                  deleteNote(widget.note.id);
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
