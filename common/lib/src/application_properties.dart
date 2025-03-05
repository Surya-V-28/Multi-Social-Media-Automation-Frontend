class ApplicationProperties {
  const ApplicationProperties();

  static const aws = AWSProperties();
}

class AWSProperties {
  const AWSProperties();

  final cognito = const AWSCognitoProperties();
}

class AWSCognitoProperties {
  const AWSCognitoProperties();

  // String get cognitoUri => 'https://rahil-post-scheduler-federated.auth.ap-south-1.amazoncognito.com';
  // String get clientId => '53ltp6q8s0sugbgu9u0l16h8j2';
  // String get redirectUri => 'application://post_scheduler/auth/cognito/oauth-callback'; 

  String get cognitoUri => 'https://ap-south-1dpfhos7mq.auth.ap-south-1.amazoncognito.com';
  String get clientId => '61ag4c35f06efg755mo5muss2n';
  String get redirectUri => 'application://post_scheduler/auth/cognito/oauth-callback'; 
}