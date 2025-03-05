import 'package:business_logic/business_logic.dart';

import 'view_model.dart';

class ScheduledPostDetailsPageViewModelFactory {
  const ScheduledPostDetailsPageViewModelFactory(this._getScheduledPostInteractor);

  ScheduledPostDetailsPageViewModel build(String id) {
    return ScheduledPostDetailsPageViewModel(id, _getScheduledPostInteractor);
  }


  final GetScheduledPostInteractor _getScheduledPostInteractor;
}
