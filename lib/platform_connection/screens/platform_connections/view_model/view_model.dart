import 'package:business_logic/business_logic.dart';
import 'package:collection/collection.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:post_scheduler/utils/option.dart';
import 'package:rxdart/rxdart.dart';

import 'ui_state.dart';

class PlatformConnectionsPageViewModel {
  PlatformConnectionsPageViewModel(
    GetPlatformConnectionsInteractor getPlatformConnectionsInteractor,
    RemovePlatformConnectionInteractor removePlatformConnectionInteractor,
    GetPlatformConnectionNameInteractor getPlatformConnectionNameInteractor,
  ) :
    _getPlatformConnectionsInteractor = getPlatformConnectionsInteractor,
    _removePlatformConnectionInteractor = removePlatformConnectionInteractor,
    _getPlatformConnectionNameInteractor = getPlatformConnectionNameInteractor;

  void pageOpened() async {
    final platformConnections = await _getPlatformConnectionsInteractor.perform();
    final names = await platformConnections
      .map((e) => _getPlatformConnectionNameInteractor.perform(e.id))
      .wait;

    uiState.add(
      uiState.value.copyWith(
        isLoading: false,
        platformConnections: platformConnections
          .mapIndexed((index, e) {
            return PlatformConnectionListItemUiState(
              id: e.id, 
              userId: e.platformUserId, 
              platform: e.platform, 
              name: names[index],
            );
          })
          .toIList(),
      ),
    );
  }
  
  void addButtonClicked() async {
    uiState.add(uiState.value.copyWith(isAddMenuOpen: true,),);
  }

  void addPlatformConnectionButtonClicked(SocialMediaPlatform platform) async {
    final Uri oAuthUrl = switch (platform) {
      SocialMediaPlatform.facebook => Uri.parse('https://facebook.com/dialog/oauth')
      .replace(
        queryParameters: {
          'client_id': '409166238954550',
          'redirect_uri': 'https://rrupzduwseavjd2nfl3caf33va0shwhb.lambda-url.ap-south-1.on.aws/platform-connection-oauth-callback',
          'config_id': '1294753181529213',
          'state': 'facebook',
        },
      ),
      SocialMediaPlatform.instagram => Uri.parse('https://www.instagram.com/oauth/authorize?enable_fb_login=0&force_authentication=1&client_id=833975175591745&redirect_uri=https://rrupzduwseavjd2nfl3caf33va0shwhb.lambda-url.ap-south-1.on.aws/platform-connection-oauth-callback&response_type=code&scope=instagram_business_basic%2Cinstagram_business_manage_messages%2Cinstagram_business_manage_comments%2Cinstagram_business_content_publish&state=instagram'),
    };

    uiState.add(uiState.value.copyWith(isAddMenuOpen: false, isLoading: true, navigatingToOAuthUrl: Option(oAuthUrl),),);
  }

  void addMenuDismissed() {
    uiState.add(uiState.value.copyWith(isAddMenuOpen: false,),);
  }

  void navigatedToOAuthUrl() {
    uiState.add(uiState.value.copyWith(navigatingToOAuthUrl: null,),);
  }

  void deleteButtonClicked(String id) async {
    uiState.add(uiState.value.copyWith(isLoading: true,),);

    await _removePlatformConnectionInteractor.remove(id);

    uiState.add(
      uiState.value.copyWith(
        platformConnections: uiState.value.platformConnections.removeWhere((platformConnection) => platformConnection.id == id),
        isLoading: false,
      ),
    );
  }



  final uiState = BehaviorSubject.seeded(const PlatformConnectionsPageUiState.initial());

  final GetPlatformConnectionsInteractor _getPlatformConnectionsInteractor;
  final RemovePlatformConnectionInteractor _removePlatformConnectionInteractor;
  final GetPlatformConnectionNameInteractor _getPlatformConnectionNameInteractor;
}
