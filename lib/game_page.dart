import 'dart:developer';
import 'dart:math' hide log;

import 'package:box_game/box_game.dart';
import 'package:box_game/box_game_tools.dart';
import 'package:box_game/component/fly/fly.dart';
import 'package:box_game/component/tap_detecter.dart';
import 'package:box_game/component/ui/score_display.dart';
import 'package:box_game/constants.dart';
import 'package:box_game/data_manager.dart';
import 'package:box_game/fly_spawner.dart';
import 'package:flame/components.dart';
import 'package:box_game/component/fly/agile_fly.dart';
import 'package:box_game/component/fly/drooler_fly.dart';
import 'package:box_game/component/fly/house_fly.dart';
import 'package:box_game/component/fly/hungry_fly.dart';
import 'package:box_game/component/fly/macho_fly.dart';
import 'package:flame_audio/flame_audio.dart';

class GamePage extends Component with HasGameRef<BoxGame> {
  final Random random = Random();
  late FlySpawner _flySpawner;
  final ScoreDisplay _scoreDisplay = ScoreDisplay();

  GamePage() : super(priority: 1);

  @override
  Future<void>? onLoad() async {
    spawnFly();
    _flySpawner = FlySpawner(gamePage: this);

    // 點擊到空白區域時，結束遊戲。
    add(TapDetecter(
      trigger: () async {
        removeAllFlies();
        await FlameAudio.bgm.stop();
        await FlameAudio.play(BoxGameTools.getRandomHaHaAudioName());
        gameRef.router.pushNamed('gameover');
        gameRef.overlays.add(OverlayName.gameOver);
      },
    ));
    add(_flySpawner);

    _scoreDisplay.position = Vector2(0, 100);
    add(_scoreDisplay);
  }

  @override
  void onMount() {
    _scoreDisplay.setText(DataManager.score.toString());
  }

  @override
  void update(double dt) {}

  void spawnFly() {
    // 減去飛蠅的寬度，是避免生成在螢幕的邊緣。
    // 乘上最大的飛蠅(MachoFly)的尺寸倍數
    double x = random.nextDouble() *
        (gameRef.size.toRect().width - gameRef.tileSize * 2.025);
    double y = random.nextDouble() *
        (gameRef.size.toRect().height - gameRef.tileSize * 2.025);

    switch (random.nextInt(5)) {
      case 0:
        add(HouseFly(
          gameRef,
          Vector2(x, y),
          onFlyHasKilled: () {
            log("Kill house fly");
            DataManager.score++;
            _scoreDisplay.setText(DataManager.score.toString());
          },
        ));
        break;
      case 1:
        add(DroolerFly(
          gameRef,
          Vector2(x, y),
          onFlyHasKilled: () {
            log("Kill droller fly");
            DataManager.score++;
            _scoreDisplay.setText(DataManager.score.toString());
          },
        ));
        break;
      case 2:
        add(AglieFly(
          gameRef,
          Vector2(x, y),
          onFlyHasKilled: () {
            log("Kill aglie fly");
            DataManager.score++;
            _scoreDisplay.setText(DataManager.score.toString());
          },
        ));
        break;
      case 3:
        add(MachoFly(
          gameRef,
          Vector2(x, y),
          onFlyHasKilled: () {
            log("Kill macho fly");
            DataManager.score++;
            _scoreDisplay.setText(DataManager.score.toString());
          },
        ));
        break;
      case 4:
        add(HungryFly(
          gameRef,
          Vector2(x, y),
          onFlyHasKilled: () {
            log("Kill hungry fly");
            DataManager.score++;
            _scoreDisplay.setText(DataManager.score.toString());
          },
        ));
        break;
      default:
    }
  }

  removeAllFlies() {
    final flyNotifier = gameRef.componentsNotifier<Fly>();
    final flies = flyNotifier.components;
    removeAll(flies);
  }
}
