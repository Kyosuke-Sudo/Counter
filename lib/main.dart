import 'package:flutter/material.dart';

void main() {
  runApp(const CounterApp());
}

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Counter',
      theme: ThemeData.dark(),
      home: const CounterPage(),
    );
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int count = 0;

  void _showMenu(BuildContext context, Offset position) async {
    final selected = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy,
        position.dx,
        position.dy,
      ),
      items: const [
        PopupMenuItem(
          value: 'reset',
          child: Text('リセット'),
        ),
        PopupMenuItem(
          value: 'minus',
          child: Text('-1'),
        ),
        PopupMenuItem(
          value: 'plus10',
          child: Text('+10'),
        ),
      ],
    );

    if (selected == null) return;

    setState(() {
      switch (selected) {
        case 'reset':
          count = 0;
          break;
        case 'minus':
          count--;
          break;
        case 'plus10':
          count += 10;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,

        // タップでカウント
        onTap: () {
          setState(() {
            count++;
          });
        },

        // 長押しでメニュー
        onLongPressStart: (details) {
          _showMenu(context, details.globalPosition);
        },

        child: Center(
          child: Text(
            '$count',
            style: const TextStyle(
              fontSize: 100,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}