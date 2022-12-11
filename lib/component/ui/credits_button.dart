import 'package:box_game/box_game.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';

class CreditsButton extends PositionComponent
    with TapCallbacks, HasGameRef<BoxGame> {
  Function() onPressed;

  CreditsButton({required this.onPressed});

  @override
  Future<void>? onLoad() async {
    final sprite = await Sprite.load('ui/icon-credits.png');
    double spriteX = gameRef.tileSize;
    double spriteY = gameRef.tileSize;
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
