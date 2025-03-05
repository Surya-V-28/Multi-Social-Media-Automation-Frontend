import 'dart:convert';

import 'package:business_logic/src/access_token_repository/access_token_repository.dart';
import 'package:backend_api_client/backend_api_client.dart';
import 'package:facebook_api_client/facebook_api_client.dart';
import 'package:business_logic/src/user_repository.dart';

class GetInstagramAccountsOfFacebookUserInteractor {
  const GetInstagramAccountsOfFacebookUserInteractor(
    this._facebookApiClient,
    this._backendClient,
    this._userRepository,
    this._accessTokenRepository,
  );

  Future<List<String>> perform(String platformConnectionId) async {
    final user = (await _userRepository.getUser())!;
    final accessToken = (await _accessTokenRepository.getToken())!;

    final platformConnection = (await _backendClient.platformConnectionClient
      .getPlatformConnection(user.id, platformConnectionId, accessToken));

    final pages = await _facebookApiClient.getPages(
        platformConnection.platformUserId,
        platformConnection.accessToken!,
    );

    print('CustomLog: Interactor Instagram Pages = ${pages}');

    return pages
        .where((e) => e.instagramBusinessAccount != null)
        .map((e) => e.instagramBusinessAccount!.id)
        .toList();
  }


  final FacebookApiClient _facebookApiClient;
  final BackendClient _backendClient;

  final UserRepository _userRepository;
  final AccessTokenRepository _accessTokenRepository;
}
