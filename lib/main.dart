import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'provider/mydata.dart';

import 'LoginSignupScreen.dart';

void main() async {
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
    return MaterialApp(
      title: 'Note_Beom',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginSignupScreen(),
    );
  }
}
