import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:post_scheduler/platform_connection/screens/platform_connections/widgets/platform_connection_tile.dart';
import 'package:post_scheduler/utils/side_effect.dart';
import 'package:post_scheduler/utils/string_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'view_model/ui_state.dart';
import 'view_model/view_model.dart';
import 'view_model/view_model_factory.dart';

class PlatformConnectionsPage extends StatefulWidget {
  const PlatformConnectionsPage({super.key});

  @override
  State<PlatformConnectionsPage> createState() => _PlatformConnectionsPageState();
}

class _PlatformConnectionsPageState extends State<PlatformConnectionsPage> {
  factory _PlatformConnectionsPageState() {
    final viewModel = GetIt.instance<PlatformConnectionsPageViewModelFactory>().build();

    final addMenuController = MenuController();


    return _PlatformConnectionsPageState._(
      viewModel,
      addMenuController,
      SideEffect(
        observee: viewModel.uiState.map((event) => event.navigatingToOAuthUrl),
        doWhen: (previousState, currentState) => currentState != previousState,
        sideEffect: (state) {
    // initialLocation: '/analytics/facebook-page/random-post-id',
          launchUrl(state!);
          viewModel.navigatedToOAuthUrl();
        },
      ),
      SideEffect(
        observee: viewModel.uiState.map((event) => event.isAddMenuOpen),
        doWhen: (previous, current) => current != previous,
        sideEffect: (isOpen) {
          //if (isOpen) {
          //  addMenuController.open();
          //}
          //else {
          //  addMenuController.close();
          //}
        },
      ),
    );
  }

  _PlatformConnectionsPageState._(this._viewModel, this._addMenuController, this._navigateToOAuthUrlSideEffect, this._isAddMenuOpenSideEffect);

  @override
  void initState() {
    super.initState();

    _viewModel.pageOpened();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _viewModel.uiState,
      initialData: _viewModel.uiState.value,
      builder: (context, snapshot) {
        final uiState = snapshot.data!;

        final theme = Theme.of(context);

        return Stack(
          children: [
            DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: AppBar(
                  title: const Text('Connect Your Socials',),
                  //actions: [
                  //  MenuAnchor(
                  //    controller: _addMenuController,
                  //    menuChildren: [
                  //      MenuItemButton(child: const Text('Facebook'), onPressed: () => _viewModel.addPlatformConnectionButtonClicked(SocialMediaPlatform.facebook,),),
                  //
                  //      MenuItemButton(child: const Text('Instagram'), onPressed: () => _viewModel.addPlatformConnectionButtonClicked(SocialMediaPlatform.instagram,),),
                  //    ],
                  //    builder: (context, controller, child) {
                  //      return IconButton(onPressed: () => _viewModel.addButtonClicked(), icon: const Icon(Icons.add));
                  //    },
                  //    onClose: () => _viewModel.addMenuDismissed(),
                  //  ),
                  //],
                  bottom: const TabBar(
                    tabs: [
                      Tab(text: 'All Profiles'),
                      Tab(text: 'Connected'),
                    ]
                  ),
                ),
                body: TabBarView(
                  children: [
                    for (int i = 0; i < 2; ++i)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0,),
                            child: Text('SOCIAL PROFILES', style: theme.textTheme.headlineSmall),
                          ),
                                
                          Expanded(
                            child: ListView.separated(
                              //itemCount: uiState.platformConnections.length,
                              itemCount: uiState.platformConnections.length,
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0,),
                              itemBuilder: (context, index) {
                                return PlatformConnectionTile(
                                  platform: uiState.platformConnections[index].platform,
                                  username: uiState.platformConnections[index].name,
                                  connected: (index == 0),
                                );

                                return _buildPlatformConnectionListTile(uiState.platformConnections[index],);
                              },
                              separatorBuilder: (context, index) => const SizedBox(height: 16.0),
                            ),
                          ),
                        ],
                      )
                  ],
                ),
                floatingActionButton: ElevatedButton(
                  onPressed: () {}, 
                  child: const Text('Connect Account')
                ),
                floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              ),
            ),

            if (uiState.isLoading)
              SizedBox.expand(
                child: ColoredBox(
                  color: Colors.black.withValues(alpha: 0.5,),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
          ],
        );
      }
    );
  }

  @override
  void dispose() {
    _navigateToOAuthUrlSideEffect.dispose();
    _isAddMenuOpenSideEffect.dispose();

    super.dispose();
  }

  //Widget _buildPlatformConnectionListTile(PlatformConnectionListItemUiState uiState) {
  //  return Card(
  //    child: ListTile(
  //      leading: uiState.platform.let((platform) {
  //        return switch (platform) {
  //          SocialMediaPlatform.facebook => const Icon(FontAwesomeIcons.facebook, size: 32.0,),
  //          SocialMediaPlatform.instagram => const Icon(FontAwesomeIcons.instagram, size: 32.0,),
  //          // _ => throw Error(),
  //        };
  //      }),
  //      title: Text(uiState.platform.toString().toSentenceCase(),),
  //      subtitle: Text(uiState.name),
  //      trailing: IconButton(onPressed: () => _viewModel.deleteButtonClicked(uiState.id), icon: const Icon(Icons.delete),)
  //    ),
  //  );
  //}

  Widget _buildPlatformConnectionListTile(PlatformConnectionListItemUiState uiState) {
    return Card(
      child: ListTile(
        title: Text(uiState.platform.toString().toSentenceCase(),),
        subtitle: Text(uiState.name),
        trailing: IconButton(onPressed: () => _viewModel.deleteButtonClicked(uiState.id), icon: const Icon(Icons.delete),)
      ),
    );
  }


  final PlatformConnectionsPageViewModel _viewModel;

  final SideEffect<Uri?> _navigateToOAuthUrlSideEffect;
  final SideEffect<bool> _isAddMenuOpenSideEffect;


  final MenuController _addMenuController;
}
