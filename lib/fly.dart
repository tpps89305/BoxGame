import 'dart:ui';

import 'package:box_game/box_game.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/extensions.dart';

class Fly extends PositionComponent with Notifier, TapCallbacks {
  late Paint flyPaint;

  final BoxGame game;
  bool isDead = false;

  Fly(this.game, Vector2 mposition) {
    flyPaint = Paint();
    flyPaint.color = const Color(0xffbadc58);
    size = Vector2(game.tileSize, game.tileSize);
    position = mposition;
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(size.toRect(), flyPaint);
  }

  @override
  void update(double dt) {
    if (isDead) {
      position.add(Vector2(0, game.tileSize * 2 * dt));
      if (position.y > game.canvasSize.toRect().height) {
        removeFromParent();
      }
    }
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (!isDead) {
      flyPaint.color = const Color(0xffff4757);
      isDead = true;
      notifyListeners();
    }
  }
}
