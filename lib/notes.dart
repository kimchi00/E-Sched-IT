import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'create_schedule.dart';
import 'notedetails.dart';

class Notes extends StatefulWidget {
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  List<Schedule> schedules = [];
  int colorIndex = 0;
  List<Color> scheduleColors = [
    Color(0xFFACBEA3),
    Color(0xFF40476D),
    Color(0xFF826754),
    Color(0xFFAD5D4E),
    Color(0xFF57B8FF),
  ];

  @override
  void initState() {
    super.initState();
    loadSchedules();
  }

  Future<void> loadSchedules() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final List<String> savedSchedules = prefs.getStringList('schedules') ?? [];
      setState(() {
        schedules = savedSchedules
            .map((jsonString) => Schedule.fromJson(jsonDecode(jsonString)))
            .toList();
      });
    } catch (e) {
      print('Error loading schedules in Notes: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Notes",
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
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: schedules.length,
        itemBuilder: (BuildContext context, int index) {
          return buildNoteCard(context, schedules[index]);
        },
      ),
    );
  }

  Widget buildNoteCard(BuildContext context, Schedule schedule) {
    Color currentColor = scheduleColors[colorIndex];
    colorIndex = (colorIndex + 1) % scheduleColors.length;

    return InkWell(
      onTap: () {
        _showNoteDetailsScreen(context, schedule);
      },
      child: Card(
        elevation: 4.0,
        margin: EdgeInsets.all(8.0),
        color: currentColor,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                schedule.scheduleName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Day: ${schedule.day}',
                style: TextStyle(fontSize: 14.0, color: Colors.white),
              ),
              Text(
                'Time: ${schedule.timeStart} - ${schedule.timeEnd}',
                style: TextStyle(fontSize: 14.0, color: Colors.white),
              ),
              SizedBox(height: 8.0),
              // Display additional information if available
              if (schedule.note != null && schedule.note!.isNotEmpty)
                Text(
                  'Note: ${schedule.note}',
                  style: TextStyle(fontSize: 14.0, color: Colors.white),
                ),
              // Add more details or customize as needed
            ],
          ),
        ),
      ),
    );
  }

  void _showNoteDetailsScreen(BuildContext context, Schedule schedule) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoteDetailsScreen(schedule, schedules),
      ),
    );
  }
}
