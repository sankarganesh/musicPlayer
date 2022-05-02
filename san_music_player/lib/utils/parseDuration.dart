import 'package:san_music_player/Constants/IntegerConstants.dart';

/**
 * Class responsible for finding the songDuration
 */
String songDuration(Duration duration) {
  String seconds;
  final minutesValue =
      duration.inMinutes.remainder(IntegerConstants.totalSecond);
  final sec = duration.inSeconds.remainder(IntegerConstants.totalSecond);
  if (sec < IntegerConstants.sec) {
    seconds = '0$sec';
  } else {
    seconds = '$sec';
  }
  return '$minutesValue:$seconds';
}
