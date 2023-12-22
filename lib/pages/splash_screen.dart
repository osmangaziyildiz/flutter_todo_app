import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_todo_application/constants/constants.dart';
import 'package:flutter_todo_application/pages/to_do_app.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    _animationController = AnimationController(
        vsync: this, duration: const Duration(seconds: 3), value: 0);

    _animation = Tween(begin: 0, end: 100).animate(_animationController);

    _animation.addStatusListener((_) {
      if (_animationController.isCompleted) {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: SystemUiOverlay.values);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) {
            return const ToDoApp();
          },
        ));
      }
    });
    _animation.addListener(() {
      setState(() {});
    });

    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'To Do App',
              style: Constants.splashScreenText,
            ),
            Image.asset('assets/splash_screen_logo.png'),
            CircularProgressIndicator(
              value: _animationController.value,
              color: Colors.amber,
            ),
          ],
        ),
      ),
    );
  }
}
