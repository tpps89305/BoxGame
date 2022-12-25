import 'package:box_game/box_game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class ScoreDisplay extends PositionComponent with HasGameRef<BoxGame> {
  TextPainter painter = TextPainter(
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr,
  );
  TextStyle textStyle = const TextStyle(
    color: Colors.white,
    fontSize: 64,
    shadows: [
      Shadow(
        blurRadius: 7,
        color: Colors.black,
      ),
    ],
  );

  @override
  Future<void>? onLoad() async {
    painter.text = TextSpan(style: textStyle);
  }

  setText(String text) {
    painter.text = TextSpan(text: text, style: textStyle);
  }

  @override
  void render(Canvas canvas) {
    painter.layout();
    painter.paint(canvas, Offset.zero);
  }
}
