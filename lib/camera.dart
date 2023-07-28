import 'package:flutter/material.dart';
import 'package:metro_beom/provider/mydata.dart';
import 'package:provider/provider.dart';

class Camera extends StatefulWidget {
  const Camera({super.key});

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  @override
  Widget build(BuildContext context) {
    Mydata data = Provider.of<Mydata>(context);
    return Scaffold(
        body: Center(
      child: Text(
        context.watch<Mydata>().memodatas.toString(),
      ),
    ));
  }
}
