import 'dart:io';

import 'package:dio/dio.dart';

import 'backend_api_client_state.dart';

import 'auth/auth_client.dart';
import 'platform_connection/platform_connection_client.dart';
import 'post/post_client.dart';
import 'notification/notification_client.dart';
import 'media_library/media_library_client.dart'; 

class BackendClient {
  BackendClient._({
    required BackendApiClientState state,
    required this.authClient,
    required this.postClient,
    required this.platformConnectionClient,
    required this.notificationClient,
    required this.mediaLibrary,
  }) :
        _state = state;

  factory BackendClient(Dio dio) {
    final state = BackendApiClientState();

    return BackendClient._(
      state: state,
      authClient: AuthClient(backendUri, dio),
      postClient: PostClient(backendUri, dio),
      platformConnectionClient: PlatformConnectionClient(backendUri, dio),
      notificationClient: NotificationClient(backendUri, dio),
      mediaLibrary: MediaLibraryClient(backendUri, dio),
    );
  }

  void setAccessToken(String accessToken) {
    _state.accessToken = accessToken;
  }



  final BackendApiClientState _state;

  final AuthClient authClient;
  final PostClient postClient;
  final PlatformConnectionClient platformConnectionClient;
  final NotificationClient notificationClient;
  final MediaLibraryClient mediaLibrary;


  static final Uri backendUri = (Platform.isAndroid) ? Uri.parse('http://10.0.2.2:8080') : Uri.parse('http://localhost:8080');
}
