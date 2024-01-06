import 'package:flutter/material.dart';

class NoteCardGrid extends StatefulWidget {
  const NoteCardGrid({super.key});

  @override
  State<NoteCardGrid> createState() => _NoteCardGridState();
}

class _NoteCardGridState extends State<NoteCardGrid> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            width: 200,
            child: Card(
              child: InkWell(
                onTap: () {
                  print("Hello World");
                },
              ),
            ),
          ),
        ),
        Text("Note Title"),
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
