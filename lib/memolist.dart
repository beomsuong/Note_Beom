import 'package:flutter/material.dart';

import 'package:metro_beom/provider/mydata.dart';
import 'package:provider/provider.dart';

class Memolist extends StatefulWidget {
  final String classname; // classname 필드 추가
  const Memolist({Key? key, required this.classname}) : super(key: key);

  @override
  State<Memolist> createState() => _MemolistState();
}

class _MemolistState extends State<Memolist> {
  @override
  Widget room(String a) {
    // 톡방을 리스트로 보여주는 함수
    return Center(
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(a)));
        },
        child: SizedBox(
          height: 80,
          child: Padding(
            padding: const EdgeInsets.only(top: 8), // 톡방 간 간격
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // 글자 왼쪽 정렬
                      children: [
                        Text(
                          a,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                          // 톡방 제목은 굵게
                        ),
                        const Text('가장최근 메모가 나오게 할거에요'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  late String classname;
  @override
  initState() {
    super.initState();
    classname = widget.classname;
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Mydata>(context); // Provider로부터 Mydata 가져오기

    return Scaffold(
      body: ListView(
        children: [
          for (String key in data.memodatas[classname]!) room(key),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: '시간표를 추가합니다',
        onPressed: () {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('메모를 추가합니다')));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
