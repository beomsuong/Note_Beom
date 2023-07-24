import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';

class addDialog extends StatefulWidget {
  final Function(Map<String, List<List<dynamic>>>) onAdd;
  const addDialog({Key? key, required this.onAdd}) : super(key: key);

  @override
  State<addDialog> createState() => _addDialog1State();
}

Map<String, List<List<dynamic>>> returndata = {};
String classname = '수업명을 입력하세요';
String classday = '월'; //기본 요일
List<String> list = <String>['월', '화', '수', '목', '금']; // 요일 저장 변수
Map<String, int> map = {'월': 0, '화': 1, '수': 2, '목': 3, '금': 4};

//요일을 int로 변환하기 위한 map
class _addDialog1State extends State<addDialog> {
  List<List<dynamic>> times = [
    //시간 저장 변수
    [0, Time(hour: 9, minute: 0), Time(hour: 10, minute: 0)],
  ];

  void onTimeChanged(int outerIndex, int innerIndex, Time newTime) {
    setState(() {
      times[outerIndex][innerIndex] = newTime;
    });
  }

  void addTime() {
    //시간 추가 함수
    setState(() {
      times.add([
        0,
        Time(hour: 9, minute: 0),
        Time(hour: 10, minute: 0),
      ]);
    });
  }

  void removeTime(int index) {
    //시간 삭제 함수
    setState(() {
      times.removeAt(index);
    });
  }

  void convertdata() {
    //데이터를 넘길 시 저장된 데이터 형식을 변환하여 넘기는 변수
    returndata[classname] ??= [];
    for (List<dynamic> time in times) {
      List<dynamic> convertedTime = [
        time[0],
        time[1].hour,
        time[1].minute,
        (time[2].hour - time[1].hour) * 60 + (time[2].minute - time[1].minute)
      ];
      returndata[classname]?.add(convertedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return GestureDetector(
        onTap: () {
          //키보드를 꺼내고 따른 곳을 누르면 바로 키보드가 사라지게 위해 추가
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: AlertDialog(
                content: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextField(
                        onChanged: (text) {
                          classname = text;
                        },
                        decoration: const InputDecoration(
                          labelText: '수업을 입력하세요',
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
                      SingleChildScrollView(
                        child: Column(
                          children: List.generate(
                            times.length,
                            (outerIndex) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      DropdownButton<String>(
                                        value: list[times[outerIndex][0]],
                                        icon: const Icon(Icons.arrow_downward),
                                        elevation: 16,
                                        style: const TextStyle(
                                            color: Colors.deepPurple),
                                        underline: Container(
                                          height: 2,
                                          color: Colors.deepPurpleAccent,
                                        ),
                                        onChanged: (String? value1) {
                                          setState(() {
                                            times[outerIndex][0] = map[value1]!;
                                          });
                                        },
                                        items: list
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                      const SizedBox(height: 5.0),
                                      SizedBox(
                                        width: 75.0,
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                              showPicker(
                                                showSecondSelector: false,
                                                context: context,
                                                value: times[outerIndex][1],
                                                onChange: (newTime) {
                                                  onTimeChanged(
                                                      outerIndex, 1, newTime);

                                                  if (times[outerIndex][1]
                                                          .hour <
                                                      22) {
                                                    //22시보다 적으면 그냥 종료 시간에 +1
                                                    times[outerIndex][2] = Time(
                                                      hour: times[outerIndex][1]
                                                              .hour +
                                                          1,
                                                      minute: times[outerIndex]
                                                              [1]
                                                          .minute,
                                                    );
                                                  } else {
                                                    times[outerIndex][2] = Time(
                                                        hour: 23, minute: 59);
                                                  }
                                                },
                                                minuteInterval:
                                                    TimePickerInterval.ONE,
                                                // Optional onChange to receive value as DateTime
                                                onChangeDateTime: (dateTime) {
                                                  debugPrint(
                                                      "[debug datetime]: $dateTime");
                                                },
                                              ),
                                            );
                                          },
                                          style: TextButton.styleFrom(
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                          ),
                                          child: Text(
                                            '${times[outerIndex][1].hour}:${times[outerIndex][1].minute < 10 ? "0" : ""}${times[outerIndex][1].minute}${times[outerIndex][1].hour < 12 ? "am" : "pm"}',
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      const Text(
                                        ' ~ ',
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                      const SizedBox(height: 5.0),
                                      SizedBox(
                                        width: 75,
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                              showPicker(
                                                showSecondSelector: false,
                                                context: context,
                                                value: times[outerIndex][2],
                                                onChange: (newTime) {
                                                  onTimeChanged(
                                                      outerIndex, 2, newTime);
                                                  if (times[outerIndex][2]
                                                          .hour >
                                                      1) {
                                                    //22시보다 적으면 그냥 종료 시간에 +1
                                                    times[outerIndex][1] = Time(
                                                      hour: times[outerIndex][2]
                                                              .hour -
                                                          1,
                                                      minute: times[outerIndex]
                                                              [1]
                                                          .minute,
                                                    );
                                                  } else {
                                                    times[outerIndex][1] = Time(
                                                        hour: 00, minute: 00);
                                                  }
                                                  if (times[outerIndex][2] ==
                                                      Time(
                                                          hour: 00,
                                                          minute: 00)) {
                                                    times[outerIndex][2] = Time(
                                                        hour: 0, minute: 1);
                                                  }
                                                },
                                                minuteInterval:
                                                    TimePickerInterval.ONE,
                                                // Optional onChange to receive value as DateTime
                                                onChangeDateTime: (dateTime) {
                                                  debugPrint(
                                                      "[debug datetime]: $dateTime");
                                                },
                                              ),
                                            );
                                          },
                                          style: TextButton.styleFrom(
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                          ),
                                          child: Text(
                                            '${times[outerIndex][2].hour}:${times[outerIndex][2].minute < 10 ? "0" : ""}${times[outerIndex][2].minute}${times[outerIndex][2].hour < 12 ? "am" : "pm"}',
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 15.0),
                                  IconButton(
                                    onPressed: () {
                                      removeTime(outerIndex);
                                    },
                                    icon: const Icon(Icons.delete),
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
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
                              backgroundColor:
                                  const Color.fromARGB(255, 61, 184, 225),
                            ),
                            onPressed: () {
                              addTime();
                            },
                            child: const Text(
                              '추가',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                            child: Column(children: []),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                //버튼을 둥글게 처리
                                borderRadius: BorderRadius.circular(10),
                              ),
                              foregroundColor: Colors.black,
                              backgroundColor:
                                  const Color.fromARGB(255, 61, 184, 225),
                            ),
                            onPressed: () {
                              convertdata();
                              widget.onAdd(returndata);
                              Navigator.of(context).pop();
                              //returndata.clear();
                            },
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
                ),
              )),
        ),
      );
    });
  }
}
