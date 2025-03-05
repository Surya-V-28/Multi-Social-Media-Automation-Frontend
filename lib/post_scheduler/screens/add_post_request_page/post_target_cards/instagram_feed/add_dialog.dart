import 'dart:async';

import 'package:business_logic/business_logic.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:post_scheduler/utils/discardable_operation.dart';

class AddInstagramFeedPostTargetDialog extends StatefulWidget {
  const AddInstagramFeedPostTargetDialog({super.key});

  @override
  State<AddInstagramFeedPostTargetDialog> createState() => _AddInstagramFeedPostTargetDialogState();
}

class _AddInstagramFeedPostTargetDialogState extends State<AddInstagramFeedPostTargetDialog> {
  @override
  void initState() {
    super.initState();

    _getPlatformConnectionsInteractor.perform(platform: SocialMediaPlatform.facebook)
      .then((value) => setState(() => _platformConnections = value));
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
            Text('Instagram Feed', style: theme.textTheme.headlineMedium),

            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPlatformConnectionsDropdownButton(),

                const SizedBox(height: 32.0),

                _buildUserIdsDropdownButton(),
              ]
            ),

            const SizedBox(height: 32.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildAddButton(),

                const SizedBox(width: 16.0),

                OutlinedButton(
                  onPressed: () => Navigator.of(context).pop<AddInstagramFeedPostTargetDialogResponse>(null),
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlatformConnectionsDropdownButton() {
    return DropdownButton(
      items: _platformConnections
        .map((platformConnection) {
          return DropdownMenuItem(
            value: platformConnection.id,
            child: Text(platformConnection.id),
          );
        })
          .toList(),
      value: _selectedPlatformConnection,
      onChanged: (value) {
        setState(() => _selectedPlatformConnection = value);

        _instagramUserIdsFetcher?.discard();

        _instagramUserIdsFetcher = DiscardableOperation(
          operation: () => _getInstagramAccountsInteractor.perform(value!),
          onComplete: (value) {
            print('CustomLog: Instagram Users = $value');
            setState(() {
              _instagramUserIds = [...value];
              _selectedUserId = null;
            });
          },
        );

        _instagramUserIdsFetcher!.perform();
      },
    );
  }

  Widget _buildUserIdsDropdownButton() {
    return DropdownButton(
      value: _selectedUserId,
      onChanged: (value) => setState(() => _selectedUserId = value),
      items: _instagramUserIds
        .map((e) => DropdownMenuItem(value: e, child: Text(e),))
        .toList(),
    );
  }

  Widget _buildAddButton() {
    Future<void> onPressed() async {
      final platformConnection = _platformConnections
        .firstWhere((e) => e.id == _selectedPlatformConnection);

      final response = AddInstagramFeedPostTargetDialogResponse(
          platformConnectionId: platformConnection.id,
          userId: _selectedUserId!,
      );
      Navigator.of(context).pop(response);
    }

    return ElevatedButton(
        onPressed: (_selectedPlatformConnection != null) ? onPressed : null,
        child: const Text('Add'),
    );
  }



  List<PlatformConnection> _platformConnections = [];
  String? _selectedPlatformConnection;

  DiscardableOperation<List<String>>? _instagramUserIdsFetcher;
  List<String> _instagramUserIds = [];
  String? _selectedUserId;

  final _getPlatformConnectionsInteractor =
    GetIt.instance<GetPlatformConnectionsInteractor>();
  final _getInstagramAccountsInteractor =
    GetIt.instance<GetInstagramAccountsOfFacebookUserInteractor>();
}

class AddInstagramFeedPostTargetDialogResponse {
  const AddInstagramFeedPostTargetDialogResponse({
    required this.platformConnectionId,
    required this.userId,
  });

  final String platformConnectionId;
  final String userId;
}
