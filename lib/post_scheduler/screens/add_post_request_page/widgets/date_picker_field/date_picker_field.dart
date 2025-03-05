import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerField extends StatefulWidget {
  const DatePickerField({super.key, this.firstDate, this.lastDate, required this.value, required this.onChanged, this.decoration});

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();


  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateTime value;
  final void Function(DateTime newValue) onChanged;
  final InputDecoration? decoration;
}

class _DatePickerFieldState extends State<DatePickerField> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Row(
      children: <Widget>[
        Expanded(
          child: InputDecorator(
            decoration: (widget.decoration ?? const InputDecoration()).applyDefaults(theme.inputDecorationTheme),
            child: Text(DateFormat('dd/MM/yyyy').format(widget.value)),
          ),
        ),

        IconButton(
          onPressed: () async {
            final DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: widget.value,
              firstDate: widget.firstDate ?? DateTime(1900),
              lastDate: widget.lastDate ?? DateTime.now(),
            );

            if (pickedDate == null) return;

            widget.onChanged(pickedDate);
          }, 
          icon: const Icon(Icons.edit_calendar),
        ),
      ]
    );
  }
}

