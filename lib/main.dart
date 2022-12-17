import 'package:box_game/box_game.dart';
import 'package:box_game/constants.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.images.loadAll([
    'bg/backyard.png',
    'flies/agile-fly-1.png',
    'flies/agile-fly-2.png',
    'flies/agile-fly-dead.png',
    'flies/drooler-fly-1.png',
    'flies/drooler-fly-2.png',
    'flies/drooler-fly-dead.png',
    'flies/house-fly-1.png',
    'flies/house-fly-2.png',
    'flies/house-fly-dead.png',
    'flies/hungry-fly-1.png',
    'flies/hungry-fly-2.png',
    'flies/hungry-fly-dead.png',
    'flies/macho-fly-1.png',
    'flies/macho-fly-2.png',
    'flies/macho-fly-dead.png',
  ]);
  runApp(const BoxGameApp());
}

class BoxGameApp extends StatelessWidget {
  const BoxGameApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: BoxGamePage(),
    );
  }
}

class BoxGamePage extends StatelessWidget {
  final BoxGame _boxGame = BoxGame();

  BoxGamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(
        game: _boxGame,
        overlayBuilderMap: {
          OverlayName.help: (context, game) {
            return GestureDetector(
              onTap: () {
                _boxGame.overlays.remove(OverlayName.help);
              },
              child: Container(
                color: const Color.fromARGB(158, 86, 86, 86),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.center,
                child: Container(
                  width: double.infinity,
                  height: 300,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 82, 96, 14),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Text(
                          "遊戲方式",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        "點擊飛蠅，將牠們擊落吧！\n失手的話，遊戲就會結束！",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "點擊空白處回到遊戲",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          OverlayName.credits: (context, game) {
            return GestureDetector(
              onTap: () {
                _boxGame.overlays.remove(OverlayName.credits);
              },
              child: Container(
                color: const Color.fromARGB(158, 86, 86, 86),
                padding: const EdgeInsets.all(16),
                alignment: Alignment.center,
                child: Image.asset('assets/images/ui/dialog-credits.png'),
              ),
            );
          }
        },
      ),
    );
  }
}
