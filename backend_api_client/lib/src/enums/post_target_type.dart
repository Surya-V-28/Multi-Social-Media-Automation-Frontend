import 'social_media_platform.dart';

enum PostTargetType {
  facebookPage(SocialMediaPlatform.facebook, 'Facebook Page',),
  instagramFeed(SocialMediaPlatform.instagram, 'Instagram Feed',),
  instagramStory(SocialMediaPlatform.instagram, 'Instagram Story',);

  const PostTargetType(this.platform, this.displayForm);

  static PostTargetType parse(final String textForm) {
    return switch (textForm) {
      'facebookPage' => PostTargetType.facebookPage,
      'instagramFeed' => PostTargetType.instagramFeed,
      'instagramStory' => PostTargetType.instagramStory,
      String() => throw UnimplementedError(),
    };
  }


  final SocialMediaPlatform platform;
  final String displayForm;
}
