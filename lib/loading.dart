//파이어베이스 로딩을 위한 대기화면
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Changed from 'flutter_provider' to 'provider'
import 'package:metro_beom/MyHomePage.dart';
import 'package:metro_beom/provider/mydata.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key); // Fixed key declaration

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 4),
      () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MyHomePage()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Mydata data = Provider.of<Mydata>(context); // Moved Provider.of here

    return Container(
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0.0,
            left: 0.0,
            child: SizedBox(
              width: width,
              height: height,
              child: const Scaffold(
                backgroundColor: Colors.transparent,
                body: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
