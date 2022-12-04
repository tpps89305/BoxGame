import 'dart:ui';

import 'package:box_game/box_game.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/extensions.dart';

abstract class Fly extends PositionComponent with Notifier, TapCallbacks {
  late SpriteAnimationComponent flyingComponent;
  late SpriteComponent deadComponent;

  final BoxGame game;
  bool isDead = false;

  Fly(
    this.game,
    Vector2 mposition, {
      required List<String> flyingSpriteFileNames,
      required String deadSpriteFileName,
    }
  ) : super(priority: 1) {
    size = Vector2(game.tileSize * 1.5, game.tileSize * 1.5);
    position = mposition;
    _loadSprites(
      flyingSpriteFileNames: flyingSpriteFileNames,
      deadSpriteFileName: deadSpriteFileName,
    );
  }

  _loadSprites({
      required List<String> flyingSpriteFileNames,
      required String deadSpriteFileName,
    }) async {
    deadComponent = SpriteComponent(
      sprite: await Sprite.load(deadSpriteFileName),
      size: size,
    );

    final flyingSprite = <Sprite>[];
    flyingSprite.add(await Sprite.load(flyingSpriteFileNames[0]));
    flyingSprite.add(await Sprite.load(flyingSpriteFileNames[1]));
    final animation = SpriteAnimation.spriteList(flyingSprite, stepTime: 0.1);
    flyingComponent = SpriteAnimationComponent(
      animation: animation,
      size: size,
    );
    add(flyingComponent);
  }

  @override
  void render(Canvas canvas) {
    // canvas.drawRect(size.toRect(), flyPaint);
  }

  @override
  void update(double dt) {
    if (isDead) {
      position.add(Vector2(0, game.tileSize * 12 * dt));
      if (position.y > game.canvasSize.toRect().height) {
        removeFromParent();
      }
    }
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (!isDead) {
      remove(flyingComponent);
      add(deadComponent);
      isDead = true;
      notifyListeners();
    }
  }
}
