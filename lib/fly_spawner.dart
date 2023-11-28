import 'dart:developer';
import 'dart:math' hide log;

import 'package:box_game/box_game.dart';
import 'package:box_game/component/fly/agile_fly.dart';
import 'package:box_game/component/fly/drooler_fly.dart';
import 'package:box_game/component/fly/house_fly.dart';
import 'package:box_game/component/fly/hungry_fly.dart';
import 'package:box_game/component/fly/macho_fly.dart';
import 'package:box_game/game_page.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'component/fly/fly.dart';

class FlySpawner extends Component with HasGameRef<BoxGame> {
  GamePage gamePage;

  final int maxSpawnInterval = 3000;
  final int minSpawnInterval = 250;
  final int intervalChange = 30;
  final int maxFliesOnScreen = 7;

  int currentInterval = 0;
  int nextSpawn = 0;

  Function()? onFlyHasKilled;

  late final double safeAreaTopPadding;

  final Random random = Random();

  FlySpawner({
    required this.gamePage,
    this.onFlyHasKilled,
  });

  @override
  Future<void>? onLoad() async {
    log("onLoad", name: "FlySpawner");
    safeAreaTopPadding = MediaQuery.of(gameRef.buildContext!).padding.top;
  }

  @override
  void onMount() {
    start();
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
      spawnFly();
      if (currentInterval > minSpawnInterval) {
        currentInterval -= intervalChange;
        currentInterval -= (currentInterval * .02).toInt();
      }
      nextSpawn = nowTimestamp + currentInterval;
    }
  }

  start() {
    spawnFly();
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

  void spawnFly() {
    // 減去飛蠅的寬度，是避免生成在螢幕的邊緣。
    // 乘上最大的飛蠅(MachoFly)的尺寸倍數
    double x = random.nextDouble() *
        (gameRef.size.toRect().width - gameRef.tileSize * 2.025);
    double y = random.nextDouble() *
            (gameRef.size.toRect().height -
                gameRef.tileSize * 2.025 -
                safeAreaTopPadding) +
        safeAreaTopPadding;

    switch (random.nextInt(5)) {
      case 0:
        add(HouseFly(
          gameRef,
          Vector2(x, y),
          onFlyHasKilled: () {
            log("Kill house fly");
            if (onFlyHasKilled != null) {
              onFlyHasKilled!();
            }
          },
        ));
        break;
      case 1:
        add(DroolerFly(
          gameRef,
          Vector2(x, y),
          onFlyHasKilled: () {
            log("Kill droller fly");
            if (onFlyHasKilled != null) {
              onFlyHasKilled!();
            }
          },
        ));
        break;
      case 2:
        add(AglieFly(
          gameRef,
          Vector2(x, y),
          onFlyHasKilled: () {
            log("Kill aglie fly");
            if (onFlyHasKilled != null) {
              onFlyHasKilled!();
            }
          },
        ));
        break;
      case 3:
        add(MachoFly(
          gameRef,
          Vector2(x, y),
          onFlyHasKilled: () {
            log("Kill macho fly");
            if (onFlyHasKilled != null) {
              onFlyHasKilled!();
            }
          },
        ));
        break;
      case 4:
        add(HungryFly(
          gameRef,
          Vector2(x, y),
          onFlyHasKilled: () {
            log("Kill hungry fly");
            if (onFlyHasKilled != null) {
              onFlyHasKilled!();
            }
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
