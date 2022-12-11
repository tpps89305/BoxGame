import 'package:box_game/game_over_page.dart';
import 'package:flame/game.dart';
import 'package:flame/rendering.dart';

/// 自訂引導到結束頁面的方式
class GameOverRoute extends Route {
  GameOverRoute() : super(GameOverPage.new, transparent: true);

  @override
  void onPush(Route? previousRoute) {
    previousRoute!
      ..stopTime()
      ..addRenderEffect(
        PaintDecorator.grayscale(opacity: 0.5)..addBlur(3.0),
      );
  }

  @override
  // ignore: avoid_renaming_method_parameters
  void onPop(Route previousRoute) {
    previousRoute
      ..resumeTime()
      ..removeRenderEffect();
  }
}
