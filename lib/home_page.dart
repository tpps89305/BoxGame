import 'package:box_game/box_game.dart';
import 'package:flame/components.dart';

class HomePage extends Component with HasGameRef<BoxGame> {

  HomePage() : super(priority: 0);

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    _setBanner(size);
  }

  void _setBanner(Vector2 canvasSize) async {
    final sprite = await Sprite.load('branding/title.png');
    double spriteX = gameRef.tileSize * 7;
    double spriteY = gameRef.tileSize * 4;
    final size = Vector2(spriteX, spriteY);
    final position = Vector2(canvasSize.x / 2 - spriteX / 2, gameRef.tileSize * 4);
    final background = SpriteComponent(
      sprite: sprite,
      size: size,
      position: position,
    );
    add(background);
  }
}
