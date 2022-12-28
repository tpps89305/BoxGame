import 'package:box_game/box_game.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';

class BoxGameButton extends PositionComponent
    with TapCallbacks, HasGameRef<BoxGame> {
  Function() onPressed;
  final String imageName;
  late SpriteComponent startButton;

  BoxGameButton({required this.onPressed, required this.imageName});

  @override
  Future<void>? onLoad() async {
    final sprite = await Sprite.load(imageName);
    double spriteX = gameRef.tileSize;
    double spriteY = gameRef.tileSize;
    size = Vector2(spriteX, spriteY);
    startButton = SpriteComponent(
      sprite: sprite,
      size: size,
    );
    add(startButton);
  }

  @override
  void onTapUp(TapUpEvent event) {
    onPressed();
  }

  setImage(String imageName) async {
    remove(startButton);
    final sprite = await Sprite.load(imageName);
    double spriteX = gameRef.tileSize;
    double spriteY = gameRef.tileSize;
    size = Vector2(spriteX, spriteY);
    startButton = SpriteComponent(
      sprite: sprite,
      size: size,
    );
    add(startButton);
  }
}
