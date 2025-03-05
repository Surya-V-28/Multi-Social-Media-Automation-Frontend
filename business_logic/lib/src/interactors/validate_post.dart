import 'package:backend_api_client/backend_api_client.dart';

class ValidatePostInteractor {
  const ValidatePostInteractor(this._backendClient);

  Future<Map<PostTargetType, List<String>>> validate(ValidatePostRequest request) {
    return _backendClient.postClient.validatePost(request);
  }


  final BackendClient _backendClient;
}
