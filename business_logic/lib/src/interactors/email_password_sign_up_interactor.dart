import 'package:backend_api_client/backend_api_client.dart';
import 'package:injectable/injectable.dart';

@singleton
class EmailPasswordSignUpInteractor {
  EmailPasswordSignUpInteractor(this._backendClient);

  Future<void> perform(String email, String username, String password) async {
    await _backendClient.authClient.signUp(email, username, password);
  }

  final BackendClient _backendClient;
}
