import 'dart:convert';

import 'package:api_consuming_flutter_application/models/api_response.dart';
import 'package:api_consuming_flutter_application/models/note.dart';
import 'package:api_consuming_flutter_application/models/notes_for_listing.dart';
import 'package:http/http.dart' as http;

class NotesService {
  static const API = 'http://api.notes.programmingaddict.com';
  static const headers = {'apiKey': '3d86e02a-6205-4fff-bb74-37c6f167dd63'};
  Future<APIResponce<List<NoteForListing>>> getNotesList() {
    return http.get(API + '/notes', headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final notes = <NoteForListing>[];
        for (var item in jsonData) {
          notes.add(NoteForListing.fromJson(item));
        }
        return APIResponce<List<NoteForListing>>(
          data: notes,
        );
      }
      return APIResponce<List<NoteForListing>>(
          error: true, errorMessage: 'An Error Occured');
    }).catchError((_) => APIResponce<List<NoteForListing>>(
        error: true, errorMessage: 'An Error Occured'));
  }

  Future<APIResponce<Note>> getNote(String noteID) {
    return http.get(API + '/notes/' + noteID, headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return APIResponce<Note>(data: Note.fromJson(jsonData),);
      }
      return APIResponce<Note>(error: true, errorMessage: 'An Error Occured');
    }).catchError((_) =>
        APIResponce<Note>(error: true, errorMessage: 'An Error Occured'));
  }
}
