import 'package:flutter/material.dart';
import 'package:metro_beom/memo/writememo.dart';
import 'package:metro_beom/provider/mydata.dart';
import 'package:provider/provider.dart';

class Memolist extends StatefulWidget {
  final String classname; // classname 필드 추가
  const Memolist({Key? key, required this.classname}) : super(key: key);
  @override
  State<Memolist> createState() => _MemolistState();
}

bool i = true; //색깔을 반전시키는 변수
bool delete = false;
List<Color> _color = [
  Colors.deepOrange[100]!,
  Colors.red,
  Colors.amber[50]!,
  Colors.black12
];

class _MemolistState extends State<Memolist> {
  late Mydata data;
  late String classname;
  @override
  initState() {
    super.initState();
    classname = widget.classname;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    data = Provider.of<Mydata>(context); // didChangeDependencies에서 초기화
  }

  Widget room(String a) {
    // 메모 리스트 표시
    return Column(
      children: [
        InkWell(
          onTap: () {
            if (delete) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(a)));
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('다음 메모를 삭제합니다'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        //List Body를 기준으로 Text 설정
                        children: <Widget>[
                          Text(a),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.red, // 버튼 배경색
                        ),
                        onPressed: () {
                          data.memodataremove(classname, a);
                          Navigator.of(context).pop();
                        },
                        child: const Text('삭제'),
                      ),
                      TextButton(
                        child: const Text('취소'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            }
          },
          child: Container(
            color: delete
                ? (i ? _color[0] : _color[1])
                : (i ? _color[2] : _color[3]),
            alignment: Alignment.centerLeft,
            child: SizedBox(
              height: 80,
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            a,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.classname),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.delete_forever_sharp,
              color: Colors.red,
            ),
            onPressed: () {
              delete = !delete;
              setState(() {});
            },
          ),
        ],
      ),
      body: ListView(
        children: data.memodatas[widget.classname]!.map((valueList) {
          i = !i;
          return room(valueList[0]);
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: '시간표를 추가합니다',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Writememo(
                      classname: widget.classname,
                    )),
          ).then((_) {
            setState(() {});
          });

          setState(() {});
        },
        child: const Icon(Icons.note_add_outlined),
      ),
    );
  }
}
