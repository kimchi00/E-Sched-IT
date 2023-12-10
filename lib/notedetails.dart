import 'package:flutter/material.dart';
import 'create_schedule.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class NoteDetailsScreen extends StatefulWidget {
  final Schedule schedule;
  final List<Schedule> schedules;

  NoteDetailsScreen(this.schedule, this.schedules);

  @override
  _NoteDetailsScreenState createState() => _NoteDetailsScreenState();
}

class _NoteDetailsScreenState extends State<NoteDetailsScreen> {
  late TextEditingController _noteController;

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController(text: widget.schedule.note);
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void saveSchedulesToLocalStorage(List<Schedule> schedules) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final List<String> savedSchedules = prefs.getStringList('schedules') ?? [];

      // Update the schedule in the list if it already exists
      for (int i = 0; i < savedSchedules.length; i++) {
        final Schedule savedSchedule = Schedule.fromJson(jsonDecode(savedSchedules[i]));

        if (savedSchedule.scheduleName == widget.schedule.scheduleName) {
          savedSchedules[i] = scheduleToJson(widget.schedule);
          break; // Exit the loop once the schedule is updated
        }
      }

      prefs.setStringList('schedules', savedSchedules);
    } catch (e) {
      print('Error saving schedules to local storage: $e');
    }
  }


void _saveNotes() {
  // Update the note in the existing schedule
  widget.schedule.note = _noteController.text;

  // Save the updated schedule to local storage
  saveSchedulesToLocalStorage(widget.schedules);
}


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Save the notes when the back button is pressed
        _saveNotes();
        return true; // Allow the screen to be popped
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            widget.schedule.scheduleName,
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: GestureDetector(
          onTap: () {
            _noteController.selection =
                TextSelection.fromPosition(TextPosition(offset: _noteController.text.length));
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.schedule.abbreviation,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Day: ${widget.schedule.day}',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 10),
                Text(
                  'Time: ${widget.schedule.timeStart} - ${widget.schedule.timeEnd}',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 10),
                if (widget.schedule.place != null)
                  Text(
                    'Place: ${widget.schedule.place}',
                    style: const TextStyle(color: Colors.black, fontSize: 18.0),
                  )
                else
                  const Text(
                    'Place: N/A',
                    style: TextStyle(color: Colors.black, fontSize: 18.0),
                  ),
                SizedBox(height: 10),
                if (widget.schedule.groupName != null)
                  Text(
                    'Group Name: ${widget.schedule.groupName}',
                    style: const TextStyle(color: Colors.black, fontSize: 18.0),
                  )
                else
                  const Text(
                    'Group Name: N/A',
                    style: TextStyle(color: Colors.black, fontSize: 18.0),
                  ),
                SizedBox(height: 10),
                if (widget.schedule.speaker != null)
                  Text(
                    'Speaker: ${widget.schedule.speaker}',
                    style: const TextStyle(color: Colors.black, fontSize: 18.0),
                  )
                else
                  const Text(
                    'Speaker: N/A',
                    style: TextStyle(color: Colors.black, fontSize: 18.0),
                  ),
                Divider(
                  color: Colors.black,
                  thickness: 1,
                  height: 20,
                ),
                SizedBox(height: 16.0),
                // Editable notes section
                TextField(
                  controller: _noteController,
                  decoration: InputDecoration(
                    hintText: 'Add/Edit Notes',
                    border: InputBorder.none,
                  ),
                  cursorColor: Colors.black,
                  maxLines: null,
                  onEditingComplete: () {
                    _saveNotes();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
