import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'create_schedule.dart';
import 'settings.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'notes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  List<Schedule> schedules = await loadSchedulesFromLocalStorage();
  runApp(
    MaterialApp(
      home: DayView(schedules),
    ),
  );
}

Schedule scheduleFromJson(String jsonString) {
  final Map<String, dynamic> data = jsonDecode(jsonString);

  return Schedule(
    day: data['day'],
    scheduleName: data['scheduleName'],
    timeStart: data['timeStart'],
    timeEnd: data['timeEnd'],
    abbreviation: data['abbreviation'],
    place: data['place'],
    groupName: data['groupName'],
    speaker: data['speaker'],
  );
}

Future<List<Schedule>> loadSchedulesFromLocalStorage() async {
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> savedSchedules = prefs.getStringList('schedules') ?? [];
    return savedSchedules.map((jsonString) => scheduleFromJson(jsonString)).toList();
  } catch (e) {
    print('Error loading schedules from local storage: $e');
    return [];
  }
}

class DayView extends StatefulWidget {
  final List<Schedule> schedules;

  DayView(this.schedules);

  @override
  _DayViewState createState() => _DayViewState();
}

class _DayViewState extends State<DayView> {
  List<String> daysOfWeek = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
  List<Color> scheduleColors = [Color(0xFFACBEA3), Color(0xFF40476D), Color(0xFF826754), Color(0xFFAD5D4E), Color(0xFF57B8FF)];
  int colorIndex = 0;

  int getCurrentDayIndex() {
    int currentDayIndex = DateTime.now().weekday - 1;
    return currentDayIndex < 0 ? 6 : currentDayIndex;
  }

  Future<void> saveSchedulesToLocalStorage(List<Schedule> schedules) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final List<String> savedSchedules = schedules.map((schedule) => scheduleToJson(schedule)).toList();
      prefs.setStringList('schedules', savedSchedules);
    } catch (e) {
      print('Error saving schedules to local storage: $e');
    }
  }

  void _showSnackBar(String message, Schedule? schedule) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));

    if (schedule != null) {
      setState(() {
        widget.schedules.add(schedule);
        saveSchedulesToLocalStorage(widget.schedules);
      });
    }
  }

    void _deleteSchedule(Schedule schedule) {
    setState(() {
      widget.schedules.remove(schedule);
      saveSchedulesToLocalStorage(widget.schedules);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "E-Sched IT",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: CarouselSlider(
                items: daysOfWeek.map((day) {
                  return Center(
                    child: Column(
                      children: [
                        Text(
                          day,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Column(
                          children: widget.schedules
                              .where((schedule) => schedule.day == day)
                              .map((schedule) {
                            Color currentColor = scheduleColors[colorIndex];
                            colorIndex = (colorIndex + 1) % scheduleColors.length;

                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5.0),
                              child: Container(
                                padding: EdgeInsets.all(1.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: currentColor,
                                ),
                                child: Column(
                                  children: [
                                    ExpansionTile(
                                      title: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                schedule.timeStart,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                schedule.timeEnd,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: 16),
                                          Expanded(
                                            child: Text(
                                              schedule.scheduleName,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 15,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              if (schedule.abbreviation != null) Text(
                                                'Abbreviation: ${schedule.abbreviation}',
                                                style: const TextStyle(color: Colors.white,),
                                              ) else const Text(
                                                'Abbreviation: N/A',
                                                style: TextStyle(color: Colors.white,),
                                              ) , 
                                              SizedBox(height: 10),
                                              if (schedule.place != null) Text(
                                                'Place: ${schedule.place}',
                                                style: const TextStyle(color: Colors.white,),
                                              )else const Text(
                                                'Place: N/A',
                                                style: TextStyle(color: Colors.white,),
                                              ) ,
                                              SizedBox(height: 10),
                                              if (schedule.groupName != null) Text(
                                                'Group Name: ${schedule.groupName}',
                                                style: const TextStyle(color: Colors.white,),
                                              )else const Text(
                                                'Group Name: N/A',
                                                style: TextStyle(color: Colors.white,),
                                              ) ,
                                              SizedBox(height: 10),
                                              if (schedule.speaker != null) Text(
                                                'Speaker: ${schedule.speaker}',
                                                style: const TextStyle(color: Colors.white,),
                                              )else const Text(
                                                'Speaker: N/A',
                                                style: TextStyle(color: Colors.white,),
                                              ) ,
                                              Align(
                                                alignment: Alignment.centerRight,
                                                child: IconButton(
                                                  color: Colors.white,
                                                  icon: Icon(Icons.delete),
                                                    onPressed: () {
                                                      _deleteSchedule(schedule);
                                                    },
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        )
                      ],
                    ),
                  );
                }).toList(),
                options: CarouselOptions(
                  height: 1000,
                  viewportFraction: 1,
                  enableInfiniteScroll: true,
                  initialPage: getCurrentDayIndex(),
                  reverse: false,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: const Color(0xFFD9D9D9),
        child: ButtonBar(
          alignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Settings()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () async {
                Schedule? newSchedule = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateSchedule()),
                );

                if (newSchedule != null) {
                  _showSnackBar('Schedule created: ${newSchedule.scheduleName}', newSchedule);
                } else {
                  print('User exited without entering schedule data.');
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.note),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Notes()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
