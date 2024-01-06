import 'dart:ui';

import 'package:first_desktop_app/editing_note_page.dart';
import 'package:first_desktop_app/note_card_widget.dart';
import 'package:flutter/material.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Add note with floating action button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EditingNotePage(),
            ),
          );
        },
        tooltip: "Add Note",
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 29),
            alignment: Alignment.centerLeft,
            height: 50,
            child: const Text(
              "All Notes",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
              // Either grid view or list view (yet to decide)
              child: GridView.builder(
                itemCount: 12,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  mainAxisSpacing: 50,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) => NoteCard(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
