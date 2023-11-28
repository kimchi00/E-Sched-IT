/* Authored by: Kim Isaiah R. Agao
Company: Random Solutions
Project: E-Sched IT
Feature: [ESIT-001] Day View
Description: This file contains the main.dart along with the home page which is the day view
 */


import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'create_schedule.dart';
import 'settings.dart';
import 'CustomExpansionTile.dart';

void main() {
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

  void _showSnackBar(String message, Schedule? schedule) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
  ));

  if (schedule != null) {
    setState(() {
      // Add the new schedule to the list
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
          CarouselSlider(
            items: daysOfWeek.map((day) {
              return Center(
                child: Column(
                  children: [
                    Text(
                      day,
                      style: const TextStyle(fontSize: 16),
                    ),
                    // Display schedules for the current day
                    Column(
                      children: schedules
                        .where((schedule) => schedule.day == day)
                        .map((schedule) => ExpansionTile(
                          title: Text(schedule.scheduleName),
                          subtitle: Text('${schedule.timeStart} - ${schedule.timeEnd}'),
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (schedule.abbreviation != null) Text('Abbreviation: ${schedule.abbreviation}'),
                                  SizedBox(height: 10),
                                  if (schedule.place != null) Text('Place: ${schedule.place}'),
                                  SizedBox(height: 10),
                                  if (schedule.groupName != null) Text('Group Name/Section: ${schedule.groupName}'),
                                  SizedBox(height: 10),
                                  if (schedule.speaker != null) Text('Speaker: ${schedule.speaker}'),
                                ],
                              ),
                            ),
                          ],
                        ))
                        .toList(),
                    ),
                  ],
                ),
              );
            }).toList(),
            options: CarouselOptions(
              height: 1000,
              viewportFraction: 1,
              enableInfiniteScroll: true,
              // Enable infinite scrolling
              initialPage: daysOfWeek.length,
              // Start at the middle to create an infinite loop
              reverse: false,
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
                  // Handle the case where the user exited without entering data
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