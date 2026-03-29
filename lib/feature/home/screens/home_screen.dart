import 'package:flutter/material.dart';
import 'package:flutter_setup_riverpod/shared/widgets/screen_wrapper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const ScreenWrapper(child: Placeholder()),
    );
  }
}
