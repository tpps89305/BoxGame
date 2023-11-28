import 'package:box_game/box_game.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';

class HelpButton extends PositionComponent
    with TapCallbacks, HasGameRef<BoxGame> {
  Function() onPressed;

  HelpButton({required this.onPressed});

  @override
  Future<void>? onLoad() async {
    final sprite = await Sprite.load('ui/icon-help.png');
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
