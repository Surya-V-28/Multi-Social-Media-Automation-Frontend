import 'package:flutter/material.dart';

class DateButton extends StatelessWidget {
  const DateButton({super.key, required this.highlighted, required this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(_backgroundColor(theme)),
        elevation: WidgetStateProperty.all(0.0),
        shape: WidgetStateProperty.all(const CircleBorder()),
        padding: WidgetStateProperty.all(const EdgeInsets.all(2.0)),
      ),
      onPressed: onPressed,
      child: child,
    );
  }

  Color _backgroundColor(ThemeData theme) {
    return (highlighted) ? theme.colorScheme.primaryContainer : Colors.transparent;
  }




  final bool highlighted;
  final void Function() onPressed; 
  final Widget child;
}
