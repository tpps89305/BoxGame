import 'dart:developer';
import 'dart:math' hide log;

import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'fly.dart';

class BoxGame extends FlameGame with HasTappableComponents {
  double tileSize = 0;
  final Random random = Random();

  @override
  Color backgroundColor() => const Color(0xff576574);

  @override
  Future<void>? onLoad() async {
    spawnFly();
    final flyNotifier = componentsNotifier<Fly>();
    flyNotifier.addListener(() {
      final flies = flyNotifier.components;
      log("listener ${flies.length}");
      bool isShouldAddFly = true;
      for (var fly in flies) {
        if (!fly.isDead) {
          isShouldAddFly = false;
          break;
        }
      }
      if (isShouldAddFly) {
        spawnFly();
      }
    });
  }

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

    tileSize = canvasSize.y / 9;
  }

  void spawnFly() {
    double x = random.nextDouble() * (size.toRect().width - tileSize);
    double y = random.nextDouble() * (size.toRect().height - tileSize);
    add(Fly(this, Vector2(x, y)));
  }
}
