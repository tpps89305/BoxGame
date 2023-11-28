import 'package:box_game/audio_manager.dart';
import 'package:box_game/box_game.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'dart:math' hide log;

import 'package:flutter/material.dart';

abstract class Fly extends PositionComponent with Notifier, TapCallbacks {
  late SpriteAnimationComponent flyingComponent;
  late SpriteComponent deadComponent;

  final BoxGame game;
  bool isDead = false;

  double get speed => 100;
  late Vector2 targetLocation;

  final Random random = Random();
  double tileScale;

  Function()? onFlyHasKilled;
  double safeAreaPaddingTop = 0;

  Fly(
    this.game,
    Vector2 mposition, {
    this.tileScale = 1.5,
    required List<String> flyingSpriteFileNames,
    required String deadSpriteFileName,
    this.onFlyHasKilled,
  }) : super(priority: 1) {
    safeAreaPaddingTop = MediaQuery.of(game.buildContext!).padding.top;
    size = Vector2(game.tileSize * tileScale, game.tileSize * tileScale);
    position = mposition;
    _loadSprites(
      flyingSpriteFileNames: flyingSpriteFileNames,
      deadSpriteFileName: deadSpriteFileName,
    );
    setTargetLocation();
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

  void setTargetLocation() {
    double x = random.nextDouble() *
        (game.size.toRect().width - game.tileSize * tileScale);
    double y = random.nextDouble() *
        (game.size.toRect().height - game.tileSize * tileScale - safeAreaPaddingTop) + safeAreaPaddingTop;
    targetLocation = Vector2(x, y);
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
    } else {
      // 計算距離和速度
      final velocity = (targetLocation - position)..scaleTo(speed);
      position.add(velocity * dt);
      Vector2 distance = targetLocation - position;
      if (distance.x <= 10 && distance.y <= 10) {
        setTargetLocation();
      }
    }
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (!isDead) {
      AudioManager.playOuchMusic();
      remove(flyingComponent);
      add(deadComponent);
      isDead = true;
      if (onFlyHasKilled != null) {
        onFlyHasKilled!();
      }
    }
  }
}
