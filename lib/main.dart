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
      title: 'Web Counter',
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

      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Counter",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              //設定画面へ遷移
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const HelpPage(),
                ),
              );
            }
          )
        ],
      ),

      
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

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("使い方・注意事項"),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Text(
          """
          【使い方】
          ・画面のどこをタップしてもカウントが1増えます。
          ・長押しするとメニューが表示されます。
          
          【使用上の注意】
          ・ページを再読み込みするとカウントは初期化されます。
          ・ブラウザによって長押しの操作が異なる場合があります。
          
          【免責事項】
          ・本アプリの利用によるいかなる損害も、開発者は責任を負いません。
          【プライバシーポリシー】
          【お問い合わせ】
          """,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}