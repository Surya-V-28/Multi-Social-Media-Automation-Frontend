import 'package:injectable/injectable.dart';

import '../access_token_repository/access_token_repository.dart';

@singleton
class SignOutInteractor {
  const SignOutInteractor(this._accessTokenRepository);

  Future<void> signOut() async {
    await _accessTokenRepository.remove();
  }


  final AccessTokenRepository _accessTokenRepository;
}
