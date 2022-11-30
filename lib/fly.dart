import 'dart:ui';

import 'package:box_game/box_game.dart';
import 'package:flame/extensions.dart';

class Fly {
  late Rect flyRect;
  late Paint flyPaint;

  final BoxGame game;
  bool isDead = false;
  bool isOffScreen = false;

  Fly(this.game, Vector2 position) {
    flyRect =
        Rect.fromLTWH(position.x, position.y, game.tileSize, game.tileSize);
    flyPaint = Paint();
    flyPaint.color = const Color(0xffbadc58);
  }

  void render(Canvas canvas) {
    canvas.drawRect(flyRect, flyPaint);
  }

  void update(double dt) {
    if (isDead) {
      flyRect = flyRect.translate(0, game.tileSize * 12 * dt);
      if (flyRect.top > game.canvasSize.toRect().height) {
        isOffScreen = true;
      }
    }
  }

  void onTapDown() {
    flyPaint.color = Color(0xffff4757);
    isDead = true;
  }
}
