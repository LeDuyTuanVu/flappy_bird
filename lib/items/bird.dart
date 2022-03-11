import 'package:flappy_bird/values/app_image.dart';
import 'package:flutter/material.dart';

class MyBird extends StatelessWidget {
  final double birdY;
  final double birdHeight;
  final double birdWidth;
  const MyBird({
    Key? key,
    required this.birdY,
    required this.birdHeight,
    required this.birdWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, (2 * birdY + birdHeight) / (2 - birdHeight)),
      child: Image.asset(
        AppImage.bird,
        height: MediaQuery.of(context).size.height * birdWidth * 2,
        width: MediaQuery.of(context).size.height * 3 / 4 * birdHeight / 2,
        fit: BoxFit.fill,
      ),
    );
  }
}
