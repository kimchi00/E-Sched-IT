/* Authored by: Kim Isaiah R. Agao
Company: Random Solutions
Project: E-Sched IT
Feature: [ESIT-004] Settings
Description: Code for the settings view
 */


import 'package:flutter/material.dart';
import 'notifications.dart';
import 'login.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}


class _SettingsState extends State<Settings> {  // For navigation when the text is pressed
  void _navigateToLoginSignUp() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    print('Navigate to Login/Sign Up');
  }

  void _navigateToGeneral() {
  
    print('Navigate to General');
  }

  void _navigateToNotifications() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Notifications()));
    print('Navigate to Notifications');
  }

  void _navigateToSendFeedback() {

    print('Navigate to Send Feedback');
  }

  @override
  Widget build(BuildContext context) { // contains all the items to be displayed on this particular view
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Settings",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _navigateToGeneral,
              child: const Text(
                "General",
                style: TextStyle(fontSize: 16, height: 3),
              ),
            ),
            GestureDetector(
              onTap: _navigateToNotifications,
              child: const Text(
                "Notifications",
                style: TextStyle(fontSize: 16, height: 3),
              ),
            ),
            GestureDetector(
              onTap: _navigateToSendFeedback,
              child: const Text(
                "Send Feedback",
                style: TextStyle(fontSize: 16, height: 3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
