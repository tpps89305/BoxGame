import 'package:box_game/box_game.dart';
import 'package:flame/components.dart';

class LostTitle extends PositionComponent with HasGameRef<BoxGame> {
  @override
  Future<void>? onLoad() async {
    final sprite = await Sprite.load('bg/lose-splash.png');
    double spriteX = gameRef.tileSize * 7;
    double spriteY = gameRef.tileSize * 5;
    size = Vector2(spriteX, spriteY);
    final startButton = SpriteComponent(
      sprite: sprite,
      size: size,
    );
    add(startButton);
  }
}