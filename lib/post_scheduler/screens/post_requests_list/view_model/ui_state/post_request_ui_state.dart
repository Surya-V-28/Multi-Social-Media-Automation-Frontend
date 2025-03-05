import 'package:business_logic/business_logic.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

class PostRequestUiState {
  const PostRequestUiState({
    required this.id,
    required this.scheduledDateTime,
    required this.fulfilled,
    required this.caption,
    required this.platforms,
  });


  final String id;
  final DateTime scheduledDateTime;
  final bool fulfilled;
  final String caption;
  final IList<SocialMediaPlatform> platforms;
}

