import 'package:business_logic/business_logic.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AddFacebookPagePostTargetDialog extends StatefulWidget {
  const AddFacebookPagePostTargetDialog({ super.key });

  @override
  State<AddFacebookPagePostTargetDialog> createState() => _AddFacebookPagePostTargetDialogState();
}

class _AddFacebookPagePostTargetDialogState extends State<AddFacebookPagePostTargetDialog> {
  @override
  void initState() {
    super.initState();

    Future<void> asyncPart() async {
      final platformConnections = await _getPlatformConnectionsInteractor
        .perform(platform: SocialMediaPlatform.facebook);

      final pages = await Future.wait(
        platformConnections
          .map((e) => _getFacebookPagesInteractor.perform(e.id))
      );

      setState(() {
        _platformConnections = platformConnections;
        _pages = {
          for (int i = 0; i < platformConnections.length; ++i)
            platformConnections[i].id: pages[i]
        };
      });
    }

    asyncPart();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Facebook Page', style: theme.textTheme.headlineMedium),

            const SizedBox(height: 16.0),

            _buildContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    final platformConnections = _platformConnections;
    if (platformConnections == null || _pages == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("Connection"),

        _buildPlatformConnectionsDropdownButton(),

        _buildPagesDropdownButton(),

        const SizedBox(height: 16.0),

        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _buildCancelButton(),

            const SizedBox(width: 8.0),

            _buildAddButton(),
          ]
        ),
      ],
    );
  }

  Widget _buildPlatformConnectionsDropdownButton() {
    return DropdownButton(
      items: _platformConnections!
        .map((platformConnection) {
          return DropdownMenuItem(
              value: platformConnection.id,
              child: Text(platformConnection.id)
          );
        })
          .toList(),
      value: _selectedPlatformConnection,
      onChanged: (value) {
        setState(() {
          _selectedPlatformConnection = value;
          _selectedPageId = null;
        });
      },
    );
  }

  Widget _buildPagesDropdownButton() {
    if (_selectedPlatformConnection == null) return const SizedBox.shrink();

    final pages = _pages![_selectedPlatformConnection];

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16.0),

        const Text('Page'),

        const SizedBox(height: 4.0),

        DropdownButton(
          items: pages!
            .map((page) {
              return DropdownMenuItem(
                value: page.id,
                child: Text('${page.name} (${page.id})'),
              );
            })
            .toList(),
          value: _selectedPageId,
          onChanged: (value) => setState(() => _selectedPageId = value),
        ),
      ],
    );
  }

  Widget _buildCancelButton() {
    return OutlinedButton(
      onPressed: () => Navigator.of(context).pop(),
      child: const Text('Cancel')
    );
  }

  Widget _buildAddButton() {
    void onPressed() async {
      final response = AddFacebookPagePostTargetDialogResponse(
        platformConnection: _selectedPlatformConnection!,
        pageId: _selectedPageId!,
      );

      Navigator.of(context).pop(response);
    }

    final isEnabled = (_selectedPlatformConnection != null && _selectedPageId != null);
    return ElevatedButton(
      onPressed: (isEnabled) ? onPressed : null,
      child: const Text('Add'),
    );
  }


  List<PlatformConnection>? _platformConnections;
  String? _selectedPlatformConnection;

  Map<String, List<FacebookPage>>? _pages;
  String? _selectedPageId;

  final _getPlatformConnectionsInteractor =
    GetIt.instance<GetPlatformConnectionsInteractor>();
  final _getFacebookPagesInteractor =
    GetIt.instance<GetPlatformConnectionFacebookPagesInteractor>();
}

class AddFacebookPagePostTargetDialogResponse {
  const AddFacebookPagePostTargetDialogResponse({
    required this.platformConnection,
    required this.pageId,
  });

  final String platformConnection;
  final String pageId;
}