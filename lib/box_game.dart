import 'dart:math' hide log;

import 'package:box_game/game_page.dart';
import 'package:box_game/home_page.dart';
import 'package:box_game/route/game_over_route.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart' show Canvas;

class BoxGame extends FlameGame with HasTappableComponents {
  double tileSize = 0;
  final Random random = Random();
  late final RouterComponent router;

  @override
  bool get debugMode => true;

  @override
  Future<void>? onLoad() async {
    add(router = RouterComponent(
      routes: {
        'home': Route(HomePage.new),
        'game': Route(GamePage.new),
        'gameover': GameOverRoute(),
      },
      initialRoute: 'home',
    ));
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

  void _setBackground(Vector2 canvasSize) async {
    final sprite = await Sprite.load('bg/backyard.png');
    final size = Vector2(tileSize * 9, tileSize * 23);
    final position = Vector2(0, canvasSize.y - tileSize * 23);
    final background = SpriteComponent(
      sprite: sprite,
      size: size,
      position: position,
      priority: -1,
    );
    add(background);
  }
}
