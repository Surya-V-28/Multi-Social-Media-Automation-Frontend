import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimePickerField extends StatefulWidget {
  const TimePickerField({super.key, required this.value, required this.onChanged, this.decoration});

  @override
  State<TimePickerField> createState() => _TimePickerFieldState();


  final DateTime value;
  final void Function(DateTime newValue) onChanged;
  final InputDecoration? decoration;
}

class _TimePickerFieldState extends State<TimePickerField> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Row(
      children: <Widget>[
        Expanded(
          child: InputDecorator(
            decoration: (widget.decoration ?? const InputDecoration()).applyDefaults(theme.inputDecorationTheme),
            child: Text(DateFormat('hh:mm a').format(widget.value)),
          ),
        ),

        IconButton(
          onPressed: () async {
            final TimeOfDay? pickedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.fromDateTime(widget.value),
            );

            if (pickedTime == null) return;

            widget.onChanged(DateTime(0, 0, 0, pickedTime.hour, pickedTime.minute));
          }, 
          icon: const Icon(Icons.timer),
        ),
      ]
    );
  }
}
