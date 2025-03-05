import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'date_button.dart';
import 'month_picker.dart';

export 'date_button.dart';

class Calendar extends StatefulWidget {
  const Calendar({
    super.key,
    required this.year,
    required this.onYearChanged,
    required this.month,
    required this.onMonthChanged,
    required this.itemBuilder,
  }) :
    assert(month >= 1 && month <= 12);

  @override
  State<Calendar> createState() => _CalendarState();

  final int year;
  final void Function(int value) onYearChanged;
  final int month;
  final void Function(int value) onMonthChanged;
  final DateButton Function(DateTime date) itemBuilder;
}

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(_yearLabelFormat.format(DateTime(widget.year, 1)), style: theme.textTheme.headlineLarge,),

            MonthPicker(month: widget.month, monthChanged: (value) => setState(() => widget.onMonthChanged(value)),),
          ],
        ),

        const SizedBox(height: 8.0),

        const Divider(),

        const SizedBox(height: 8.0),

        Table(
          children: <TableRow>[
            _buildDaysRow(),
        
            ..._buildTableRows(),
          ],
        ),
      ],
    );
  }

  TableRow _buildDaysRow() {
    return TableRow(
      children: _daysOfTheWeek
        .map(
          (element) => TableCell(
            child: Text(
              element.substring(0, 3),
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            )
          )
        )
        .toList(),
    );
  }

  List<TableRow> _buildTableRows() {
    final int monthDayCount = DateUtils.getDaysInMonth(widget.year, widget.month);
    final int rowOneEmptySlotCount = _rowOneEmptySlotsCount();


    final List<TableRow> tableRows = <TableRow>[];
    List<TableCell> rowCells = List<TableCell>.filled(rowOneEmptySlotCount, _emptyTableCell, growable: true);


    for (int i = 0; i < monthDayCount; ++i) {
      if (rowCells.length == 7) {
        tableRows.add(TableRow(children: rowCells));

        rowCells = List<TableCell>.empty(growable: true);
      }

      final DateTime date = _monthsFirstDate().add(Duration(days: i));
      rowCells.add( _buildDateTableCell(child: widget.itemBuilder(date)) );
    }

    if (rowCells.isNotEmpty) {
      final int emptyCellCount = 7 - rowCells.length;
      for (int i = 0; i < emptyCellCount; ++i) {
        rowCells.add(_emptyTableCell);
      }
      tableRows.add(TableRow(children: rowCells));
    }

    return tableRows;
  }

  int _rowOneEmptySlotsCount() {
    final DateTime monthsDayOneDate = _monthsFirstDate();
    final String monthsDayOneName = DateFormat('EEEE').format(monthsDayOneDate);

    return _daysOfTheWeek.indexOf(monthsDayOneName);
  }

  DateTime _monthsFirstDate() {
    return DateTime(DateTime.now().year, DateTime.now().month, 1);
  }

  static TableCell _buildDateTableCell({required Widget child}) {
    return TableCell(
      child: child,
    );
  }



  static const List<String> _daysOfTheWeek = <String>["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
  static final TableCell _emptyTableCell = _buildDateTableCell(child: const SizedBox.shrink());
  static final _yearLabelFormat = DateFormat('yyyy');
}
