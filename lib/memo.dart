import 'package:flutter/material.dart';
import 'package:metro_beom/provider/mydata.dart';
import 'package:provider/provider.dart';

class Memo extends StatefulWidget {
  const Memo({super.key});

  @override
  State<Memo> createState() => _MemoState();
}

class _MemoState extends State<Memo> {
  @override
  Widget build(BuildContext context) {
    Mydata data = Provider.of<Mydata>(context);
    return Scaffold(
        body: Center(
      child: Text(
        context.watch<Mydata>().datas.toString(),
      ),
    ));
  }
}
