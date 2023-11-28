import 'package:box_game/box_game_tools.dart';
import 'package:flame_audio/flame_audio.dart';

class AudioManager {
  static var isBGMEnable = true;
  static var isEffectAudioEnable = true;

  /// 播放遊戲 BGM
  static playPlayingBGM() async {
    if (isBGMEnable) {
      await FlameAudio.bgm.stop();
      await FlameAudio.bgm.play('bgm/playing.mp3', volume: 0.5);
    }
  }

  /// 播放主畫面 BGM
  static playHomeBGM() async {
    if (isBGMEnable) {
      await FlameAudio.bgm.stop();
      await FlameAudio.bgm.play('bgm/home.mp3');
    }
  }

  /// 停止播放 BGM
  /// 
  /// 同 `FlameAudio.bgm.stop()`
  static stopBGM() async {
    await FlameAudio.bgm.stop();
  }

  /// 播放哈哈音效
  static playHaHaMusic() async {
    if (isEffectAudioEnable) {
      await FlameAudio.play(BoxGameTools.getRandomHaHaAudioName());
    }
  }

  /// 播放唉呦音效
  static playOuchMusic() async {
    if (isEffectAudioEnable) {
      await FlameAudio.play(BoxGameTools.getRandomOushAudioName());
    }
  }
}
