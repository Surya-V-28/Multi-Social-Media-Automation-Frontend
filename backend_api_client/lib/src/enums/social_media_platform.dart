enum SocialMediaPlatform {
  facebook,
  instagram;

  static parse(String textForm) {
    return switch (textForm) {
      'facebook' => SocialMediaPlatform.facebook,
      'instagram' => SocialMediaPlatform.instagram,
      String() => throw FormatException('Cannot parse $textForm to SocialMediaPlatform enum'),
    };
  }

  @override
  String toString() => super.toString().split(".")[1];
}
