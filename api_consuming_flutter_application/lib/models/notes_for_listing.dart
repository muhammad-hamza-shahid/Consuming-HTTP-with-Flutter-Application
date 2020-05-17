import 'package:json_annotation/json_annotation.dart';

part 'notes_for_listing.g.dart';

//flutter packages pub run build_runner build is the command for run individually
//flutter packages pub run build_runner watch is the command for run continously 
//you just have to save the file after importing and giving file nam in part and the adding the annotation of @JsonSerializable()


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