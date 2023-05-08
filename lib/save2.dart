import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';

class addDialog1 extends StatefulWidget {
  final Function(List<List<dynamic>>) onAdd;
  const addDialog1({Key? key, required this.onAdd}) : super(key: key);

  @override
  State<addDialog1> createState() => _addDialog1State();
}

String classname = '월';
String classday = '월';
List<String> list = <String>['월', '화', '수', '목', '금'];
Map<String, int> map = {'월': 0, '화': 1, '수': 2, '목': 3, '금': 4};

class _addDialog1State extends State<addDialog1> {
  List<List<dynamic>> times = [
    [1, Time(hour: 8, minute: 0), Time(hour: 9, minute: 0)],
    [2, Time(hour: 10, minute: 30), Time(hour: 11, minute: 30)],
    [3, Time(hour: 13, minute: 0), Time(hour: 14, minute: 0)],
  ];
  String formatTimes(List<List<Time>> times) {
    final sb = StringBuffer();
    for (final timeList in times) {
      for (final time in timeList) {
        sb.write('${time.hour}:${time.minute} ${time.period.name} ');
      }
      sb.writeln();
    }
    return sb.toString();
  }

  void onTimeChanged(int outerIndex, int innerIndex, Time newTime) {
    setState(() {
      times[outerIndex][innerIndex] = newTime;
    });
  }

  void addTime() {
    setState(() {
      times.add([
        1,
        Time(hour: 9, minute: 0),
        Time(hour: 10, minute: 0),
      ]);
    });
  }

  void removeTime(int index) {
    setState(() {
      times.removeAt(index);
    });
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
                        onChanged: (text) {},
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
                                                },
                                                minuteInterval:
                                                    TimePickerInterval.FIVE,
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
                                            '${times[outerIndex][1].hour}:${times[outerIndex][1].minute}${times[outerIndex][1].minute < 10 ? "0" : ""}${times[outerIndex][1].hour < 12 ? "am" : "pm"}',

                                            // '${times[outerIndex][0].hour}:${times[outerIndex][0].minute} ${times[outerIndex][0].period.name}',
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
                                                },
                                                minuteInterval:
                                                    TimePickerInterval.FIVE,
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
                                            '${times[outerIndex][2].hour}:${times[outerIndex][2].minute}${times[outerIndex][2].minute < 10 ? "0" : ""}${times[outerIndex][2].hour < 12 ? "am" : "pm"}',

                                            //'${times[outerIndex][1].hour}:${times[outerIndex][1].minute} ${times[outerIndex][1].period.name}',
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
                          SizedBox(
                            width: 10,
                            child: Column(children: const []),
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
                              print("확인 $times");
                              Navigator.of(context).pop(times);
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
                      Text('$times'),
                    ],
                  ),
                ),
              )),
        ),
      );
    });
  }
}
