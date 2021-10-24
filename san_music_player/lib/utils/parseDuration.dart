import 'package:san_music_player/Constants/IntegerConstants.dart';

String songDuration(Duration duration) {
  String seconds;
  final minutes = duration.inMinutes.remainder(IntegerConstants.totalSecond);
  final sec = duration.inSeconds.remainder(IntegerConstants.totalSecond);
  if (sec < IntegerConstants.sec) {
    seconds = '0$sec';
  } else {
    seconds = '$sec';
  }
  return '$minutes:$seconds';
}
