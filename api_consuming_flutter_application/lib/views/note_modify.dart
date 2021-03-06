import 'package:api_consuming_flutter_application/models/note.dart';
import 'package:api_consuming_flutter_application/models/note_insert.dart';
import 'package:api_consuming_flutter_application/services/notes_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class NoteModify extends StatefulWidget {
  final String noteID;
  NoteModify({this.noteID});

  @override
  _NoteModifyState createState() => _NoteModifyState();
}

class _NoteModifyState extends State<NoteModify> {
  bool get isEditing => widget.noteID != null;

  NotesService get notesService => GetIt.I<NotesService>();

  String errorMessage;
  Note note;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    if (isEditing) {
      setState(() {
        _isLoading = true;
      });
      notesService.getNote(widget.noteID).then((responce) {
        setState(() {
          _isLoading = false;
        });
        if (responce.error) {
          errorMessage = responce.errorMessage ?? 'An Error Occured';
        }
        note = responce.data;
        _titleController.text = note.noteTitle;
        _contentController.text = note.noteContent;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Note' : 'Create Note')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: <Widget>[
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(hintText: 'Note Title'),
                  ),
                  Container(
                    height: 8,
                  ),
                  TextField(
                    controller: _contentController,
                    decoration: InputDecoration(hintText: 'Note Content'),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 35,
                    child: RaisedButton(
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Theme.of(context).primaryColor,
                      onPressed: () async {
                        if (isEditing) {
                          //update in API
                          setState(() {
                            _isLoading = true;
                          });
                          final note = NoteManipulation(
                            noteTitle: _titleController.text,
                            noteContent: _contentController.text,
                          );

                          final result = await notesService.updateNote(widget.noteID,note);

                          setState(() {
                            _isLoading = false;
                          });
                          final title = 'done';
                          final text = result.error
                              ? (result.errorMessage ?? "An error ocured")
                              : 'Your note is updated';
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                      title: Text(title),
                                      content: Text(text),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text("Ok"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        )
                                      ])).then((data) {
                                        if(result.data){
                                          Navigator.of(context).pop();
                                        }
                                      });
                        } else {
                          //Create note in API
                          setState(() {
                            _isLoading = true;
                          });
                          final note = NoteManipulation(
                            noteTitle: _titleController.text,
                            noteContent: _contentController.text,
                          );

                          final result = await notesService.createNote(note);

                          setState(() {
                            _isLoading = false;
                          });
                          final title = 'done';
                          final text = result.error
                              ? (result.errorMessage ?? "An error ocured")
                              : 'Your note is created';
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                      title: Text(title),
                                      content: Text(text),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text("Ok"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        )
                                      ])).then((data) {
                                        if(result.data){
                                          Navigator.of(context).pop();
                                        }
                                      });
                        }
                       // Navigator.of(context).pop();
                      },
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
