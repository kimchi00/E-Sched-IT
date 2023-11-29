import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'create_schedule.dart';
import 'settings.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      home: DayView(),
    ),
  );
}

class DayView extends StatefulWidget {
  @override
  _DayViewState createState() => _DayViewState();
}

class _DayViewState extends State<DayView> {
  List<String> daysOfWeek = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
  List<Schedule> schedules = [];
  List<Color> scheduleColors = [Color(0xFFACBEA3), Color(0xFF40476D), Color(0xFF826754), Color(0xFFAD5D4E),Color(0xFFD1B1CB), Color(0xFF57B8FF) ];
  int colorIndex = 0;

  // Function to get the index of the current day
  int getCurrentDayIndex() {
    int currentDayIndex = DateTime.now().weekday - 1; // Adjusting to zero-based index
    return currentDayIndex < 0 ? 6 : currentDayIndex; // Sunday is 0, Monday is 1, ..., Saturday is 6
  }

  void _showSnackBar(String message, Schedule? schedule) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));

    if (schedule != null) {
      setState(() {
        schedules.add(schedule);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                          children: schedules
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
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                schedule.timeStart,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Text(
                                                schedule.timeEnd,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black,
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
                                              if (schedule.abbreviation != null) Text('${schedule.abbreviation}'),
                                              SizedBox(height: 10),
                                              if (schedule.place != null) Text('${schedule.place}'),
                                              SizedBox(height: 10),
                                              if (schedule.groupName != null) Text('${schedule.groupName}'),
                                              SizedBox(height: 10),
                                              if (schedule.speaker != null) Text('${schedule.speaker}'),
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
                  initialPage: getCurrentDayIndex(), // Set initial page to the current day index
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
              icon: const Icon(Icons.calendar_today),
              onPressed: () {},
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
