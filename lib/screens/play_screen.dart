import 'dart:async';

import 'package:flappy_bird/items/barrier.dart';
import 'package:flappy_bird/items/bird.dart';
import 'package:flappy_bird/values/app_image.dart';
import 'package:flutter/material.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({Key? key}) : super(key: key);

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  static double birdY = 0;
  double initialPos = 0;
  double height = 0;
  double time = 0;
  // How strong the gravity is
  double gravity = -4.9;
  // How strong the jump is
  double velocity = 3;
  bool gameHasStarted = false;
  double birdWidth = 0.04;
  double birdHeight = 0.2;

  static List<double> barrierX = [2, 3.5, 5, 6.5];
  static double barrierWidth = 0.3;
  List<List<double>> barrierHeight = [
    [0.7, 0.5],
    [1, 0.2],
    [0.6, 0.6],
    [0.2, 1],
  ];

  void resetGame() {
    Navigator.pop(context);
    setState(() {
      birdY = 0;
      gameHasStarted = false;
      time = 0;
      initialPos = 0;
    });
  }

  bool birdIsDead() {
    if (birdY < -1 || birdY > 1) {
      return true;
    }
    for (int i = 0; i < barrierX.length; i++) {
      // if (barrierX[i] <= birdWidth &&
      //     barrierX[i] + barrierWidth >= -birdWidth &&
      //     (birdY <= 1 + barrierHeight[i][0] ||
      //         birdY + birdHeight >= 1 - barrierHeight[i][1])) {
      //   return true;
      // }
      // if (barrierX[i] <= birdWidth &&
      //     barrierX[i] + barrierWidth >= -birdWidth &&
      //     (birdY <= 1 + barrierHeight[i][0] ||
      //         birdY + birdHeight >= 1 - barrierHeight[i][1])) {
      //   return true;
      // }
    }
    return false;
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      height = gravity * time * time + velocity * time;
      setState(() {
        birdY = initialPos - height;
      });

      if (birdIsDead()) {
        timer.cancel();
        gameHasStarted = false;
        _showDialog();
      }

      moveMap();

      time += 0.03;
    });
  }

  void moveMap() {
    for (int i = 0; i < barrierX.length; i++) {
      setState(() {
        barrierX[i] -= 0.02;
      });
      if (barrierX[i] < -1.5) {
        barrierX[i] += 6;
      }
    }
  }

  void _showDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.brown,
          title: const Center(
            child: Text(
              'G A M E  O V E R',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: resetGame,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: Container(
                  color: Colors.white,
                  child: const Text(
                    ' P L A Y  A G A I N ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  void jump() {
    setState(() {
      time = 0;
      initialPos = birdY;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameHasStarted ? jump : startGame,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.blue,
                child: Container(
                  child: Center(
                    child: Stack(
                      children: [
                        MyBird(
                          birdY: birdY,
                          birdHeight: birdHeight,
                          birdWidth: birdWidth,
                        ),
                        MyBarrier(
                          barrierWidth: barrierWidth,
                          barrierHeight: barrierHeight[0][0],
                          barrierX: barrierX[0],
                          isThisBottomBarrier: false,
                        ),
                        MyBarrier(
                          barrierWidth: barrierWidth,
                          barrierHeight: barrierHeight[0][1],
                          barrierX: barrierX[0],
                          isThisBottomBarrier: true,
                        ),
                        MyBarrier(
                          barrierWidth: barrierWidth,
                          barrierHeight: barrierHeight[1][0],
                          barrierX: barrierX[1],
                          isThisBottomBarrier: false,
                        ),
                        MyBarrier(
                          barrierWidth: barrierWidth,
                          barrierHeight: barrierHeight[1][1],
                          barrierX: barrierX[1],
                          isThisBottomBarrier: true,
                        ),
                        MyBarrier(
                          barrierWidth: barrierWidth,
                          barrierHeight: barrierHeight[2][0],
                          barrierX: barrierX[2],
                          isThisBottomBarrier: false,
                        ),
                        MyBarrier(
                          barrierWidth: barrierWidth,
                          barrierHeight: barrierHeight[2][1],
                          barrierX: barrierX[2],
                          isThisBottomBarrier: true,
                        ),
                        MyBarrier(
                          barrierWidth: barrierWidth,
                          barrierHeight: barrierHeight[3][0],
                          barrierX: barrierX[3],
                          isThisBottomBarrier: false,
                        ),
                        MyBarrier(
                          barrierWidth: barrierWidth,
                          barrierHeight: barrierHeight[3][1],
                          barrierX: barrierX[3],
                          isThisBottomBarrier: true,
                        ),
                        Container(
                          alignment: Alignment(0, -0.5),
                          child: Text(
                            gameHasStarted ? '' : 'T A P   T O   P L A Y',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.brown,
              ),
            )
          ],
        ),
      ),
    );
  }
}
