import 'package:flutter/cupertino.dart';

class NoteManipulation {
  String noteTitle;
  String noteContent;

  NoteManipulation({@required this.noteTitle,@required this.noteContent});

  Map<String,dynamic> toJson() {
    return {
      "noteTitle" : noteTitle,
      "noteContent" : noteContent
    };
  }

}
