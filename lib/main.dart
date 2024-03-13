import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main() {
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: Home()));
}
  //devDiariesWithVee on Instagram
 //devDiariesWithVee on Youtube
 //vaidehi2701 on Github/Linkedin

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double x = 0, y = 0, z = 0;
  double ballPositionX = 120;

  @override
  void initState() {
    gyroscopeEventStream().listen((GyroscopeEvent event) {
      x = event.x;
      y = event.y;
      z = event.z;

      // Adjust sensitivity as needed
      double sensitivity = 8.0; // Increased sensitivity for y-axis movement

      setState(() {
        // Adjust the ball position based on y-axis movement
        ballPositionX += y * sensitivity;

        // Limit the ball position to the screen boundaries
        ballPositionX =
            ballPositionX.clamp(0.0, MediaQuery.of(context).size.width);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/table.png")),
            ),
          ),
          Positioned(
            top: 350,
            left: ballPositionX,
            child: Image.asset(
              'assets/ball.png',
              height: 80,
            ),
          ),
        ],
      ),
    );
  }
}
