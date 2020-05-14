
import 'package:api_consuming_flutter_application/models/notes_for_listing.dart';
import 'package:api_consuming_flutter_application/views/note_delete.dart';
import 'package:api_consuming_flutter_application/views/note_modify.dart';
import 'package:flutter/material.dart';


class NoteList extends StatelessWidget {


  final notes=[
    new NoteForListing(
      noteId:"1",
      createDateTime:DateTime.now(),
      latestEditDateTime: DateTime.now(),
      noteTitle : "Note 1"
    ),
    new NoteForListing(
      noteId:"2",
      createDateTime:DateTime.now(),
      latestEditDateTime: DateTime.now(),
      noteTitle : "Note 2"
    ),
    new NoteForListing(
      noteId:"3",
      createDateTime:DateTime.now(),
      latestEditDateTime: DateTime.now(),
      noteTitle : "Note 3"
    ),
  ];

  String formatDateTime(DateTime dateTime)
  {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List of notes')),
      
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).
          push(MaterialPageRoute(builder: (_)=>NoteModify()));

        },
        child: Icon(Icons.add),
      ),
      body: ListView.separated(
        separatorBuilder: (_,__) => Divider(height: 1, color : Colors.green),
        itemBuilder: (_,index){
          return Dismissible( 
                key : ValueKey(notes[index].noteId),
                direction:DismissDirection.startToEnd,
               onDismissed: (direction){
               },
               confirmDismiss: (direction) async {
                 final result = await showDialog(
                   context: context,
                   builder: (_)=>NoteDelete()
                  );
                  print(result);
                  return result;
               },
              
              
                
             child: ListTile(
                  title: Text(
                    notes[index].noteTitle,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  subtitle: Text('Last edited on ${formatDateTime(notes[index].latestEditDateTime)}'),
                  onTap:(){
                    Navigator.of(context).
                push(MaterialPageRoute(builder: (_)=>NoteModify(noteID: notes[index].noteId,)));
                  } ,
              ),
          );
        },

        itemCount: notes.length,

      ),
    );
  }
}