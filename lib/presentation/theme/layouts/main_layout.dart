import 'package:animal_collectables/presentation/theme/decoration.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: scaffoldDecoration,
      child: child,
    );
  }
}
