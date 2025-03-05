import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class FacebookPageAnalyticsPage extends StatefulWidget {
  const FacebookPageAnalyticsPage({super.key, required this.postId,});

  @override
  State<FacebookPageAnalyticsPage> createState() => _FacebookPageAnalyticsPageState();


  final String postId;
}

class _FacebookPageAnalyticsPageState extends State<FacebookPageAnalyticsPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Facebook Page Post Analytics')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildStatisticCard(),
                  ),
        
                  const SizedBox(width: 8.0,),
          
                  Expanded(
                    child: _buildStatisticCard(),
                  ),
                ]
              ),
        
              const SizedBox(height: 8.0,),
        
              Row(
                children: [
                  Expanded(
                    child: _buildStatisticCard(),
                  ),
        
                  const SizedBox(width: 8.0,),
          
                  Expanded(
                    child: _buildStatisticCard(),
                  ),
                ]
              ),

              const SizedBox(height: 16.0,),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Interactions', style: theme.textTheme.headlineSmall,),

                      const SizedBox(height: 32.0,),

                      SizedBox(
                        height: 256.0,
                        child: Transform.translate(
                          offset: const Offset(-12, 0),
                          child: LineChart(
                            LineChartData(
                              minX: 20.0,
                              minY: 0.0,
                              maxX: 40.0,
                              maxY: 500,
                              titlesData: const FlTitlesData(
                                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false,),),
                                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false,),),
                                bottomTitles: AxisTitles(),
                              ),
                              lineBarsData: [
                                LineChartBarData(
                                  spots: [
                                    const FlSpot(20, 0),
                                    const FlSpot(25, 180),
                                    const FlSpot(35, 250),
                                    const FlSpot(40, 500),
                                  ],
                                  color: Colors.blue,
                                  isCurved: true,
                                  dotData: const FlDotData(show: false),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }

  Widget _buildStatisticCard() {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.thumb_up, color: Colors.blue),

            const SizedBox(height: 2.0,),

            const Text('Likes'),

            const SizedBox(height: 4.0,),

            Text('30,654', style: theme.textTheme.headlineSmall),

            const SizedBox(height: 8.0,),

            const Row(
              children: [
                Icon(Icons.arrow_drop_up, color: Colors.green,),

                SizedBox(width: 4.0,),

                Text('+12.08%', style: TextStyle(color: Colors.green,),),
              ],
            ),

            const Text('than last week', style: TextStyle(color: Colors.grey,)),
          ]
        ),
      ),
    );
  }
}
