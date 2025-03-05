import 'package:business_logic/business_logic.dart';

import 'details_ui_state.dart';

class PostTargetCardUiState {
  const PostTargetCardUiState({
    required this.id,
    required this.platformConnectionId,
    required this.targetType,
    required this.details,
  });

  PostTargetCardUiState copy({
    String? id,
    String? platformConnectionId,
    PostTargetType? targetType,
    PostTargetDetailsUiState? details,
  }) {
    return PostTargetCardUiState(
      id: id ?? this.id,
      platformConnectionId: platformConnectionId ?? this.platformConnectionId,
      targetType: targetType ?? this.targetType,
      details: details ?? this.details,
    );
  }

  final String id;
  final String platformConnectionId;
  final PostTargetType targetType;
  final PostTargetDetailsUiState details;
}