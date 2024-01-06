import 'package:flutter/material.dart';

class NoteCard extends StatefulWidget {
  const NoteCard({super.key});

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  @override
  Widget build(BuildContext context) {
    // return Container(
    //   decoration: BoxDecoration(
    //       color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10)),
    //   margin: const EdgeInsets.all(4),
    // );
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
