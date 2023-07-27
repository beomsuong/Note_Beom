//기본 화면
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:metro_beom/weekcalendar.dart';
import 'memo/memo.dart';
import 'provider/mydata.dart';
import 'package:provider/provider.dart';
import 'camera.dart';

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
  await FlutterConfig.loadEnvVariables();
  await Firebase.initializeApp();
  FlutterConfig.get('apiKey'); //API 키 가져오기

  runApp(
    ChangeNotifierProvider(
      create: (context) => Mydata(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    //각 페이지 이동 시 사용하는 리스트형 위젯 각 페이지 클래스를 실행한다
    const Weekcalendar(), //시간표 화면
    const Memo(), //메모화면
    const Camera() //카메라 화면
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
        automaticallyImplyLeading: false,
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
