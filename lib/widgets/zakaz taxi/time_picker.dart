import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../screens/settings.dart';

class TimePickerInput extends StatefulWidget {
  final String label;
  final String hint;
  final IconData icon;

  const TimePickerInput({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
  });

  @override
  _TimePickerInputState createState() => _TimePickerInputState();
}

class _TimePickerInputState extends State<TimePickerInput> {
  TextEditingController _controller = TextEditingController();
  String selectedTime = '';

  // Function to show Cupertino time picker
  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showCustomCupertinoTimePicker(context);
    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime.format(context); // Update the selected time
        _controller.text = selectedTime; // Update the controller text
      });
    }
  }

  // Function to get current time in GMT +5 format
  String _getCurrentTimeInGMTPlus5() {
    DateTime currentTime = DateTime.now()
        .toUtc()
        .add(const Duration(hours: 5)) // GMT +5 timezone adjustment
        .add(const Duration(minutes: 30)); // Add 30 minutes
    return '${currentTime.hour.toString().padLeft(2, '0')}:${currentTime.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label.tr(),
          style: TextStyle(
            fontSize: 14,
            color: currentindex == 0 ? Colors.black54 : Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _controller,
          readOnly: true,
          onTap: () => _selectTime(context),
          decoration: InputDecoration(
            hintText: selectedTime.isEmpty
                ? _getCurrentTimeInGMTPlus5()
                : selectedTime, // Show current time if none selected
            filled: true,
            prefixIcon: Icon(widget.icon),
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Future<TimeOfDay?> showCustomCupertinoTimePicker(BuildContext context) async {
    TimeOfDay selectedTime = TimeOfDay(hour: 12, minute: 30);

    int selectedHour = selectedTime.hour;
    int selectedMinute = selectedTime.minute;

    return await showModalBottomSheet<TimeOfDay>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          height: 300,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                "Выберите время".tr(),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Hour picker
                    Expanded(
                      child: CupertinoPicker(
                        scrollController: FixedExtentScrollController(
                            initialItem: selectedHour),
                        itemExtent: 40,
                        onSelectedItemChanged: (int index) {
                          selectedHour = index;
                        },
                        children: List.generate(24, (index) {
                          return Center(
                            child: Text(
                              index.toString().padLeft(2, '0'),
                              style: const TextStyle(fontSize: 24),
                            ),
                          );
                        }),
                      ),
                    ),
                    const Text(
                      ":",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    // Minute picker
                    Expanded(
                      child: CupertinoPicker(
                        scrollController: FixedExtentScrollController(
                            initialItem: selectedMinute),
                        itemExtent: 40,
                        onSelectedItemChanged: (int index) {
                          selectedMinute = index;
                        },
                        children: List.generate(60, (index) {
                          return Center(
                            child: Text(
                              index.toString().padLeft(2, '0'),
                              style: const TextStyle(fontSize: 24),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context,
                      TimeOfDay(hour: selectedHour, minute: selectedMinute));
                },
                overlayColor: const WidgetStatePropertyAll(Colors.transparent),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xFFFF7625),
                  ),
                  child: Text(
                    "Готово".tr(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
