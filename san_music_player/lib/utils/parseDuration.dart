import 'package:san_music_player/Constants/IntegerConstants.dart';

String songDuration(Duration duration) {
  String seconds;
  final minutes = duration.inMinutes.remainder(IntegerConstants.totalSecond);
  final num secondValue =
      duration.inSeconds.remainder(IntegerConstants.totalSecond);
  if (secondValue < IntegerConstants.sec) {
    seconds = '0$secondValue';
  } else {
    seconds = '$secondValue';
  }
  return '$minutes:$seconds';
}
