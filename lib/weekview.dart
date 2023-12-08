import 'package:flutter/material.dart';

class WeekView extends StatelessWidget {
  final List<String> daysOfWeek = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  final List<String> timeSlots = [
    '7:00 AM','8:00 AM','9:00 AM', '10:00 AM', 
    '11:00 AM', '12:00 PM',  '1:00 PM','2:00 PM', 
    '3:00 PM',  '4:00 PM', '5:00 PM', '6:00 PM', 
    '7:00 PM',  '8:00 PM', '9:00 PM'
  ];

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
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
            ),
            child: DataTable(
              dataRowHeight: 75.0, 
              columns: [
                DataColumn(label: Text('')),
                ..._buildDayColumns(),
              ],
              rows: _buildTimeRows(),
            ),
          ),
        ),
      ),
    );
  }

  List<DataColumn> _buildDayColumns() {
    return daysOfWeek.map((day) {
      return DataColumn(
        label: Text(day),
      );
    }).toList();
  }

  List<DataRow> _buildTimeRows() {
    return timeSlots.map((time) {
      return DataRow(
        cells: [
          DataCell(Text(time)),
          ..._buildScheduleCells(),
        ],
      );
    }).toList();
  }

  List<DataCell> _buildScheduleCells() {
    return daysOfWeek.map((day) {
     
      return DataCell(
        Text(''),
      );
    }).toList();
  }
}
