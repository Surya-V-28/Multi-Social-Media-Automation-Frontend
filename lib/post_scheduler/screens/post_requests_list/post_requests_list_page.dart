import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:post_scheduler/post_scheduler/screens/scheduled_post_details_page/scheduled_post_details_page.dart';
import 'package:post_scheduler/utils/option.dart';

import 'package:post_scheduler/utils/side_effect.dart';
import '../../common/widgets/post_request_list_tile/post_request_list_tile.dart';
import 'view_model/ui_state/post_request_ui_state.dart';
import 'view_model/ui_state/ui_state.dart';
import 'view_model/view_model.dart';
import 'view_model/view_model_factory.dart';

class PostRequestsListPage extends StatefulWidget {
  const PostRequestsListPage({super.key, required this.date});

  @override
  State<PostRequestsListPage> createState() => _PostRequestsListPageState();

  final DateTime date;
}

class _PostRequestsListPageState extends State<PostRequestsListPage> {
  @override
  void initState() {
    super.initState();

    _navigationSideEffect = SideEffect<Option<String?>>(
      observee: _viewModel.uiState
        .map( (value) => (value is LoadedPostRequestsListPageUiState) ? Option(value.navigateToPost) : const Option(null) ),
      doWhen: (previousValue, currentValue) {
        if (previousValue == null) return false;
        
        return previousValue.value != currentValue.value && currentValue.value != null;
      },
      sideEffect: (value) {
        final Route route = MaterialPageRoute(builder: (context) => ScheduledPostDetailsPage(value.value!));
        Navigator.of(context).push(route);

        _viewModel.navigatedToPost();
      }
    );

    _viewModel.pageOpened(widget.date);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PostRequestsListPageUiState>(
      stream: _viewModel.uiState,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Text(_dateFormat.format(widget.date)),
          ),
          body: _buildBody(),
        );
      }
    );
  }

  Widget _buildBody() {
    final ThemeData theme = Theme.of(context);

    if (_viewModel.uiState.value is InitialLoadingPostRequestsListPageUiState) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final loadedUiState = _viewModel.uiState.value as LoadedPostRequestsListPageUiState;

    return CustomScrollView(
      slivers: <Widget>[
        const SliverToBoxAdapter(child: SizedBox(height: 16.0)),

        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          sliver: SliverToBoxAdapter(
            child: Text('Scheduled Posts', style: theme.textTheme.headlineMedium)
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 32.0)),

        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          sliver: SliverList.separated(
            itemCount: loadedUiState.postRequests.length,
            itemBuilder: (context, index) {
              final PostRequestUiState postRequest = loadedUiState.postRequests[index];

              return PostRequestListTile(
                scheduledDateTime: postRequest.scheduledDateTime,
                isFulfilled: postRequest.fulfilled,
                caption: postRequest.caption,
                platforms: postRequest.platforms.toList(),
                onTap: () => _viewModel.postRequestClicked(postRequest.id),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 16.0),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 16.0)),
      ]
    );
  }

  @override
  void dispose() {
    _navigationSideEffect.dispose();

    super.dispose();
  }


  final PostRequestsListPageViewModel _viewModel = GetIt.instance<PostRequestsListPageViewModelFactory>().build();

  final DateFormat _dateFormat = DateFormat("dd/MM/yyyy");

  late final SideEffect _navigationSideEffect;
}
