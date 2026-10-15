import 'package:intent/menu.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ScreenServer());
}

class ScreenServer extends StatelessWidget {
  const ScreenServer({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: const LamanScreenServer(),
    );
  }
}

class LamanScreenServer extends StatefulWidget {
  const LamanScreenServer({super.key});

  @override
  State<LamanScreenServer> createState() => _LamanScreenServerState();
}

class _LamanScreenServerState extends State<LamanScreenServer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.5, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HalamanHome()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'lib/assets/image/gambar2.png',
                height: 180,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.school, size: 130, color: Colors.white);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
