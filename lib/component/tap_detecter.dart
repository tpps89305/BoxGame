import 'package:box_game/box_game.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flutter/material.dart';

class TapDetecter extends PositionComponent
    with TapCallbacks, HasGameRef<BoxGame> {
  Function() trigger;

  TapDetecter({
    required this.trigger,
  });

  @override
  Future<void>? onLoad() async {
    size = Vector2(gameRef.canvasSize.x, gameRef.canvasSize.y);
  }

  @override
  void render(Canvas canvas) {
    canvas.drawColor(Colors.green.withOpacity(0.2), BlendMode.srcATop);
  }

  @override
  void onTapUp(TapUpEvent event) {
    trigger();
  }
}
