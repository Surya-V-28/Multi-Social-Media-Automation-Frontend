library;

export 'src/interactors/interactors.dart';
export 'src/dependency_injection/configuration.dart';

export 'package:backend_api_client/backend_api_client.dart';

export 'package:facebook_api_client/facebook_api_client.dart' hide User;
import 'package:facebook_api_client/facebook_api_client.dart' as facebook_api_client;

export 'package:instagram_api_client/instagram_api_client.dart';

typedef FacebookUser = facebook_api_client.User;