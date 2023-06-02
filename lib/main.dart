import 'package:flutter/material.dart';
import 'package:responsi_praktpm/widget/categorypage.dart';
void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
home: CategoryPage()
    );
  }
}
