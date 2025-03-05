import 'package:business_logic/business_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';

import 'components/insight_card.dart';

part 'view_model.dart';

class InstagramFeedAnalyticsPage extends HookWidget {
  const InstagramFeedAnalyticsPage({super.key, required this.postId, required this.postTargetId});

  @override
  Widget build(BuildContext context) {
    final viewModel = useViewModel(postId, postTargetId);
    
    useEffect(
      () {
        viewModel.pageOpened();

        return null;
      },
      []
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Instagram Feed Analytics')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
        ),
        itemCount: viewModel.mediaInsights.length,
        itemBuilder: (context, index) {
          final mediaInsight = viewModel.mediaInsights[index];
          return InsightCard(name: mediaInsight.name, value: mediaInsight.value);
        },
      ),
    );
  }

  final String postId;
  final String postTargetId;
}