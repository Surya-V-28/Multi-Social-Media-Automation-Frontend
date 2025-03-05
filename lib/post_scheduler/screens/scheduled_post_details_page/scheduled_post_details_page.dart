import 'package:business_logic/business_logic.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:post_scheduler/utils/side_effect.dart';

import 'view_model.dart';
import 'view_model_factory.dart';
import 'ui_state.dart';

class ScheduledPostDetailsPage extends StatefulWidget {
  const ScheduledPostDetailsPage(this.id, {super.key});

  @override
  State<ScheduledPostDetailsPage> createState() => _ScheduledPostDetailsPageState();

  final String id;
}

class _ScheduledPostDetailsPageState extends State<ScheduledPostDetailsPage> {
  @override
  void initState() {
    super.initState();

    _viewModel = GetIt.instance<ScheduledPostDetailsPageViewModelFactory>()
      .build(widget.id)
      ..pageOpened();

    _navigateToStatisticsPageSideEffect = SideEffect(
      observee: _viewModel.uiState.map((uiState) => uiState.navigatingToPostTargetUrl),
      doWhen: (previous, current) => previous != current && current != null,
      sideEffect: (url) {
        GoRouter.of(context).push(url!);
        _viewModel.navigatedToPostTargetStatisticsPage();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return StreamBuilder(
      stream: _viewModel.uiState,
      initialData: _viewModel.uiState.value,
      builder: (context, snapshot) {
        final uiState = snapshot.data!;
        
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(title: const Text('Scheduled Post')),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('id: ${uiState.id}'),
                    
                    const SizedBox(height: 32.0,),
                
                    Text('Targets', style: theme.textTheme.headlineSmall,),

                    const SizedBox(height: 16.0,),
                
                    Column(
                      children: uiState.postTargets
                          .map(_buildPostTargetListTile)
                          .toList(),
                    ),
                  ]
                ),
              )
            ),


            if (uiState.isLoading)
              const Positioned.fill(
                child: ColoredBox(
                  color: Color(0x55000000),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
          ],
        );
      }
    );
  }

  Widget _buildPostTargetListTile(PostTargetUiState uiState) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: ListTile(
        onTap: () => _viewModel.postTargetButtonClicked(uiState.id),
        leading: Icon(
          switch (uiState.type.platform) {
            SocialMediaPlatform.facebook => FontAwesomeIcons.facebook,
            SocialMediaPlatform.instagram => FontAwesomeIcons.instagram,
          }
        ),
        title: Text(uiState.type.displayForm),
      ),
    );
  }

  @override
  void dispose() {
    _navigateToStatisticsPageSideEffect.dispose();

    super.dispose();
  }



  late final ScheduledPostDetailsPageViewModel _viewModel;
  late final SideEffect<String?> _navigateToStatisticsPageSideEffect;
}
