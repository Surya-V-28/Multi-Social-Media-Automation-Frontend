import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import 'package:business_logic/business_logic.dart';

import '../ui_state/post_request_ui_state.dart';

@singleton
class PostRequestMapper {
  PostRequestUiState toUiState(ScheduledPost businessLogicModel) {
    return PostRequestUiState(
      id: businessLogicModel.id,
      scheduledDateTime: businessLogicModel.scheduledTime,
      fulfilled: businessLogicModel.isFulfilled,
      caption: businessLogicModel.caption ?? "",
      platforms: _getPlatforms(businessLogicModel.targets),
    );
  }

  IList<SocialMediaPlatform> _getPlatforms(List<PostTarget> destinations) {
    return Set.of(destinations.map((element) => element.targetType.platform))
      .toIList();
  }
}
