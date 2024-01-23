import 'package:first_desktop_app/models/note.dart';
import 'package:first_desktop_app/models/user_settings.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase extends ChangeNotifier {
  static late Isar isar;

  /// Initialize database
  ///
  /// This opens the database
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar =
        await Isar.open([NoteSchema, UserSettingsSchema], directory: dir.path);
  }

  // List of notes
  final List<Note> currentNotes = [];

  /// Create note and writes it to the database
  ///
  /// [title] Title of the new note.
  /// [textFromUser] Content of the new note.
  Future<void> addNote(String title, String textFromUser) async {
    Note newNote = Note();
    newNote.title = title;
    newNote.text = textFromUser;
    newNote.lastModified = DateTime.now();
    // Save the newNote to the database
    await isar.writeTxn(() => isar.notes.put(newNote));

    await fetchNotes();
  }

  /// Read notes from the database
  Future<void> fetchNotes() async {
    List<Note> fetchedNotes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchedNotes);
    sortByLastModified(currentNotes, 0, currentNotes.length - 1);
    notifyListeners();
  }

  /// Updates note to database
  ///
  /// [id] ID of the note.
  /// [newTitle] The updated title of the edited note.
  /// [newText] The updated content of the edited note.
  Future<void> updateNote(int id, String newTitle, String newText) async {
    final existingNote = await isar.notes.get(id);
    if (existingNote != null) {
      existingNote.title = newTitle;
      existingNote.text = newText;
      existingNote.lastModified = DateTime.now();
      await isar.writeTxn(() => isar.notes.put(existingNote));
      await fetchNotes();
    }
  }

  /// Deletes note based on [id]
  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
    await fetchNotes();
  }

  /// Sorts notes with most recently modified first.
  ///
  /// [notes] List of notes to sort.
  void sortByLastModified(List<Note> notes, int beginIndex, int endIndex) {
    if (beginIndex < endIndex) {
      int partitionIndex = partition(notes, beginIndex, endIndex);

      sortByLastModified(notes, beginIndex, partitionIndex - 1);
      sortByLastModified(notes, partitionIndex + 1, endIndex);
    }
  }

  int partition(List<Note> notes, int beginIndex, int endIndex) {
    DateTime pivotDateTime = notes[endIndex].lastModified;
    int i = beginIndex - 1;

    for (var j = beginIndex; j < endIndex; j++) {
      if (notes[j].lastModified.isAfter(pivotDateTime)) {
        i++;

        Note swapTemp = notes[i];
        notes[i] = notes[j];
        notes[j] = swapTemp;
      }
    }

    Note swapTemp = notes[i + 1];
    notes[i + 1] = notes[endIndex];
    notes[endIndex] = swapTemp;

    return i + 1;
  }
}
