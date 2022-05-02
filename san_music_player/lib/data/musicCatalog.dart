import 'package:json_annotation/json_annotation.dart';

part 'musicCatalog.g.dart';

/// Created by G29 as part of Open Source Assignment  on 02/05/2022.
///  A class which holds attributes of a Song
///  Some of the attributes are ID, Title, Album, ARTIST, Genre, Source, Image, Duration
///  Class holds fromJSON method to parse the JSON code

@JsonSerializable()
class MusicDataModel {
  MusicDataModel({
    this.id,
    this.title,
    this.album,
    this.artist,
    this.genre,
    this.source,
    this.image,
    this.duration,
  });

  @JsonKey(required: true)
  final String id;

  final String title;
  final String album;
  final String artist;
  final String genre;
  final String source;
  final String image;
  final int duration;

  // Using code generation here (just cause).
  factory MusicDataModel.fromJson(Map<String, dynamic> json) =>
      _$MusicCatalogFromJson(json);
}
