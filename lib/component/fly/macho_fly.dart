import 'package:box_game/component/fly/fly.dart';
import 'package:flame/components.dart';

class MachoFly extends Fly {
  final Vector2 mposition;

  @override
  double get speed => 200;

  MachoFly(
    boxGame,
    this.mposition,
  ) : super(
          boxGame,
          mposition,
          flyingSpriteFileNames: [
            'flies/macho-fly-1.png',
            'flies/macho-fly-2.png',
          ],
          deadSpriteFileName: 'flies/macho-fly-dead.png',
          tileScale: 2.025,
        );
}
