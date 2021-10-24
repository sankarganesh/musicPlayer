import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:san_music_player/audioPlayer/audioPlayerTask.dart';
import 'package:san_music_player/pojo/catalog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'catalogList.dart';
import 'miniPlayer.dart';

backgroundTaskEntryPoint() {
  AudioServiceBackground.run(() => AudioPlayerTask());
}

class SanHomeView extends StatefulWidget {
  SanHomeView({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SanHomeViewState createState() => _SanHomeViewState();
}

class _SanHomeViewState extends State<SanHomeView> {
  StreamSubscription playbackStateStream;

  bool isStopped(PlaybackState state) =>
      state != null && state.processingState == AudioProcessingState.stopped;

  void reloadPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.reload();
  }

  @override
  void initState() {
    super.initState();
    playbackStateStream =
        AudioService.playbackStateStream.where(isStopped).listen((_) {
      reloadPrefs();
    });
  }

  @override
  void dispose() {
    playbackStateStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LinearGradient gradient = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.purple, Colors.orange]);

    return Container(
        decoration: BoxDecoration(
          gradient: gradient,
        ),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              widget.title,
              style: new TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          body: Consumer<SongDetailModel>(
            builder: (context, catalog, child) {
              if (catalog.items.isNotEmpty) {
                return ListView.separated(
                  itemCount: catalog.items.length,
                  separatorBuilder: (context, index) => Divider(),
                  itemBuilder: (context, index) {
                    return CatalogList(catalog.items, index);
                  },
                );
              }

              // By default, show a loading spinner.
              return Center(child: CircularProgressIndicator());
            },
          ),
          bottomNavigationBar: MiniPlayer(),
        ));
  }
}
