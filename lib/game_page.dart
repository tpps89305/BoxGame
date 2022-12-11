import 'dart:math';

import 'package:box_game/box_game.dart';
import 'package:box_game/component/tap_detecter.dart';
import 'package:box_game/fly_spawner.dart';
import 'package:flame/components.dart';
import 'package:box_game/component/fly/agile_fly.dart';
import 'package:box_game/component/fly/drooler_fly.dart';
import 'package:box_game/component/fly/house_fly.dart';
import 'package:box_game/component/fly/hungry_fly.dart';
import 'package:box_game/component/fly/macho_fly.dart';

class GamePage extends Component with HasGameRef<BoxGame> {
  final Random random = Random();
  late FlySpawner _flySpawner;

  GamePage() : super(priority: 1);

  @override
  Future<void>? onLoad() async {
    spawnFly();
    _flySpawner = FlySpawner(gamePage: this);

    // 點擊到空白區域時，結束遊戲。
    add(TapDetecter(
      trigger: () {
        gameRef.router.pushNamed('gameover');
      },
    ));
    add(_flySpawner);
  }

  void spawnFly() {
    // 減去飛蠅的寬度，是避免生成在螢幕的邊緣。
    // 乘上最大的飛蠅(MachoFly)的尺寸倍數
    double x = random.nextDouble() *
        (gameRef.size.toRect().width - gameRef.tileSize * 2.025);
    double y = random.nextDouble() *
        (gameRef.size.toRect().height - gameRef.tileSize * 2.025);

    switch (random.nextInt(5)) {
      case 0:
        add(HouseFly(gameRef, Vector2(x, y)));
        break;
      case 1:
        add(DroolerFly(gameRef, Vector2(x, y)));
        break;
      case 2:
        add(AglieFly(gameRef, Vector2(x, y)));
        break;
      case 3:
        add(MachoFly(gameRef, Vector2(x, y)));
        break;
      case 4:
        add(HungryFly(gameRef, Vector2(x, y)));
        break;
      default:
    }
  }
}