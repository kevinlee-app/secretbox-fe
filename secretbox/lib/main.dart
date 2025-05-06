// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:secretbox/features/game/presentation/pages/home_page.dart';

void main() {
  runApp(const ProviderScope(child: SecretBox()));
}

class SecretBox extends StatelessWidget {
  const SecretBox({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
