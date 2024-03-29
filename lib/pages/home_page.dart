import 'dart:ui';

import 'package:first_desktop_app/models/note.dart';
import 'package:first_desktop_app/models/note_database.dart';
import 'package:first_desktop_app/models/notes_view_provider.dart';
import 'package:first_desktop_app/pages/editing_note_page.dart';
import 'package:first_desktop_app/widgets/note_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      backgroundColor: Theme.of(context).colorScheme.background,
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
                  child: Text(
                    "All Notes",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.60),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => toggleNotesView(),
                  icon: isCurrentNotesGridView
                      ? Icon(
                          Icons.grid_on,
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(0.60),
                        )
                      : Icon(
                          Icons.list_alt,
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(0.60),
                        ),
                  tooltip: "Change Notes View",
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
