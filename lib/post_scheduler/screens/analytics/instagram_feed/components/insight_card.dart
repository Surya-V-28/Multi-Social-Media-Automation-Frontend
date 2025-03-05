import 'package:flutter/material.dart';

class InsightCard extends StatelessWidget {
  const InsightCard({super.key, required this.name, required this.value,});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(_formattedName(), textAlign: TextAlign.center,),
        
            const SizedBox(height: 16.0),
        
            Text(_formattedValue(), style: theme.textTheme.headlineSmall,),
          ],
        ),
      ),
    );
  }

  String _formattedName() {
    var aName = name.replaceAll('ig_reels_', '');

    return (aName[0].toUpperCase() + aName.substring(1))
      .replaceAll('_', ' ');
  }

  String _formattedValue() {
    const List<String> durationMetrics = [
      'ig_reels_avg_watch_time',
      'ig_reels_video_view_total_time'
    ]; 

    if (durationMetrics.contains(name)) {
      return '${value}s';
    }
    else {
      return value.toString();
    }
  }


  final String name;
  final int value;
}
