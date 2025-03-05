import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class AccessTokenRepository {
  const AccessTokenRepository(this._sharedPreferences);

  Future<void> save(final String accessToken) async {
    await _sharedPreferences.setString("access_token", accessToken);
  }

  Future<String?> getToken() async {
    return await _sharedPreferences.getString("access_token");
  }

  Future<void> remove() async {
    await _sharedPreferences.remove("access_token");
  }


  final SharedPreferencesAsync _sharedPreferences;
}
