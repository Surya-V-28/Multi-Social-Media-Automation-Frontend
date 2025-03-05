import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
class SharedPreferencesConfiguration {
  @singleton
  SharedPreferencesAsync sharedPreferences() {
    return SharedPreferencesAsync();
  }
}
