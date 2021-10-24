import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:san_music_player/pojo/catalog.dart';
import 'package:san_music_player/views/AnimationView.dart';
import 'package:san_music_player/views/home.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => SongDetailModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music player',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Stack(children: <Widget>[
      Scaffold(
          body: AudioServiceWidget(
        child: SanHomeView(title: 'Music player'),
      )),
      IgnorePointer(child: AnimationView(color: Theme.of(context).accentColor))
    ]));
  }
}
