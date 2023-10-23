/* Authored by: Kim Isaiah R. Agao
Company: Random Solutions
Project: E-Sched IT
Feature: [ESIT-003] Create Schedule
Description: Code for the create scedule view, allow users to create schedules
 */



import 'package:flutter/material.dart';

class CreateSchedule extends StatefulWidget {
  @override
  _CreateScheduleState createState() => _CreateScheduleState();
}

class _CreateScheduleState extends State<CreateSchedule> {
  String scheduleName = '';
  String selectedDay = 'Monday';
  String selectedTimeStart = '7:00 AM';    // Pre-defined choices for the user
  String selectedTimeEnd = '8:30 AM';
  String abbreviation = '';
  String place = '';
  String groupName = '';
  String speaker = '';

  final List<String> daysOfWeek = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

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

  @override
  Widget build(BuildContext context) { // Contains all the items for the create schedule view
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Create Schedule",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.close),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
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
                  abbreviation = value;
                });
              },
              decoration: InputDecoration(labelText: 'Abbreviation'),
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
                onPressed: () {
                  if (scheduleName.isEmpty) {
                    _showSnackBar('Please input a schedule name');
                  } else {
                    // Check for other required fields and handle the form submission here
                    print('Schedule Name: $scheduleName');
                    print('Day: $selectedDay');
                    print('Time Start: $selectedTimeStart');
                    print('Time End: $selectedTimeEnd');
                    print('Abbreviation: $abbreviation');
                    print('Place: $place');
                    print('Group Name/Section: $groupName');
                    print('Speaker: $speaker');
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      return const Color(0xFFD9D9D9); // Set button color here
                    },
                  ),
                  foregroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      return Colors.black; // Set text color here
                    },
                  ),
                ),
                child: Text('Create Schedule'),
              ),
          ],
        ),
      ),
    );
  }
}



class Schedule {
  final String scheduleName;
  final String timeStart;
  final String timeEnd;

  Schedule({
    required this.scheduleName,
    required this.timeStart,
    required this.timeEnd,
  });
}
