import 'package:audio_service/audio_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:san_music_player_san/data/musicCatalog.dart';
import 'package:san_music_player_san/pojo/catalog.dart';
import 'package:san_music_player_san/utils/parseDuration.dart';

import 'home.dart';

class CatalogList extends StatelessWidget {
  final List<MusicDataModel> data;
  final int index;

  const CatalogList(this.data, this.index);

  @override
  Widget build(BuildContext context) {
    LinearGradient gradient = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.centerRight,
        colors: [
          Colors.orange,
          Colors.white,
        ]);
    double scale = 1;

    return StreamBuilder<MediaItem>(
      stream: AudioService.currentMediaItemStream,
      builder: (context, snapshot) {
        return Card(
            elevation: 8,
            shadowColor: Colors.red,
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.red, width: 1)),
            child: Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                decoration: BoxDecoration(
                  gradient: gradient,
                ),
                child: ListTile(
                    selected: snapshot.hasData
                        ? (snapshot.data.id == data[index].id)
                        : false,
                    leading: AspectRatio(
                      aspectRatio: 1.0,
                      child: CachedNetworkImage(
                        imageUrl: data[index].image,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    title: Transform.scale(
                        scale: scale,
                        child: Container(
                          child: Text(
                            data[index].title,
                          ),
                        )),
                    subtitle: Text(data[index].artist),
                    trailing: Container(
                        child: new Column(
                      children: [
                        IconButton(
                          icon: Icon(Icons.timelapse_sharp),
                        ),
                        Text(
                          songDuration(Duration(seconds: data[index].duration)),
                          style: new TextStyle(fontSize: 5),
                        )
                      ],
                    )),
                    onTap: () {
                      playAudioByIndex(context, index);
                    })));
      },
    );
  }
}

void playAudioByIndex(BuildContext context, int index,
    [Duration position]) async {
  final catalog = Provider.of<SongDetailModel>(context, listen: false);
  final id = catalog.items[index].id;
  if (AudioService.running) {
    // The service is already running, hence we begin playback.
    AudioService.playFromMediaId(id);
  } else {
    // Start background music playback.
    if (await AudioService.start(
      backgroundTaskEntrypoint: backgroundTaskEntryPoint,
      androidNotificationChannelName: 'Playback',
      androidNotificationColor: 0xFF2196f3,
      androidStopForegroundOnPause: true,
      androidEnableQueue: true,
    )) {
      // Process for setting up the queue

      // 1.Convert music catalog to mediaitem data type.
      final queue = catalog.items.map((catalog) {
        return MediaItem(
          id: catalog.id,
          album: catalog.album,
          title: catalog.title,
          artist: catalog.artist,
          duration: Duration(seconds: catalog.duration),
          genre: catalog.genre,
          artUri: catalog.image,
          extras: {'source': catalog.source},
        );
      }).toList();

      // 2.Now we add our queue to audio player task & update mediaItem.
      await AudioService.updateMediaItem(queue[index]);
      await AudioService.updateQueue(queue);

      // 3.Let's now begin the playback.
      AudioService.playFromMediaId(id);

      // Optionally, play from given position.
      if (position != null) AudioService.seekTo(position);
    }
  }
}
