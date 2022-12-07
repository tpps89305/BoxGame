import 'dart:developer';
import 'dart:math' hide log;

import 'package:box_game/component/fly/agile_fly.dart';
import 'package:box_game/component/fly/drooler_fly.dart';
import 'package:box_game/component/fly/fly.dart';
import 'package:box_game/component/fly/house_fly.dart';
import 'package:box_game/component/fly/hungry_fly.dart';
import 'package:box_game/component/fly/macho_fly.dart';
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
  Future<void>? onLoad() async {
    spawnFly();
    final flyNotifier = componentsNotifier<Fly>();
    flyNotifier.addListener(() {
      final flies = flyNotifier.components;
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

    tileSize = canvasSize.x / 9;
    _setBackground(canvasSize);
  }

  void spawnFly() {
    // 減去飛蠅的寬度，是避免生成在螢幕的邊緣。
    // 乘上最大的飛蠅(MachoFly)的尺寸倍數
    double x = random.nextDouble() * (size.toRect().width - tileSize * 2.025);
    double y = random.nextDouble() * (size.toRect().height - tileSize * 2.025);

    switch (random.nextInt(5)) {
      case 0:
        add(HouseFly(this, Vector2(x, y)));
        break;
      case 1:
        add(DroolerFly(this, Vector2(x, y)));
        break;
      case 2:
        add(AglieFly(this, Vector2(x, y)));
        break;
      case 3:
        add(MachoFly(this, Vector2(x, y)));
        break;
      case 4:
        add(HungryFly(this, Vector2(x, y)));
        break;
      default:
    }
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
