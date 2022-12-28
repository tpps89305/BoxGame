import 'package:box_game/audio_manager.dart';
import 'package:box_game/box_game.dart';
import 'package:box_game/component/tap_detecter.dart';
import 'package:box_game/component/ui/score_display.dart';
import 'package:box_game/constants.dart';
import 'package:box_game/data_manager.dart';
import 'package:box_game/fly_spawner.dart';
import 'package:flame/components.dart';

class GamePage extends Component with HasGameRef<BoxGame> {
  late FlySpawner _flySpawner;
  final ScoreDisplay _scoreDisplay = ScoreDisplay();

  GamePage() : super(priority: 1);

  @override
  Future<void>? onLoad() async {
    _flySpawner = FlySpawner(
      gamePage: this,
      onFlyHasKilled: () {
        DataManager.score++;
        _scoreDisplay.setText(DataManager.score.toString());
      },
    );

    // 點擊到空白區域時，結束遊戲。
    add(TapDetecter(
      trigger: () async {
        _flySpawner.removeAllFlies();
        await AudioManager.stopBGM();
        await AudioManager.playHaHaMusic();
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
}
