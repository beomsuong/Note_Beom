import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:metro_beom/memo.dart';
import 'package:metro_beom/weekcalendar.dart';

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables(); // 추가
  await Firebase.initializeApp();

  FlutterConfig.get('apiKey');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class GradientText extends StatelessWidget {
  const GradientText({super.key});
  @override
  Widget build(BuildContext context) {
    return Text(
      'CouserMic',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        foreground: Paint()
          ..shader = const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue, Color.fromARGB(142, 141, 5, 187)],
          ).createShader(
            const Rect.fromLTWH(50.0, 0.0, 200.0, 0.0),
          ),
      ),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    //각 페이지 이동 시 사용하는 리스트형 위젯 각 페이지 클래스를 실행한다
    const Weekcalendar(),
    const Memo(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('범짱브리타임'),
        centerTitle: true,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '시간표',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note_alt_outlined),
            label: '메모하기',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: '사진',
          ),
        ],
      ),
    );
  }
}
