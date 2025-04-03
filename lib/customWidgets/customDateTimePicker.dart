import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePickerField extends StatefulWidget {
  final TextEditingController controller;

  const CustomDatePickerField({Key? key, required this.controller}) : super(key: key);

  @override
  _CustomDatePickerFieldState createState() => _CustomDatePickerFieldState();
}

class _CustomDatePickerFieldState extends State<CustomDatePickerField> {
  void _showDatePicker() {
    showDialog(
      context: context,
      builder: (context) => CustomDatePicker(
        initialDate: widget.controller.text.isNotEmpty
            ? DateFormat('d MMM y').parse(widget.controller.text)
            : DateTime.now(),
        onDateSelected: (date) {
          setState(() {
            widget.controller.text = DateFormat('d MMM y').format(date);
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
                  widget.controller.text.isNotEmpty ? widget.controller.text : "Select Date",
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
  final Function(DateTime) onDateSelected;
  final DateTime initialDate;

  const CustomDatePicker({Key? key, required this.onDateSelected, required this.initialDate}) : super(key: key);

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
  }

  void _selectDate(DateTime date) {
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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("Select Date", style: TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: [
                    _quickSelectButton("Today", DateTime.now()),
                    _quickSelectButton("Next Monday", _getNextWeekday(DateTime.monday)),
                    _quickSelectButton("Next Tuesday", _getNextWeekday(DateTime.tuesday)),
                    _quickSelectButton("After 1 Week", DateTime.now().add(Duration(days: 7))),
                  ],
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 250,
                child: Theme(
                  data: Theme.of(context).copyWith(colorScheme: ColorScheme.light(primary: Colors.blue)),
                  child: CalendarDatePicker(
                    initialDate: selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    onDateChanged: _selectDate,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
        ),
      ),
    );
  }

  Widget _quickSelectButton(String label, DateTime date) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue.withOpacity(0.1),
        foregroundColor: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: () => _selectDate(date),
      child: Text(label),
    );
  }

  DateTime _getNextWeekday(int weekday) {
    DateTime now = DateTime.now();
    int daysUntilNext = (weekday - now.weekday) % 7;
    daysUntilNext = daysUntilNext == 0 ? 7 : daysUntilNext;
    return now.add(Duration(days: daysUntilNext));
  }
}
