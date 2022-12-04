import 'package:box_game/box_game.dart';
import 'package:flame/extensions.dart';

import 'fly.dart';

class HouseFly extends Fly {
  final BoxGame boxGame;
  final Vector2 mposition;

  HouseFly(
    this.boxGame,
    this.mposition,
  ) : super(
          boxGame,
          mposition,
          flyingSpriteFileNames: [
            'flies/house-fly-1.png',
            'flies/house-fly-2.png',
          ],
          deadSpriteFileName: 'flies/house-fly-dead.png',
        );
}
