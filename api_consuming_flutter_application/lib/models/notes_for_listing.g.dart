// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes_for_listing.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoteForListing _$NoteForListingFromJson(Map<String, dynamic> json) {
  return NoteForListing(
    noteId: json['noteId'] as String,
    noteTitle: json['noteTitle'] as String,
    createDateTime: json['createDateTime'] == null
        ? null
        : DateTime.parse(json['createDateTime'] as String),
    latestEditDateTime: json['latestEditDateTime'] == null
        ? null
        : DateTime.parse(json['latestEditDateTime'] as String),
  );
}

Map<String, dynamic> _$NoteForListingToJson(NoteForListing instance) =>
    <String, dynamic>{
      'noteId': instance.noteId,
      'noteTitle': instance.noteTitle,
      'createDateTime': instance.createDateTime?.toIso8601String(),
      'latestEditDateTime': instance.latestEditDateTime?.toIso8601String(),
    };
