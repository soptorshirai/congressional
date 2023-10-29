import 'dart:async';

import 'package:club_app/screens/chosen_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation = Tween(begin: 0.0, end: 6.0).animate(_controller);
    _controller.forward();

    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => const ChosenButton(),
      ));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SpinKitFadingCube spinkit;
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(color: Colors.white),
      //     gradient: LinearGradient(colors: [
      //   Color.fromARGB(255, 213, 215, 151),
      //   Color.fromARGB(255, 186, 186, 101),
      //   Color.fromARGB(255, 158, 138, 65)
      // ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: Center(
        child: FadeTransition(
            opacity: _animation,
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 100,
                ),
                Text("HeartyApp",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade300,
                    )),
                const SizedBox(
                  height: 150,
                ),
                spinkit = SpinKitFadingCube(
                  color: Colors.orange.shade300,
                  size: 50.0,
                )
              ],
            )),
      ),
    ));
  }
}

class HomeScreens extends StatelessWidget {
  const HomeScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Screen',
          style: TextStyle(color: Colors.red),
        ),
        backgroundColor: Colors.orange,
      ),
      body: const Center(
        child: Text('Welcome to the Home Screen!'),
      ),
    );
  }
}
