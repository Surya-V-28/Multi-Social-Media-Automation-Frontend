import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthPicker extends StatefulWidget {
  const MonthPicker({
    super.key,
    required this.month,
    required this.monthChanged,
  }) :
    assert(month >= 1 && month <= 12);

  @override
  State<MonthPicker> createState() => _MonthPickerState();

  final int month;
  final void Function(int value) monthChanged;
}

class _MonthPickerState extends State<MonthPicker> {
  @override
  void initState() {
    super.initState();

    Timer.run(() => _monthLabelPageController.jumpToPage(widget.month - 1));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () => widget.monthChanged((widget.month > 1) ? widget.month - 1 : 12),
          icon: const Icon(Icons.keyboard_arrow_left),
        ),
        
        const SizedBox(width: 8.0),
        
        SizedBox(
          width: 32.0,
          height: 48.0,
          child: PageView.builder(
            controller: _monthLabelPageController,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 12,
            itemBuilder: (context, index) {
              return Center(
                child: Text(
                  _monthLabelFormat.format(DateTime(DateTime.now().year, index + 1, 1)).toUpperCase(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              );
            }
          ),
        ),

        const SizedBox(width: 8.0),

        IconButton(
          onPressed: () => widget.monthChanged((widget.month < 12) ? widget.month + 1 : 1),
          icon: const Icon(Icons.keyboard_arrow_right)
        ),
      ],
    );
  }

  @override
  void didUpdateWidget(covariant MonthPicker oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.month != widget.month) {
      _monthLabelPageController.animateToPage(widget.month - 1, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    }
  }

  final _monthLabelPageController = PageController();
  
  static final DateFormat _monthLabelFormat = DateFormat('MMM');
}
