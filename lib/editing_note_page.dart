import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class EditingNotePage extends StatefulWidget {
  const EditingNotePage({super.key});

  @override
  State<EditingNotePage> createState() => _EditingNotePageState();
}

class _EditingNotePageState extends State<EditingNotePage> {
  QuillController _controller = QuillController.basic();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          QuillToolbar.simple(
            configurations: QuillSimpleToolbarConfigurations(
              controller: _controller,
              showSearchButton: false,
              showLink: false,
              showQuote: false,
              showHeaderStyle: false,
              multiRowsDisplay: false,
              showDividers: true,
            ),
          ),
          QuillEditor.basic(
            configurations: QuillEditorConfigurations(
              controller: _controller,
              padding: const EdgeInsets.only(left: 25),
              showCursor: true,
            ),
          ),
        ],
      ),
    );
  }
}
