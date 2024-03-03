import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class HomeSreen extends StatefulWidget {
  const HomeSreen({super.key});

  @override
  State<HomeSreen> createState() => _HomeSreenState();
}

class _HomeSreenState extends State<HomeSreen> {
  double x = 0, y = 0, z = 0;
  double ballPositionX = 140;
  double ballPositionY = 140;

  @override
  void initState() {
    gyroscopeEventStream().listen((GyroscopeEvent event) {
      x = event.x;
      y = event.y;
      z = event.z;

      // Adjust sensitivity as needed
      double sensitivity = 0.8;

      setState(() {
        // Adjust the ball position based on x-axis rotation
        ballPositionX += x * sensitivity;
        ballPositionY += y * sensitivity;

        // Limit the ball position to the screen boundaries
        ballPositionX =
            ballPositionX.clamp(0.0, MediaQuery.of(context).size.width - 0.0);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image:
                    DecorationImage(image: AssetImage("assets/table.png")),
              ),
            ),
            Positioned(
              left: ballPositionX,
              // top: ballPositionY,
              child: Image.asset(
                'assets/ball.png',
                height: 80,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
