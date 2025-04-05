import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'customText.dart';

class CustomDatePickerField extends StatefulWidget {
  final TextEditingController controller;
  final bool? isToDate;
  final String hintText;

  const CustomDatePickerField({Key? key, required this.controller, this.isToDate, required this.hintText}) : super(key: key);

  @override
  _CustomDatePickerFieldState createState() => _CustomDatePickerFieldState();
}

class _CustomDatePickerFieldState extends State<CustomDatePickerField> {
  void _showDatePicker() {
    showDialog(
      context: context,
      builder: (context) => CustomDatePicker(
        isToDate: widget.isToDate,
        initialDate:
            widget.controller.text.isNotEmpty ? DateFormat('d MMM y').parse(widget.controller.text) : DateTime.now(),
        onDateSelected: (date) {
          setState(() {
            widget.controller.text = date != null ? DateFormat('d MMM y').format(date) : '';
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showDatePicker,
      child: Container(
        height: 36,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.calendar_today_outlined, color: Colors.blue, size: 20),
                SizedBox(width: 16),
                Text(
                  widget.controller.text.isNotEmpty ? widget.controller.text : widget.hintText,
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
            Icon(Icons.arrow_forward, color: Colors.blue, size: 16),
          ],
        ),
      ),
    );
  }
}

class CustomDatePicker extends StatefulWidget {
  final Function(DateTime?) onDateSelected;
  final DateTime initialDate;
  final bool? isToDate;

  const CustomDatePicker({Key? key, required this.onDateSelected, required this.initialDate, this.isToDate})
      : super(key: key);

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
  }

  void _selectDate(DateTime? date) {
    setState(() => selectedDate = date);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: [
                    if (widget.isToDate == true) ...[
                      _quickSelectButton("No Date", null),
                    ],
                    _quickSelectButton("Today", DateTime.now()),
                    if (widget.isToDate == null) ...[
                      _quickSelectButton("Next Monday", _getNextWeekday(DateTime.monday)),
                      _quickSelectButton("Next Tuesday", _getNextWeekday(DateTime.tuesday)),
                      _quickSelectButton("After 1 Week", DateTime.now().add(Duration(days: 7))),
                    ]
                  ],
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 300,
                child: Theme(
                  data: Theme.of(context).copyWith(colorScheme: ColorScheme.light(primary: Colors.blue)),
                  child: TableCalendar(
                    firstDay: DateTime(2000),
                    lastDay: DateTime(2100),
                    focusedDay: selectedDate ?? DateTime.now(),
                    // fallback if null
                    selectedDayPredicate: (day) => selectedDate != null && isSameDay(day, selectedDate),
                    onDaySelected: (selected, focused) {
                      setState(() {
                        selectedDate = selected;
                      });
                    },
                    rowHeight: 40,
                    headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                      leftChevronIcon: Icon(Icons.arrow_left, color: Colors.grey[700]),
                      rightChevronIcon: Icon(Icons.arrow_right, color: Colors.grey[700]),
                      titleTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[700]),
                    ),
                    calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.blue),
                        color: Colors.transparent,
                      ),
                      selectedDecoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      todayTextStyle: TextStyle(color: Colors.black),
                      selectedTextStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Icon(Icons.calendar_today_outlined, color: Colors.blue, size: 20),
                      ),
                      Visibility(
                          visible: selectedDate!=null,
                          child: CustomText(text: DateFormat('d MMM y').format(selectedDate ?? DateTime.now()))),
                    ],
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Cancel", style: TextStyle(color: Colors.blue)),
                      ),
                      TextButton(
                        onPressed: () {
                          widget.onDateSelected(selectedDate);
                          Navigator.pop(context);
                        },
                        child: Text("Save", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _quickSelectButton(String label, DateTime? date) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue[50],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: () => _selectDate(date),
      child: CustomText(
        text: label,
        color: Colors.blue,
      ),
    );
  }

  DateTime _getNextWeekday(int weekday) {
    DateTime now = DateTime.now();
    int daysUntilNext = (weekday - now.weekday) % 7;
    daysUntilNext = daysUntilNext == 0 ? 7 : daysUntilNext;
    return now.add(Duration(days: daysUntilNext));
  }
}
