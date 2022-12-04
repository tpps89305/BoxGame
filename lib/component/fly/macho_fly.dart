import 'package:box_game/box_game.dart';
import 'package:box_game/component/fly/fly.dart';
import 'package:flame/components.dart';

class MachoFly extends Fly {
  final BoxGame boxGame;
  final Vector2 mposition;

  MachoFly(
    this.boxGame,
    this.mposition,
  ) : super(
          boxGame,
          mposition,
          flyingSpriteFileNames: [
            'flies/macho-fly-1.png',
            'flies/macho-fly-2.png',
          ],
          deadSpriteFileName: 'flies/macho-fly-dead.png',
        );
}
