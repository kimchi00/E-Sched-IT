/* Authored by: Kim Isaiah R. Agao
Company: Random Solutions
Project: E-Sched IT
Feature: [ESIT-004.3] Notifications
Description: Code for the notifications view
 */


import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  String selectedValue = '10 minutes before schedule'; // Default selected value
  String selectedNotificationType = 'Alarm and Notification'; // Default selected notification type

  List<String> options = ['5 minutes before schedule', '10 minutes before schedule', '15 minutes before schedule'];

  @override
  Widget build(BuildContext context) { // Contains all the items for the different notification choices
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Notifications",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(16.0, 50.0, 16.0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              value: selectedValue,
              onChanged: (newValue) {
                setState(() {
                  selectedValue = newValue!;
                });
              },
              items: options.map((option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              decoration: const InputDecoration(
                labelText: 'Notification Time', // Label text for the dropdown
                border: OutlineInputBorder(), // Border for the dropdown field
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Notification Type",
              style: TextStyle(fontSize: 20, height: 3, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                const Expanded(
                  child: Text('Alarm and Notification'),
                ),
                Radio<String>(
                  value: 'Alarm and Notification',
                  groupValue: selectedNotificationType,
                  onChanged: (value) {
                    setState(() {
                      selectedNotificationType = value!;
                    });
                  },
                ),
              ],
            ),
            Row(
              children: [
                const Expanded(
                  child: Text('Alarm Only'),
                ),
                Radio<String>(
                  value: 'Alarm Only',
                  groupValue: selectedNotificationType,
                  onChanged: (value) {
                    setState(() {
                      selectedNotificationType = value!;
                    });
                  },
                ),
              ],
            ),
            Row(
              children: [
                const Expanded(
                  child: Text('Notification Only'),
                ),
                Radio<String>(
                  value: 'Notification Only',
                  groupValue: selectedNotificationType,
                  onChanged: (value) {
                    setState(() {
                      selectedNotificationType = value!;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
