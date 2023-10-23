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

  @override
  Widget build(BuildContext context) { // An infinite carousel that displays the days of the week along with the created schedules, as of 10/9/2023, still just a skeletal structure
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "E-Sched IT",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true, 
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          CarouselSlider(
            items: daysOfWeek.map((day) {
              return Center(
                child: Text(
                  day,
                  style: const TextStyle(fontSize: 16),
                ),
              );
            }).toList(),
            options: CarouselOptions(
              height: 40, 
              viewportFraction: 1, 
              enableInfiniteScroll: true, // Enable infinite scrolling
              initialPage: daysOfWeek.length, // Start at the middle to create an infinite loop
              reverse: false, 
            ),
          ),
        ],
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateSchedule()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.calendar_today),
              onPressed: () {
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

