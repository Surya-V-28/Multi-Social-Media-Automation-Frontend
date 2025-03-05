import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:post_scheduler/utils/discardable_operation.dart';
import 'package:get_it/get_it.dart';

import 'package:business_logic/business_logic.dart';

class AddInstagramStoryPostTargetDialog extends StatefulWidget {
  const AddInstagramStoryPostTargetDialog({super.key});

  @override
  State<AddInstagramStoryPostTargetDialog> createState() => _AddInstagramStoryPostTargetDialogState();
}

class _AddInstagramStoryPostTargetDialogState extends State<AddInstagramStoryPostTargetDialog> {
  @override
  void initState() {
    super.initState();

    _getPlatformConnectionsInteractor
        .perform(platform: SocialMediaPlatform.facebook)
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
                  onPressed: () => Navigator.of(context).pop<AddInstagramStoryPostTargetDialogResponse>(null),
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
          operation: () => _getInstagramUserIdsInteractor.perform(value!),
          onComplete: (value) {
            setState(() {
              _selectedUserId = null;
              _userIds = const IList.empty();
            });
          },
        );
      },
    );
  }

  Widget _buildUserIdsDropdownButton() {
    return DropdownButton(
      value: _selectedUserId,
      onChanged: (value) => setState(() => _selectedUserId),
      items: _userIds
          .map((e) => DropdownMenuItem(value: e, child: Text(e),))
          .toList(),
    );
  }

  Widget _buildAddButton() {
    Future<void> onPressed() async {
      final platformConnection = _platformConnections!
        .firstWhere((e) => e.id == _selectedPlatformConnection);

      final response = AddInstagramStoryPostTargetDialogResponse(
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
  var _userIds = const IList<String>.empty();
  String? _selectedUserId;

  final _getPlatformConnectionsInteractor =
    GetIt.instance<GetPlatformConnectionsInteractor>();

  final _getInstagramUserIdsInteractor =
      GetIt.instance<GetInstagramAccountsOfFacebookUserInteractor>();
}

class AddInstagramStoryPostTargetDialogResponse {
  const AddInstagramStoryPostTargetDialogResponse({
    required this.platformConnectionId,
    required this.userId,
  });

  final String platformConnectionId;
  final String userId;
}