import 'package:box_game/component/fly/fly.dart';
import 'package:flame/components.dart';

class DroolerFly extends Fly {
  final Vector2 mposition;

  @override
  double get speed => 50;

  DroolerFly(
    boxGame,
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
