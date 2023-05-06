import 'dart:math';

import 'package:flutter/material.dart';
import 'package:metro_beom/Appbar.dart';
import 'package:time_planner/time_planner.dart';
import 'addDialog.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

late DateTime starttime;
late DateTime endtime;

class _MyHomePageState extends State<MyHomePage> {
  List<Color?> colors = [
    Colors.purple,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.lime[600]
  ];

  List<TimePlannerTask> tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
        ),
        body: Center(
          child: TimePlanner(
            startHour: 9,
            endHour: 23,
            style: TimePlannerStyle(
              // cellHeight: 30,
              //cellWidth: 60,
              showScrollBar: true,
            ),
            headers: const [
              TimePlannerTitle(
                title: "sunday",
              ),
              TimePlannerTitle(
                title: "monday",
              ),
              TimePlannerTitle(
                title: "tuesday",
              ),
              TimePlannerTitle(
                title: "wednesday",
              ),
              TimePlannerTitle(
                title: "thursday",
              ),
              TimePlannerTitle(
                title: "friday",
              ),
              TimePlannerTitle(
                title: "saturday",
              ),
            ],
            tasks: tasks,
          ),
        ),
        bottomNavigationBar: btmappbar(),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Add random task',
          child: const Icon(Icons.add),
          onPressed: () => showDialog(
            context: context,
            builder: (BuildContext context) {
              return addDialog(
                onAdd: (String className, int classday, DateTime starttime,
                    DateTime endtime) {
                  setState(() {
                    retunrdata(className, classday, starttime, endtime);
                  });
                },

                // onPressed: () => _addObject(context),
              );
            },
          ),
        ));
  }

  List<String> list = <String>['월', '화', '수', '목', '금'];
  String? dropdownValue;
  @override
  void initState() {
    super.initState();
    dropdownValue = list.first;
  }

  void retunrdata(
      String classname, int classday, DateTime starttime, DateTime endtime) {
    setState(() {
      tasks.add(
        TimePlannerTask(
          color: colors[Random().nextInt(colors.length)],
          dateTime: TimePlannerDateTime(
              day: classday, hour: starttime.hour, minutes: starttime.minute),
          minutesDuration: endtime.difference(starttime).inMinutes,
          daysDuration: 1,
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('You click on time planner object')));
          },
          child: Text(
            classname,
            style: TextStyle(color: Colors.grey[350], fontSize: 12),
          ),
        ),
      );
    });
  }
}
