import 'dart:convert';

class FacebookPage {
  const FacebookPage({
    required this.id,
    required this.name,
    required this.accessToken,
    required this.instagramBusinessAccount,
  });

  factory FacebookPage.fromJson(Map<String, dynamic> json) {
    var instagramBusinessAccount = (json['instagram_business_account'] != null)
      ? FacebookPageInstagramBusinessAccount.fromJson(json['instagram_business_account'])
      : null;

    return FacebookPage(
      id: json['id'],
      name: json['name'],
      accessToken: json['access_token'],
      instagramBusinessAccount: instagramBusinessAccount,
    );
  }

  @override
  String toString() {
    return jsonEncode({
      'id': id,
      'name': name,
      'accessToken': accessToken,
      'instagramBusinessAccount': instagramBusinessAccount.toString(),
    });
  }



  final String id;
  final String name;
  final String accessToken;
  final FacebookPageInstagramBusinessAccount? instagramBusinessAccount;
}

class FacebookPageInstagramBusinessAccount {
  const FacebookPageInstagramBusinessAccount({required this.id});

  factory FacebookPageInstagramBusinessAccount.fromJson(Map<String, dynamic> json) {
    return FacebookPageInstagramBusinessAccount(id: json['id']);
  }

  @override
  String toString() {
    return jsonEncode( { 'id': id } );
  }

  final String id;
}
