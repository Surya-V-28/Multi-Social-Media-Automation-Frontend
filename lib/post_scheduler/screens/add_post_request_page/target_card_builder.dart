import 'package:flutter/material.dart';

import 'package:business_logic/business_logic.dart';
import 'package:post_scheduler/post_scheduler/screens/add_post_request_page/post_target_cards/instagram_feed/post_target_card.dart';
import 'post_target_cards/instagram_story/post_target_card.dart';
import 'view_model/add_post_request_page_view_model.dart';
import 'post_target_cards/facebook_page/post_target_card.dart';
import 'post_target_cards/post_target_card_ui_state.dart';

Widget buildTargetCard(PostTargetCardUiState uiState, AddPostRequestPageViewModel viewModel) {
  return switch (uiState.targetType) {
    PostTargetType.facebookPage => FacebookPagePostTargetCard(
      uiState: uiState,
      viewModel: viewModel,
    ),
    PostTargetType.instagramFeed => InstagramFeedPostTargetCard(
      uiState: uiState,
      viewModel: viewModel,
    ),
    PostTargetType.instagramStory => InstagramStoryPostTargetCard(
      uiState: uiState,
      viewModel: viewModel,
    ),
  };
}
