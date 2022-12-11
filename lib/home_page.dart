import 'dart:developer';

import 'package:box_game/box_game.dart';
import 'package:box_game/component/ui/credits_button.dart';
import 'package:box_game/component/ui/help_button.dart';
import 'package:box_game/component/ui/start_button.dart';
import 'package:flame/components.dart';

class HomePage extends Component with HasGameRef<BoxGame> {
  HomePage() : super(priority: 0) {
    addAll([
      _startButton = StartButton(onPressed: () {
        gameRef.router.pushNamed('game');
      }),
      _helpButton = HelpButton(onPressed: () {
        log("Help Button press", name: "HomePage");
      }),
      _creditsButton = CreditsButton(onPressed: () {
        log("Credits Button press", name: "HomePage");
      }),
    ]);
  }

  late StartButton _startButton;

  late HelpButton _helpButton;

  late CreditsButton _creditsButton;

  @override
  // ignore: avoid_renaming_method_parameters
  void onGameResize(Vector2 canvasSize) {
    super.onGameResize(canvasSize);
    _setBanner(canvasSize);
    _startButton.position = Vector2(
        canvasSize.x / 2 - ((gameRef.tileSize * 6) / 2), gameRef.tileSize * 10);
    _helpButton.position = Vector2(gameRef.tileSize * .25,
        gameRef.canvasSize.y - (gameRef.tileSize * 1.25));
    _creditsButton.position = Vector2(gameRef.canvasSize.x - gameRef.tileSize * 1.25,
        gameRef.canvasSize.y - (gameRef.tileSize * 1.25));
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
