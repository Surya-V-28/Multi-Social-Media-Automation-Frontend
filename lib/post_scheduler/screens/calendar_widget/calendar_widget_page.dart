import 'package:flutter/material.dart';
import 'package:post_scheduler/post_scheduler/screens/post_requests_calendar_page/widgets/calendar/calendar.dart';

class CalendarWidgetPage extends StatefulWidget {
  const CalendarWidgetPage({super.key});

  @override
  State<CalendarWidgetPage> createState() => _CalendarWidgetPageState();
}

class _CalendarWidgetPageState extends State<CalendarWidgetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calendar')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Calendar(
              year: _year,
              onYearChanged: (value) => setState(() => _year = value),
              month: _month,
              onMonthChanged: (value) => setState(() => _month = value),
              itemBuilder: (date) {
                return DateButton(
                  highlighted: false,
                  onPressed: () {},
                  child: Text(date.day.toString()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }


  
  int _year = DateTime.now().year;
  int _month = DateTime.now().month;
}
