import 'package:json_annotation/json_annotation.dart';

part 'note_for_listing.g.dart';

@JsonSerializable()
class NoteForListing{
  String noteId;
  String noteTitle;
  DateTime createDateTime;
  DateTime latestEditDateTime;

  NoteForListing({
    this.noteId,
    this.noteTitle,
    this.createDateTime,
    this.latestEditDateTime
  }) ;

  factory NoteForListing.fromJson(Map<String,dynamic> item){
     return NoteForListing(
          noteId: item['noteID'],
          noteTitle: item['noteTitle'],
          createDateTime: DateTime.parse(item['createDateTime']),
          latestEditDateTime: item['latestEditorTime'] != null //this condition is placed to check wether the responce date is null or not ? : are used for if else
                                 ? DateTime.parse(item['latestEditorTime']) : null,    
        );
  }
  
}