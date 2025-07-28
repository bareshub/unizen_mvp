import 'package:flutter/material.dart';
import 'package:flutter_scene/scene.dart';
import 'package:go_router/go_router.dart';
import 'package:unizen/ui/core/ui/unizen_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await Scene.initializeStaticResources();
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(child: const UnizenLogo()),
    );
  }
}
