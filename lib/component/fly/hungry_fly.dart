import 'package:box_game/box_game.dart';
import 'package:box_game/component/fly/fly.dart';
import 'package:flame/components.dart';

class HungryFly extends Fly {
  final BoxGame boxGame;
  final Vector2 mposition;

  HungryFly(
    this.boxGame,
    this.mposition,
  ) : super(
          boxGame,
          mposition,
          flyingSpriteFileNames: [
            'flies/hungry-fly-1.png',
            'flies/hungry-fly-2.png',
          ],
          deadSpriteFileName: 'flies/hungry-fly-dead.png',
        );
}