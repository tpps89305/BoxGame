import 'dart:developer';

import 'package:box_game/box_game.dart';
import 'package:box_game/component/fly/ui/start_button.dart';
import 'package:flame/components.dart';

class HomePage extends Component with HasGameRef<BoxGame> {
  HomePage() : super(priority: 0) {
    addAll([
      _startButton = StartButton(onPressed: () {
        log("Start Button press", name: "HomePage");
        gameRef.router.pushNamed('game');
      }),
    ]);
  }

  late StartButton _startButton;

  @override
  // ignore: avoid_renaming_method_parameters
  void onGameResize(Vector2 canvasSize) {
    super.onGameResize(canvasSize);
    _setBanner(canvasSize);
    _startButton.position = Vector2(
        canvasSize.x / 2 - ((gameRef.tileSize * 6) / 2), gameRef.tileSize * 10);
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
