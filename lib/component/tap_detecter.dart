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
    final safeAreaTopPadding = MediaQuery.of(gameRef.buildContext!).padding.top;
    size = Vector2(
        gameRef.canvasSize.x, gameRef.canvasSize.y - safeAreaTopPadding);
    position = Vector2(0, safeAreaTopPadding);
  }

  @override
  void onTapUp(TapUpEvent event) {
    trigger();
  }
}
