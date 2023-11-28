import 'dart:developer';

import 'package:box_game/audio_manager.dart';
import 'package:box_game/box_game.dart';
import 'package:box_game/component/ui/box_game_button.dart';
import 'package:box_game/component/ui/credits_button.dart';
import 'package:box_game/component/ui/help_button.dart';
import 'package:box_game/component/ui/start_button.dart';
import 'package:box_game/constants.dart';
import 'package:box_game/data_manager.dart';
import 'package:flame/components.dart';

class HomePage extends Component with HasGameRef<BoxGame> {
  HomePage() : super(priority: 0) {
    addAll([
      _startButton = StartButton(onPressed: () async {
        DataManager.score = 0;
        await AudioManager.playPlayingBGM();
        gameRef.router.pushNamed('game');
      }),
      _helpButton = HelpButton(onPressed: () {
        log("Help Button press", name: "HomePage");
        gameRef.overlays.add(OverlayName.help);
      }),
      _creditsButton = CreditsButton(onPressed: () {
        log("Credits Button press", name: "HomePage");
        gameRef.overlays.add(OverlayName.credits);
      }),
      _enableMusicButton = BoxGameButton(
        onPressed: () {
          AudioManager.isEffectAudioEnable = !AudioManager.isEffectAudioEnable;
          _enableMusicButton.setImage(AudioManager.isEffectAudioEnable
              ? "ui/icon-sound-enabled.png"
              : "ui/icon-sound-disabled.png");
        },
        imageName: AudioManager.isEffectAudioEnable
            ? "ui/icon-sound-enabled.png"
            : "ui/icon-sound-disabled.png",
      ),
      _enableBGMButton = BoxGameButton(
        onPressed: () {
          AudioManager.isBGMEnable = !AudioManager.isBGMEnable;
          _enableBGMButton.setImage(AudioManager.isBGMEnable
              ? "ui/icon-music-enabled.png"
              : "ui/icon-music-disabled.png");
          if (AudioManager.isBGMEnable) {
            AudioManager.playHomeBGM();
          } else {
            AudioManager.stopBGM();
          }
        },
        imageName: AudioManager.isBGMEnable
            ? "ui/icon-music-enabled.png"
            : "ui/icon-music-disabled.png",
      ),
    ]);
  }

  late StartButton _startButton;

  late HelpButton _helpButton;

  late CreditsButton _creditsButton;

  late BoxGameButton _enableMusicButton;

  late BoxGameButton _enableBGMButton;

  @override
  // ignore: avoid_renaming_method_parameters
  void onGameResize(Vector2 canvasSize) {
    super.onGameResize(canvasSize);
    _setBanner(canvasSize);
    _startButton.position = Vector2(
        canvasSize.x / 2 - ((gameRef.tileSize * 6) / 2), gameRef.tileSize * 10);
    _helpButton.position = Vector2(gameRef.tileSize * .25,
        gameRef.canvasSize.y - (gameRef.tileSize * 1.25));
    _creditsButton.position = Vector2(
        gameRef.canvasSize.x - gameRef.tileSize * 1.25,
        gameRef.canvasSize.y - (gameRef.tileSize * 1.25));
    _enableBGMButton.position = Vector2(
        gameRef.canvasSize.x / 2 - gameRef.tileSize * 2,
        gameRef.canvasSize.y - (gameRef.tileSize * 1.25));
    _enableMusicButton.position = Vector2(
        gameRef.canvasSize.x / 2 + gameRef.tileSize,
        gameRef.canvasSize.y - (gameRef.tileSize * 1.25));
  }

  @override
  void onMount() async {
    log("Home Page on Mount");
    await AudioManager.playHomeBGM();
  }

  void _setBanner(Vector2 canvasSize) async {
    final sprite = await Sprite.load('branding/title.png');
    double spriteX = gameRef.tileSize * 7;
    double spriteY = gameRef.tileSize * 4;
    final size = Vector2(spriteX, spriteY);
    final position =
        Vector2(canvasSize.x / 2 - spriteX / 2, gameRef.tileSize * 4);
    final background = SpriteComponent(
      sprite: sprite,
      size: size,
      position: position,
    );
    add(background);
  }
}
