import 'package:first_desktop_app/models/note.dart';
import 'package:first_desktop_app/models/note_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:provider/provider.dart';

class EditingNotePage extends StatefulWidget {
  final Note? note;
  const EditingNotePage({super.key, this.note});

  @override
  State<EditingNotePage> createState() => _EditingNotePageState();
}

class _EditingNotePageState extends State<EditingNotePage> {
  final QuillController _quillController = QuillController.basic();
  final TextEditingController _titleController = TextEditingController();

  // Create Note
  void createNote(String title, String text) {
    // Add to DB
    context.read<NoteDatabase>().addNote(title, text);
  }

  // Update Note
  void updateNote(int id, String newTitle, String newText) {
    context.read<NoteDatabase>().updateNote(id, newTitle, newText);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.note != null) {
      String existingText = widget.note!.text;
      _titleController.text =
          widget.note!.title == "No Title" ? "" : widget.note!.title;
      _quillController.document = Document.fromJson([
        {'insert': existingText}
      ]);
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade100,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (_quillController.document.toPlainText() != "" ||
                _titleController.text != "") {
              if (widget.note == null) {
                createNote(
                  _titleController.text == ""
                      ? "No Title"
                      : _titleController.text,
                  _quillController.document.toPlainText(),
                );
              } else {
                updateNote(
                  widget.note!.id,
                  _titleController.text == ""
                      ? "No Title"
                      : _titleController.text,
                  _quillController.document.toPlainText(),
                );
              }
            }
            Navigator.pop(context);
          },
        ),
        title: TextField(
          controller: _titleController,
          textAlignVertical: TextAlignVertical.top,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "(No title)",
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              // padding: const EdgeInsets.only(bottom: 25),
              child: QuillToolbar.simple(
                configurations: QuillSimpleToolbarConfigurations(
                  controller: _quillController,
                  showSearchButton: false,
                  showLink: false,
                  showQuote: false,
                  showHeaderStyle: false,
                  multiRowsDisplay: false,
                  showDividers: true,
                  color: Colors.deepPurple.shade100,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: Container(
              width: MediaQuery.of(context).size.width > 1500
                  ? 1500
                  : MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 25, top: 25, right: 25),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                color: Colors.grey.shade200,
              ),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: QuillEditor.basic(
                  configurations: QuillEditorConfigurations(
                    controller: _quillController,
                    showCursor: true,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}