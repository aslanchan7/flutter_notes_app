import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class EditingNotePage extends StatefulWidget {
  const EditingNotePage({super.key});

  @override
  State<EditingNotePage> createState() => _EditingNotePageState();
}

class _EditingNotePageState extends State<EditingNotePage> {
  final QuillController _controller = QuillController.basic();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade100,
        title: const TextField(
          textAlignVertical: TextAlignVertical.top,
          decoration: InputDecoration(
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
                  controller: _controller,
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
                    controller: _controller,
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
