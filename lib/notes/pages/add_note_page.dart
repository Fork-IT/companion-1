import 'package:flutter/material.dart';
import '../db/database_provider.dart';
import '../models/note.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({Key? key}) : super(key: key);

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  late String title;
  late String body;
  late DateTime date;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  addNote(NoteModel note) {
    DatabaseProvider.db.addNewNote(note);
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.cyan.shade600,
          icon: const Icon(Icons.save),
          label: Text('SAVE'),
          onPressed: () async {
            setState(() {
              title = titleController.text;
              body = descController.text;
              date = DateTime.now();
            });

            NoteModel note = NoteModel(
              title: title,
              body: body,
              creationDate: date,
            );
            await addNote(note);
            // ignore: use_build_context_synchronously
            Navigator.pop(context);
          }),
      appBar: AppBar(
        title: const Text('Create Note'),
        backgroundColor: Colors.cyan,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 18, right: 24, left: 24),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: 'Title Goes Here',
                  border: InputBorder.none,
                ),
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: descController,
                keyboardType: TextInputType.multiline,
                maxLines: 100,
                decoration: const InputDecoration(
                  hintText: 'Write Description.....',
                  border: InputBorder.none,
                ),
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
