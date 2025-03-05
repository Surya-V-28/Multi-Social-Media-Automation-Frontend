import 'package:flutter/material.dart';

class Spinner extends StatefulWidget {
  const Spinner({super.key, required this.value});

  @override
  State<Spinner> createState() => _SpinnerState();

  final int value;
}

class _SpinnerState extends State<Spinner> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.keyboard_arrow_left),),

        const SizedBox(width: 8.0),
        
        Text(widget.value.toString()),

        const SizedBox(width: 8.0),
        
        IconButton(onPressed: () {}, icon: const Icon(Icons.keyboard_arrow_right),),
      ]
    );
  }
}
