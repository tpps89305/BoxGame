import 'package:box_game/component/fly/fly.dart';
import 'package:flame/components.dart';

class AglieFly extends Fly {
  final Vector2 mposition;

  @override
  double get speed => 200;

  AglieFly(boxGame, this.mposition)
      : super(
          boxGame,
          mposition,
          flyingSpriteFileNames: [
            'flies/agile-fly-1.png',
            'flies/agile-fly-2.png',
          ],
          deadSpriteFileName: 'flies/agile-fly-dead.png',
        );
}
