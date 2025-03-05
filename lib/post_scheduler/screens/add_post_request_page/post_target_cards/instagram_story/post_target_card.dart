import 'package:flutter/material.dart';
import '../../view_model/add_post_request_page_view_model.dart';

import '../details_ui_state.dart';
import '../post_target_card_ui_state.dart';

class InstagramStoryPostTargetCard extends StatefulWidget {
  const InstagramStoryPostTargetCard({
    super.key,
    required this.uiState,
    required this.viewModel,
  });

  @override
  State<InstagramStoryPostTargetCard> createState() => _InstagramStoryPostTargetCardState();


  final PostTargetCardUiState uiState;
  final AddPostRequestPageViewModel viewModel;
}

class _InstagramStoryPostTargetCardState extends State<InstagramStoryPostTargetCard> {
  @override
  Widget build(BuildContext context) {
    final details = widget.uiState.details as InstagramStoryPostTargetDetailsUiState;

    final information =
    '''
Platform Connection Id: ${widget.uiState.platformConnectionId}
User Id: ${details.userId}
    ''';

    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Instagram Story', style: theme.textTheme.headlineMedium),

                    IconButton(
                      onPressed: () {
                        widget.viewModel.targetRemoved(widget.uiState.id);
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ]
              ),

              const SizedBox(height: 32.0),

              Text(information),
            ]
        ),
      ),
    );
  }
}
