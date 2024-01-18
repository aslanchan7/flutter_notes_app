import 'dart:ui';

import 'package:first_desktop_app/models/note.dart';
import 'package:first_desktop_app/models/note_database.dart';
import 'package:first_desktop_app/models/notes_view_provider.dart';
import 'package:first_desktop_app/pages/editing_note_page.dart';
import 'package:first_desktop_app/note_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  // bool isCurrentNotesGridView = true; // Bug fix here

  // void toggleNotesView() {
  //   isCurrentNotesGridView = !isCurrentNotesGridView;
  //   setState(() {});
  // }

  void readNotes() {
    context.read<NoteDatabase>().fetchNotes();
  }

  void readUserSettings() {
    context.read<NotesViewProvider>().readUserSettings();
  }

  void toggleNotesView() {
    context.read<NotesViewProvider>().toggleNotesView();
  }

  @override
  void initState() {
    super.initState();

    readNotes();
    readUserSettings();
  }

  @override
  Widget build(BuildContext context) {
    // Note Database
    final noteDatabase = context.watch<NoteDatabase>();

    // Current Notes
    List<Note> currentNotes = noteDatabase.currentNotes;

    // User Settings Database
    final userSettings = context.watch<NotesViewProvider>();

    // Current Notes View
    bool isCurrentNotesGridView = userSettings.isCurrentNotesGridView;

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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
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
                IconButton(
                  onPressed: () => toggleNotesView(),
                  icon: isCurrentNotesGridView
                      ? const Icon(Icons.grid_on)
                      : const Icon(Icons.list_alt),
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
              child: isCurrentNotesGridView
                  ? GridView.builder(
                      itemCount: currentNotes.length,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        mainAxisSpacing: 50,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (context, index) {
                        // Get individual note
                        final note = currentNotes[index];

                        return NoteCardGrid(note: note);
                      },
                    )
                  : ListView.builder(
                      itemCount: currentNotes.length,
                      itemBuilder: (context, index) {
                        final note = currentNotes[index];

                        return NoteCardList(note: note);
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
