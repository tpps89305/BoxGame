import 'package:box_game/box_game.dart';
import 'package:box_game/component/fly/fly.dart';
import 'package:flame/components.dart';

class DroolerFly extends Fly {
  final BoxGame boxGame;
  final Vector2 mposition;

  DroolerFly(
    this.boxGame,
    this.mposition,
  ) : super(
          boxGame,
          mposition,
          flyingSpriteFileNames: [
            'flies/drooler-fly-1.png',
            'flies/drooler-fly-2.png',
          ],
          deadSpriteFileName: 'flies/drooler-fly-dead.png',
        );
}
