import 'package:first_desktop_app/models/note.dart';
import 'package:first_desktop_app/models/user_settings.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class NotesViewProvider with ChangeNotifier {
  static late Isar isar;
  bool isCurrentNotesGridView = true;

  // Initialize
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = Isar.getInstance()!;
    if (await isar.userSettings.get(0) == null) {
      UserSettings newUserSettings = UserSettings()..isNotesGridView = true;

      // save the newNote to the database
      await isar.writeTxn(() => isar.userSettings.put(newUserSettings));
    }
  }

  // Read
  Future<void> readUserSettings() async {
    UserSettings? userSettings = await isar.userSettings.get(0);

    if (userSettings != null) {
      isCurrentNotesGridView = userSettings.isNotesGridView;
    }

    notifyListeners();
  }

  // Update
  Future<void> toggleNotesView() async {
    final userSettings = await isar.userSettings.get(0);
    if (userSettings != null) {
      userSettings.isNotesGridView = !isCurrentNotesGridView;
      await isar.writeTxn(() => isar.userSettings.put(userSettings));
      await readUserSettings();
    }
  }
}
