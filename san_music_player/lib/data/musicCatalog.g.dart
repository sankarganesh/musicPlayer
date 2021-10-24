// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'musicCatalog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MusicDataModel _$MusicCatalogFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['id']);
  return MusicDataModel(
    id: json['id'] as String,
    title: json['title'] as String,
    album: json['album'] as String,
    artist: json['artist'] as String,
    genre: json['genre'] as String,
    source: json['source'] as String,
    image: json['image'] as String,
    duration: json['duration'] as int,
  );
}

Map<String, dynamic> _$MusicCatalogToJson(MusicDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'album': instance.album,
      'artist': instance.artist,
      'genre': instance.genre,
      'source': instance.source,
      'image': instance.image,
      'duration': instance.duration,
    };
