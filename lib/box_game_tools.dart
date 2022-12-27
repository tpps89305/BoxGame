import 'dart:math';

import 'package:box_game/constants.dart';

class BoxGameTools {
  static String getRandomOushAudioName() {
    final Random random = Random();
    int index = random.nextInt(AssertName.ouchAudioNames.length);
    return AssertName.ouchAudioNames[index];
  }

  static String getRandomHaHaAudioName() {
    final Random random = Random();
    int index = random.nextInt(AssertName.hahaAudioNames.length);
    return AssertName.hahaAudioNames[index];
  }
}
