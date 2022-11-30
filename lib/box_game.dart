import 'dart:math';

import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'fly.dart';

class BoxGame extends FlameGame with HasTappableComponents {
  double tileSize = 0;
  final flies = <Fly>[];
  final Random random = Random();

  @override
  Color backgroundColor() => const Color(0xff576574);

  @override
  Future<void>? onLoad() async {
    spawnFly();
  }

  @override
  void update(double dt) {
    super.update(dt);
    for (var element in flies) {
      element.update(dt);
    }
    flies.removeWhere((element) => element.isOffScreen);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    for (var element in flies) {
      element.render(canvas);
    }
  }

  @override
  void onGameResize(Vector2 canvasSize) {
    super.onGameResize(canvasSize);

    tileSize = canvasSize.y / 9;
  }

  void spawnFly() {
    double x = random.nextDouble() * (size.toRect().width - tileSize);
    double y = random.nextDouble() * (size.toRect().height - tileSize);
    flies.add(Fly(this, Vector2(x, y)));
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    for (var fly in flies) {
      if (fly.flyRect.contains(event.canvasPosition.toOffset())) {
        fly.onTapDown();
        spawnFly();
      }
    }
  }
}
