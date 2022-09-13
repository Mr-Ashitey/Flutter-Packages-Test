import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({Key? key}) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime currentDate = DateTime.now();
  TimeOfDay currentTime = TimeOfDay.now();
  DateTimeRange recordedDateRange = DateTimeRange(
      start: DateTime.now(), end: DateTime.now().add(const Duration(days: 1)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Date Time Picker')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(formattedDate(currentDate)),
            ElevatedButton.icon(
                onPressed: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: currentDate,
                    firstDate: firstDate,
                    lastDate: lastDate,
                  );

                  if (selectedDate != null) {
                    setState(() {
                      currentDate = selectedDate;
                    });
                  }
                },
                icon: const Icon(Icons.date_range_rounded),
                label: const Text('Pick Date')),
            Text(
                '${currentTime.hour.toString().padLeft(2, '0')}:${currentTime.minute.toString().padLeft(2, '0')} ${currentTime.period.name}'),
            ElevatedButton.icon(
                onPressed: () async {
                  final selectedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );

                  if (selectedTime != null) {
                    setState(() {
                      currentTime = selectedTime;
                    });
                  }
                },
                icon: const Icon(Icons.timer_sharp),
                label: const Text('Pick Time')),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('From: ${formattedDate(recordedDateRange.start)}'),
                Text('To: ${formattedDate(recordedDateRange.end)}'),
              ],
            ),
            ElevatedButton.icon(
                onPressed: () async {
                  final selectedDateRange = await showDateRangePicker(
                    context: context,
                    firstDate: firstDate,
                    lastDate: lastDate,
                    initialDateRange: recordedDateRange,
                  );

                  if (selectedDateRange != null) {
                    setState(() {
                      recordedDateRange = selectedDateRange;
                    });
                  }
                },
                icon: const Icon(Icons.date_range_rounded),
                label: const Text('Pick Date Range')),
          ],
        ),
      ),
    );
  }

  DateTime get firstDate =>
      DateTime(DateTime.now().year - 20); // 20 years before current date
  DateTime get lastDate =>
      DateTime(DateTime.now().year + 20); // 20 years before current date

  String formattedDate(DateTime date) {
    return date.toLocal().toString().split(" ")[0];
  }
}
