import 'dart:convert';

import 'package:api_consuming_flutter_application/models/api_response.dart';
import 'package:api_consuming_flutter_application/models/notes_for_listing.dart';
import 'package:http/http.dart' as http;

class NotesService{

static const API = 'http://api.notes.programmingaddict.com/notes';
static const headers = {
  'apiKey' : '3d86e02a-6205-4fff-bb74-37c6f167dd63'
};
Future<APIResponce<List<NoteForListing>>> getNotesList(){
  return http.get(API ,headers: headers)
  .then((data) {
    if(data.statusCode == 200)
    {
      final jsonData = json.decode(data.body);
      final notes = <NoteForListing> [];
      for(var item in jsonData)
      {
        final note = NoteForListing(
          noteId: item['noteID'],
          noteTitle: item['noteTitle'],
          createDateTime: DateTime.parse(item['createDateTime']),
          latestEditDateTime: item['latestEditorTime'] != null //this condition is placed to check wether the responce date is null or not ? : are used for if else
                                 ? DateTime.parse(item['latestEditorTime']) : null,    
        );
        notes.add(note);
      }
      return APIResponce<List<NoteForListing>>(data: notes,);
    }
      return APIResponce<List<NoteForListing>>(error: true,errorMessage: 'An Error Occured');

  }).catchError((_)=>APIResponce<List<NoteForListing>>(error: true,errorMessage: 'An Error Occured'));

  }
}