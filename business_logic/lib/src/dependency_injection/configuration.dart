import 'package:business_logic/src/interactors/interactors.dart';
import 'package:backend_api_client/backend_api_client.dart';
import 'package:facebook_api_client/facebook_api_client.dart';
import 'package:instagram_api_client/instagram_api_client.dart';
import 'package:business_logic/src/user_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../access_token_repository/access_token_repository.dart';

@injectableInit
void registerDependencies() {
  var getIt = GetIt.instance;

  getIt.registerLazySingleton(() => SharedPreferencesAsync());
  getIt.registerLazySingleton(() => Dio());

  getIt.registerLazySingleton(() => FacebookApiClient(getIt()));

  getIt.registerLazySingleton(() => InstagramApiClient(getIt()));

  getIt.registerLazySingleton(() => BackendClient(getIt()));

  getIt.registerLazySingleton(() => AccessTokenRepository(getIt()));
  getIt.registerLazySingleton(() => UserRepository());

  getIt.registerLazySingleton(() => EmailPasswordSignUpInteractor(getIt()));
  getIt.registerLazySingleton(() => EmailPasswordLoginInteractor(getIt(), getIt(), getIt()));
  getIt.registerLazySingleton(() => CognitoSocialLoginInteractor(getIt(), getIt(), getIt(), getIt()));
  getIt.registerLazySingleton(() => SignOutInteractor(getIt()));
  getIt.registerLazySingleton(() => GetLoggedInUserInteractor(getIt(), getIt()));
  getIt.registerLazySingleton(() => InitializeLoggedInUserInteractor(getIt(), getIt(), getIt()));

  getIt.registerLazySingleton(() => GetPlatformAccessTokenInteractor(getIt()));
  getIt.registerLazySingleton(() => ConnectToPlatformInteractor(getIt(), getIt(), getIt()));
  getIt.registerLazySingleton(() => GetPlatformConnectionsInteractor(getIt(), getIt(), getIt()));
  getIt.registerLazySingleton(() => GetPlatformConnectionFacebookPagesInteractor(getIt(), getIt(), getIt(), getIt()));
  getIt.registerLazySingleton(() => RemovePlatformConnectionInteractor(getIt(), getIt(), getIt(),),);
  getIt.registerLazySingleton(() => GetInstagramAccountsOfFacebookUserInteractor(getIt(), getIt(), getIt(), getIt()));
  getIt.registerLazySingleton(() => GetPlatformConnectionNameInteractor(getIt(), getIt(), getIt(), getIt()));

  getIt.registerLazySingleton(() => AddMediaInteractor(getIt(), getIt(), getIt(), getIt()));
  getIt.registerLazySingleton(() => GetUserMediasInteractor(getIt(), getIt(), getIt()));
  getIt.registerLazySingleton(() => GetMediaInteractor(getIt(), getIt(), getIt()));
  getIt.registerLazySingleton(() => DeleteMediaInteractor(getIt(), getIt(), getIt()));

  getIt.registerLazySingleton(() => GetUserNotificationsInteractor(getIt(), getIt(), getIt()));

  getIt.registerLazySingleton(() => SchedulePostInteractor(getIt(), getIt(), getIt()));
  getIt.registerLazySingleton(() => GetScheduledPostInteractor(getIt(), getIt(), getIt()));
  getIt.registerLazySingleton(() => ValidatePostInteractor(getIt()));

  getIt.registerLazySingleton(() => GetInstagramFeedPostInsightsInteractor(getIt(), getIt(), getIt(), getIt()));

  getIt.registerLazySingleton(
    () {
      return GetPostRequestsInteractor(
        accessTokenRepository: getIt(),
        userRepository: getIt(),
        backendClient: getIt()
      );
    }
  );
}
