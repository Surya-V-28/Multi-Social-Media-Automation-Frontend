import 'package:business_logic/business_logic.dart';

import 'view_model.dart';

class PlatformConnectionsPageViewModelFactory {
  const PlatformConnectionsPageViewModelFactory(
    this._getPlatformConnectionsInteractor,
    this._removePlatformConnectionInteractor,
    this._getPlatformConnectionNameInteractor,
  );

  PlatformConnectionsPageViewModel build() {
    return PlatformConnectionsPageViewModel(
      _getPlatformConnectionsInteractor, 
      _removePlatformConnectionInteractor,
      _getPlatformConnectionNameInteractor,
    );
  }

  final GetPlatformConnectionsInteractor _getPlatformConnectionsInteractor;
  final RemovePlatformConnectionInteractor _removePlatformConnectionInteractor;
  final GetPlatformConnectionNameInteractor _getPlatformConnectionNameInteractor;
}
