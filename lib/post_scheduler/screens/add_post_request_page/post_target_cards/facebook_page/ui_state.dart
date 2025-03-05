part of '../details_ui_state.dart';


class FacebookPagePostTargetDetailsUiState implements PostTargetDetailsUiState {
  const FacebookPagePostTargetDetailsUiState({
    required this.pageId,
    required this.pageName,
});

  final String pageId;
  final String pageName;
}
