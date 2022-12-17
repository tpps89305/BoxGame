import 'package:box_game/box_game.dart';
import 'package:box_game/component/ui/lost_title.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';

class GameOverPage extends Component with TapCallbacks, HasGameRef<BoxGame> {
  late LostTitle _lostTitle;

  @override
  Future<void> onLoad() async {
    addAll([_lostTitle = LostTitle()]);
    _lostTitle.anchor = Anchor.center;
    _lostTitle.position =
        Vector2(gameRef.canvasSize.x / 2, gameRef.canvasSize.y / 2);
  }

  @override
  bool containsLocalPoint(Vector2 point) => true;

  @override
  void onTapUp(TapUpEvent event) => gameRef.router.popUntilNamed('home');

  @override
  void render(Canvas canvas) {
    canvas.drawColor(Colors.green.withOpacity(0.7), BlendMode.srcATop);
  }
}
