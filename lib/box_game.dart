import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class BoxGame extends FlameGame with HasTappableComponents {
  @override
  Future<void>? onLoad() async {
    add(TargetBox());
  }
}

class TargetBox extends PositionComponent with TapCallbacks {
  Paint _paint = Paint()..color = Colors.white;
  TargetBox() : super(anchor: Anchor.center);

  @override
  // ignore: avoid_renaming_method_parameters
  void onGameResize(Vector2 canvasSize) {
    super.onGameResize(canvasSize);
    size = Vector2(100, 100);
    position = canvasSize / 2;
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(size.toRect(), _paint);
  }

  @override
  void onTapDown(TapDownEvent event) {
    _paint = Paint()..color = Colors.green;
  }
}
