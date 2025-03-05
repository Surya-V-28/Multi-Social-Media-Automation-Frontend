class MediaInsight {
  const MediaInsight({
    required this.name,
    required this.value,
  });

  factory MediaInsight.fromJson(Map<String, dynamic> json) {
    return MediaInsight(
      name: json['name'], 
      value: json['values'][0]['value'],
    );
  }

  final String name;
  final int value;
}