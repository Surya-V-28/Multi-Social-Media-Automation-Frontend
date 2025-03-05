class PostMedia {
  const PostMedia(this.id, this.fileId);

  factory PostMedia.fromJson(final Map<String, dynamic> json) {
    return PostMedia(json['id'], json['fileId']);
  }


  final String id;
  final String fileId;
}
