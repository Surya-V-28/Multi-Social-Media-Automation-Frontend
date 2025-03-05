class User {
  const User({required this.id});

  factory User.fromJson(Map<String, dynamic> json) => User(id: json['id']);


  final String id;
}