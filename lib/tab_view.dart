import 'package:flutter/material.dart';

class TabView extends StatelessWidget {
  const TabView(this.child, {Key? key}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}