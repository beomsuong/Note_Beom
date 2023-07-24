import 'package:flutter/material.dart';
import 'package:metro_beom/provider/mydata.dart';
import 'package:provider/provider.dart';
import 'memolist.dart';

class Memo extends StatefulWidget {
  const Memo({Key? key}) : super(key: key);

  @override
  State<Memo> createState() => _MemoState();
}

class _MemoState extends State<Memo> {
  Widget room(String a) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Memolist(
                    classname: a,
                  )),
        );
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(a)));
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Add this line
        children: [
          SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // 글자 왼쪽 정렬
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          a,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        // Text(data.memodatas[a]!.last.toString()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // const Divider(color: Colors.black, thickness: 1), // 수평 선
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Mydata>(context); // Provider로부터 Mydata 가져오기

    return Scaffold(
      body: ListView(
        children: [
          for (var key in data.datas.keys) room(key),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: '시간표를 추가합니다',
        onPressed: () {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('메모를 추가합니다')));
        },
        child: const Icon(Icons.note_add_outlined),
      ),
    );
  }
}
