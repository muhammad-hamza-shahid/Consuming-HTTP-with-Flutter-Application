import 'package:api_consuming_flutter_application/models/api_response.dart';
import 'package:api_consuming_flutter_application/models/notes_for_listing.dart';
import 'package:api_consuming_flutter_application/services/notes_service.dart';
import 'package:api_consuming_flutter_application/views/note_delete.dart';
import 'package:api_consuming_flutter_application/views/note_modify.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  NotesService get service => GetIt.I<NotesService>();
  APIResponce<List<NoteForListing>> _apiResponce;
  bool _isLoading = false;

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  @override
  void initState() {
    _fetchNotes();
    super.initState();
  }

  _fetchNotes() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponce = await service.getNotesList();
    
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('List of notes')),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => NoteModify()))
                .then((_){
                  _fetchNotes();
                });
          },
          child: Icon(Icons.add),
        ),
        body: Builder(
          builder: (_) {
            if (_isLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (_apiResponce.error) {
              return Center(child: Text(_apiResponce.errorMessage));
            }

            return ListView.separated(
              separatorBuilder: (_, __) =>
                  Divider(height: 1, color: Colors.green),
              itemBuilder: (_, index) {
                return Dismissible(
                  key: ValueKey(_apiResponce.data[index].noteId),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) {},
                  confirmDismiss: (direction) async {
                    final result = await showDialog(
                        context: context, builder: (_) => NoteDelete());
                    print(result);
                    return result;
                  },
                  background: Container(
                    color: Colors.red,
                    padding: EdgeInsets.only(left: 16),
                    child: Align(
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  child: ListTile(
                    title: Text(
                      _apiResponce.data[index].noteTitle,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    subtitle: Text(
                        'Last edited on ${formatDateTime(_apiResponce.data[index].latestEditDateTime ?? _apiResponce.data[index].createDateTime)}'),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => NoteModify(
                                noteID: _apiResponce.data[index].noteId,
                              ))).then((value) {
                                _fetchNotes();
                              });
                    },
                  ),
                );
              },
              itemCount: _apiResponce.data.length,
            );
          },
        ));
  }
}
