//수업 리스트를 확인하는 화면
import 'package:flutter/material.dart';
import 'package:metro_beom/provider/mydata.dart';
import 'package:provider/provider.dart';
import 'memolist.dart';

class Memo extends StatelessWidget {
  const Memo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Mydata>(context); // Provider로부터 Mydata 가져오기

    Widget schedule(String a) {
      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Memolist(
                      classname: a,
                    )),
          );
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(a)));
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
                        crossAxisAlignment:
                            CrossAxisAlignment.start, // 글자 왼쪽 정렬
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

    return !data.scheduleloading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            body: ListView(
              children: [
                for (var key in data.datas.keys) schedule(key),
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
