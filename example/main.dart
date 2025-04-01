import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_sized_list_view/flutter_sized_list_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: TestView());
  }
}

class TestView extends StatefulWidget {
  const TestView({super.key});

  @override
  State<TestView> createState() => _TestViewState();
}

class _TestViewState extends State<TestView> {
  List<double> items = List.generate(10000, (index) => 30 + Random().nextInt(30).toDouble());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedListView.builder(
          sizeBuilder: (constraints, index) {
            return Size(constraints.crossAxisExtent, items[index]);
          },
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Container(
              color: index % 2 == 0 ? Colors.red : Colors.blue,
              height: items[index],
            );
          },
        ),
      ),
    );
  }
}