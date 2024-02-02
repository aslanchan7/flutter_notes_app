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
                  elevation: 0,
                  color: Theme.of(context).colorScheme.surfaceVariant,
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
                iconColor: Theme.of(context)
                    .colorScheme
                    .onBackground
                    .withOpacity(0.60),
                iconSize: kDefaultIconSize,
                onSelected: (value) {
                  if (value == "Delete") {
                    deleteNote(widget.note.id);
                  }
                },
                itemBuilder: (context) => <PopupMenuEntry>[
                  PopupMenuItem(
                    value: "Delete",
                    child: Text(
                      "Delete",
                      style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(0.60)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Container(
          width: 150,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              widget.note.title,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF8b8b8b),
              ),
            ),
          ),
        ),
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
              Container(
                width: 300,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.note.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Color(0xFF8b8b8b)),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  deleteNote(widget.note.id);
                },
                icon: const Icon(
                  Icons.delete,
                  color: Color(0xFF8b8b8b),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
