import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';
import 'package:intl/intl.dart';

class addDialog extends StatefulWidget {
  final Function(String, int, DateTime, int) onAdd;
  const addDialog({Key? key, required this.onAdd}) : super(key: key);

  @override
  State<addDialog> createState() => _addDialogState();
}

int i = 1;

class _addDialogState extends State<addDialog> {
  DateTime starttime =
      DateTime(2023, 10, 3, 9, 0); //DateTime(DateTime.now().hour);
  @override
  void initState() {
    timeWidgets.add(addtime());
  }

  DateTime endtime = DateTime(
      2023, 10, 3, 10, 0); //DateTime.now().add(const Duration(hours: 1));

  String classname = '월';
  String classday = '월';
  List<String> list = <String>['월', '화', '수', '목', '금'];
  Map<String, int> map = {'월': 0, '화': 1, '수': 2, '목': 3, '금': 4};
  List<Widget> timeWidgets = [];
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: AlertDialog(
          // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          //Dialog Main Title
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                onChanged: (text) {
                  setState(() {
                    classname = text;
                  });
                },
                decoration: const InputDecoration(
                  labelText: '수업 이름',
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(80),
                    ), //둥글게
                  ),
                  filled: true,
                  fillColor: Color.fromARGB(255, 204, 199, 191),
                ),
              ),
              Column(
                children: [
                  Column(children: timeWidgets),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        foregroundColor: Colors.black87,
                        backgroundColor: Colors.red),
                    onPressed: () {
                      setState(() {
                        // 버튼 비활성화

                        // timeWidgets.removeAt(timeWidgets.indexOf());
                        //timeWidgets.removeLast();
                      });
                    },
                    child: const Text(
                      '삭제',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      foregroundColor: Colors.black,
                      backgroundColor: const Color.fromARGB(255, 61, 184, 225),
                    ),
                    onPressed: timeWidgets.length >= 5
                        ? null
                        : () {
                            setState(() {
                              // 버튼 비활성화
                              timeWidgets.add(addtime());
                            });
                          },
                    child: const Text(
                      '추가',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                    child: Column(children: [
                      Text(DateFormat('HH:mm').format(starttime)),
                    ]),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        //버튼을 둥글게 처리
                        borderRadius: BorderRadius.circular(10),
                      ),
                      foregroundColor: Colors.black,
                      backgroundColor: const Color.fromARGB(255, 61, 184, 225),
                    ),
                    onPressed: () {
                      widget.onAdd(
                        classname,
                        map[classday]!,
                        starttime,
                        endtime.difference(starttime).inMinutes,
                      );
                      Navigator.of(context).pop();
                    }, //로그인 함수 호출
                    child: const Text(
                      '확인',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        //버튼을 둥글게 처리
                        borderRadius: BorderRadius.circular(10),
                      ),
                      foregroundColor: Colors.black,
                      backgroundColor: const Color.fromARGB(255, 61, 184, 225),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }, //로그인 함수 호출
                    child: const Text(
                      '종료',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  int i = 0;
  List<int> q = [1, 2, 3, 4];
  void delet() {
    setState(() {
      i++;
      timeWidgets.removeLast();
      print(i);
    });
  }

  @override
  Widget addtime() {
    int i = timeWidgets.length - 1;
    DateTime? nowstarttime = starttime;
    DateTime? nowendtime = endtime;
    endtime = endtime.add(const Duration(hours: 2));
    starttime = starttime.add(const Duration(hours: 2));

    return SizedBox(
      child: Column(
        children: [
          Row(
            children: [
              DropdownButton<String>(
                value: classday,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? value1) {
                  setState(() {
                    classday = value1!;
                  });
                },
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              Positioned(
                left: 30,
                top: 60,
                child: TimePickerSpinnerPopUp(
                  mode: CupertinoDatePickerMode.time,
                  initTime: starttime,
                  onChange: (dateTime) {
                    setState(() {
                      starttime = dateTime;
                    });
                  },
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Positioned(
                left: 30,
                top: 60,
                child: TimePickerSpinnerPopUp(
                  mode: CupertinoDatePickerMode.time,
                  initTime: endtime,
                  onChange: (dateTime) {
                    setState(() {
                      starttime = dateTime;
                    });
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    foregroundColor: Colors.black87,
                    backgroundColor: Colors.red),
                onPressed: () {
                  setState(() {
                    print(endtime);

                    //delet();
                    // 버튼 비활성화
                    //timeWidgets.removeLast();
                    // timeWidgets.removeAt(timeWidgets.indexOf());
                    //timeWidgets.removeLast();
                  });
                },
                child: const Text(
                  '삭제',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
