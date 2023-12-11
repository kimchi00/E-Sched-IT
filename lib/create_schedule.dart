import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CreateSchedule extends StatefulWidget {
  @override
  _CreateScheduleState createState() => _CreateScheduleState();
}

class _CreateScheduleState extends State<CreateSchedule> {
  String scheduleName = '';
  String selectedDay = 'Monday';
  String selectedTimeStart = '7:00 AM';
  String selectedTimeEnd = '8:30 AM';
  String abbreviation = '';
  String? place;
  String? groupName;
  String? speaker;
  String? note = '';

  final List<String> daysOfWeek = [
    'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
  ];

  final List<String> timeSlots = [
    '7:00 AM', '7:30 AM', '8:00 AM', '8:30 AM', '9:00 AM', '9:30 AM', '10:00 AM', '10:30 AM',
    '11:00 AM', '11:30 AM', '12:00 PM', '12:30 PM', '1:00 PM', '1:30 PM', '2:00 PM', '2:30 PM',
    '3:00 PM', '3:30 PM', '4:00 PM', '4:30 PM', '5:00 PM', '5:30 PM', '6:00 PM', '6:30 PM',
    '7:00 PM', '7:30 PM', '8:00 PM', '8:30 PM', '9:00 PM',
  ];

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  Future<void> _saveScheduleToLocal(Schedule schedule) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final List<String> savedSchedules = prefs.getStringList('schedules') ?? [];

      savedSchedules.add(scheduleToJson(schedule));
      prefs.setStringList('schedules', savedSchedules);

      _showSnackBar('Schedule saved successfully');
    } catch (e) {
      print('Error saving schedule to local storage: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Create Schedule",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextField(
                onChanged: (value) {
                  setState(() {
                    scheduleName = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Schedule Name'),
              ),
              SizedBox(height: 10),
              TextField(
                onChanged: (value) {
                  setState(() {
                    abbreviation = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Abbreviation'),
              ),
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  DropdownButton<String>(
                    value: selectedDay,
                    onChanged: (newValue) {
                      setState(() {
                        selectedDay = newValue!;
                      });
                    },
                    items: daysOfWeek.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(width: 20),
                  DropdownButton<String>(
                    value: selectedTimeStart,
                    onChanged: (newValue) {
                      setState(() {
                        selectedTimeStart = newValue!;
                      });
                    },
                    items: timeSlots.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(width: 20),
                  DropdownButton<String>(
                    value: selectedTimeEnd,
                    onChanged: (newValue) {
                      setState(() {
                        selectedTimeEnd = newValue!;
                      });
                    },
                    items: timeSlots.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Optional Information',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextField(
                onChanged: (value) {
                  setState(() {
                    place = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Place'),
              ),
              SizedBox(height: 10),
              TextField(
                onChanged: (value) {
                  setState(() {
                    groupName = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Group Name/Section'),
              ),
              SizedBox(height: 10),
              TextField(
                onChanged: (value) {
                  setState(() {
                    speaker = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Speaker'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (scheduleName.isEmpty) {
                    _showSnackBar('Please input a schedule name');
                  } else if (abbreviation.isEmpty) {
                    _showSnackBar('Please input a schedule abbreviation');
                  } else {
                    Schedule newSchedule = Schedule(
                      day: selectedDay,
                      scheduleName: scheduleName,
                      timeStart: selectedTimeStart,
                      timeEnd: selectedTimeEnd,
                      abbreviation: abbreviation,
                      place: place,
                      groupName: groupName,
                      speaker: speaker,
                      note: note,
                    );

                    _saveScheduleToLocal(newSchedule);
                    Navigator.of(context).pop(newSchedule);
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      return const Color(0xFFD9D9D9);
                    },
                  ),
                  foregroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      return Colors.black;
                    },
                  ),
                ),
                child: Text('Create Schedule'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String scheduleToJson(Schedule schedule) {
  final Map<String, dynamic> data = {
    'day': schedule.day,
    'scheduleName': schedule.scheduleName,
    'timeStart': schedule.timeStart,
    'timeEnd': schedule.timeEnd,
    'abbreviation': schedule.abbreviation,
    'place': schedule.place,
    'groupName': schedule.groupName,
    'speaker': schedule.speaker,
    'note': schedule.note,
  };

  return jsonEncode(data);
}

class Schedule {
  String day;
  String scheduleName;
  String timeStart;
  String timeEnd;
  String abbreviation;
  String? place;
  String? groupName;
  String? speaker;
  String? note;

  Schedule({
    required this.day,
    required this.scheduleName,
    required this.timeStart,
    required this.timeEnd,
    required this.abbreviation,
    this.place,
    this.groupName,
    this.speaker,
    this.note,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      day: json['day'],
      scheduleName: json['scheduleName'],
      timeStart: json['timeStart'],
      timeEnd: json['timeEnd'],
      abbreviation: json['abbreviation'],
      place: json['place'],
      groupName: json['groupName'],
      speaker: json['speaker'],
      note: json['note'],
    );
  }
}
