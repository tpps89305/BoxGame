import 'dart:math' hide log;

import 'package:box_game/game_page.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class BoxGame extends FlameGame with HasTappableComponents {
  double tileSize = 0;
  final Random random = Random();

  @override
  bool get debugMode => true;

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  void onGameResize(Vector2 canvasSize) {
    super.onGameResize(canvasSize);

    tileSize = canvasSize.x / 9;
    _setBackground(canvasSize);
    add(GamePage());
  }

  void _setBackground(Vector2 canvasSize) async {
    final sprite = await Sprite.load('bg/backyard.png');
    final size = Vector2(tileSize * 9, tileSize * 23);
    final position = Vector2(0, canvasSize.y - tileSize * 23);
    final background = SpriteComponent(
      sprite: sprite,
      size: size,
      position: position,
    );
    add(background);
  }
}
