import 'dart:developer';

import 'package:box_game/box_game.dart';
import 'package:box_game/game_page.dart';
import 'package:flame/components.dart';

import 'component/fly/fly.dart';

class FlySpawner extends Component with HasGameRef<BoxGame> {
  GamePage gamePage;

  final int maxSpawnInterval = 3000;
  final int minSpawnInterval = 250;
  final int intervalChange = 30;
  final int maxFliesOnScreen = 7;

  int currentInterval = 0;
  int nextSpawn = 0;

  FlySpawner({
    required this.gamePage,
  }) {
    start();
  }

  @override
  Future<void>? onLoad() async {
    log("onLoad", name: "FlySpawner");
  }

  @override
  void update(double dt) {
    int nowTimestamp = DateTime.now().millisecondsSinceEpoch;

    final flyNotifier = gameRef.componentsNotifier<Fly>();
    final flies = flyNotifier.components;
    int livingFlies = 0;
    for (var fly in flies) {
      if (!fly.isDead) livingFlies += 1;
    }

    if (nowTimestamp >= nextSpawn && livingFlies < maxFliesOnScreen) {
      gamePage.spawnFly();
      if (currentInterval > minSpawnInterval) {
        currentInterval -= intervalChange;
        currentInterval -= (currentInterval * .02).toInt();
      }
      nextSpawn = nowTimestamp + currentInterval;
    }
  }

  start() {
    currentInterval = maxSpawnInterval;
    nextSpawn = DateTime.now().millisecondsSinceEpoch + currentInterval;
  }

  killAll() {
    final flyNotifier = gameRef.componentsNotifier<Fly>();
    final flies = flyNotifier.components;
    for (var fly in flies) {
      fly.isDead = true;
    }
  }
}
