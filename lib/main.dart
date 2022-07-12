import 'dart:ui';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      title: 'Flutter',
      home: LoginPage(),
    );
  }
}

class CountPage extends StatefulWidget {
  const CountPage({Key? key}) : super(key: key);

  @override
  State<CountPage> createState() => _CountPageState();
}

class _CountPageState extends State<CountPage> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox.fromSize(
          size: const Size(double.infinity, 16),
        ),
        Text(
          "$count",
          style: const TextStyle(fontSize: 16, color: Colors.green),
        ),
        SizedBox.fromSize(
          size: const Size(double.infinity, 16),
        ),
        TextButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.red.shade400)),
            onPressed: () {
              setState(() {
                count++;
              });
            },
            child: const Text("+")),
        const LinearProgressIndicator(
          value: .9,
          valueColor: AlwaysStoppedAnimation(Colors.green),
          backgroundColor: Colors.red,
        ),
        SizedBox.fromSize(
          size: const Size(double.infinity, 16),
        ),
        const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.orange),
        ),
      ],
    );
  }
}

class ClickDemo extends StatelessWidget {
  const ClickDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("TAP");
      },
      onDoubleTap: () {
        print("DoubleTap");
      },
      onLongPress: () {
        print("LongPress");
      },
      child: const Text("很长很长 没有点击事件"),
    );
  }
}
