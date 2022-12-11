import 'package:box_game/box_game.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';

class StartButton extends PositionComponent
    with TapCallbacks, HasGameRef<BoxGame> {
  Function() onPressed;

  StartButton({
    required this.onPressed,
  });

  @override
  Future<void>? onLoad() async {
    final sprite = await Sprite.load('ui/start-button.png');
    double spriteX = gameRef.tileSize * 6;
    double spriteY = gameRef.tileSize * 3;
    size = Vector2(spriteX, spriteY);
    final startButton = SpriteComponent(
      sprite: sprite,
      size: size,
    );
    add(startButton);
  }

  @override
  void onTapUp(TapUpEvent event) {
    onPressed();
  }
}
