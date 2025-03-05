import 'package:business_logic/src/access_token_repository/access_token_repository.dart';
import 'package:backend_api_client/backend_api_client.dart';
import 'package:business_logic/src/user_repository.dart';
import 'package:cross_file/cross_file.dart';
import 'package:dio/dio.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';


class SchedulePostInteractor {
  const SchedulePostInteractor(
    this._accessTokenRepository,
    this._userRepository,
    this._backendClient,
  );

  Future<String> perform(SchedulePostInteractorParameters parameters) async {
    final accessToken = (await _accessTokenRepository.getToken())!;
    final user = (await _userRepository.getUser())!;

    final request = SchedulePostRequest(
      userId: user.id,
      scheduledTime: parameters.scheduledTime,
      targets: parameters.targets,

      title: parameters.title,
      caption: parameters.caption,
      media: parameters.medias.toList(),

      accessToken: accessToken,
    );

    return await _backendClient.postClient.schedulePost(request);
  }


  final AccessTokenRepository _accessTokenRepository;
  final UserRepository _userRepository;
  final BackendClient _backendClient;
}

class SchedulePostInteractorParameters {
  const SchedulePostInteractorParameters({
    required this.scheduledTime,
    required this.targets,

    required this.title,
    required this.caption,
    required this.medias,
  });

  final DateTime scheduledTime;
  final List<SchedulePostRequestPostTarget> targets;

  final String title;
  final String caption;
  final IList<String> medias;
}

class SchedulePostInteractorMedia {
  const SchedulePostInteractorMedia({
    required this.mimeType,
    required this.file,
  });

  final MimeType mimeType;
  final XFile file;
}
