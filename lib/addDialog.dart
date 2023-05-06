import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';

class addDialog extends StatefulWidget {
  final Function(String, int, DateTime, DateTime) onAdd;
  const addDialog({Key? key, required this.onAdd}) : super(key: key);

  @override
  State<addDialog> createState() => _addDialogState();
}

class _addDialogState extends State<addDialog> {
  DateTime starttime = DateTime(DateTime.now().hour);

  DateTime endtime = DateTime.now().add(const Duration(hours: 1));

  String classname = '월';
  String classday = '월';
  List<String> list = <String>['월', '화', '수', '목', '금'];

  Map<String, int> map = {'월': 1, '화': 2, '수': 3, '목': 4, '금': 5};

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: AlertDialog(
          // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
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
                    borderRadius: BorderRadius.all(Radius.circular(80)), //둥글게
                  ),
                  filled: true,
                  fillColor: Color.fromARGB(255, 204, 199, 191),
                ),
              ),
              Column(
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
                          // This is called when the user selects an item.
                          setState(() {
                            classday = value1!;
                          });
                        },
                        items:
                            list.map<DropdownMenuItem<String>>((String value) {
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
                            initTime: DateTime.now(),
                            onChange: (dateTime) {
                              starttime = dateTime;
                              // Implement your logic with select dateTime
                            },
                          )),
                      const SizedBox(
                        width: 15,
                      ),
                      Positioned(
                        left: 30,
                        top: 60,
                        child: TimePickerSpinnerPopUp(
                          mode: CupertinoDatePickerMode.time,
                          initTime: DateTime.now(),
                          onChange: (dateTime) {
                            endtime = dateTime;
                            // Implement your logic with select dateTime
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
                              //버튼을 둥글게 처리
                              borderRadius: BorderRadius.circular(10)),
                          foregroundColor: Colors.black,
                          backgroundColor:
                              const Color.fromARGB(255, 61, 184, 225),
                        ),
                        onPressed: () {}, //로그인 함수 호출
                        child: const Text(
                          '추가',
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
                              //버튼을 둥글게 처리
                              borderRadius: BorderRadius.circular(10)),
                          foregroundColor: Colors.black,
                          backgroundColor:
                              const Color.fromARGB(255, 61, 184, 225),
                        ),
                        onPressed: () {
                          widget.onAdd(
                              classname, map[classname]!, starttime, endtime);
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
                              borderRadius: BorderRadius.circular(10)),
                          foregroundColor: Colors.black,
                          backgroundColor:
                              const Color.fromARGB(255, 61, 184, 225),
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
            ],
          ),
        ),
      );
    });
  }
}
