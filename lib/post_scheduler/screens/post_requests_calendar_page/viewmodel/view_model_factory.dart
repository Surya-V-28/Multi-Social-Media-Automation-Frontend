import 'package:business_logic/business_logic.dart';
import 'package:injectable/injectable.dart';
import 'post_requests_calendar_page_view_model.dart';

@singleton
class ViewModelFactory {
  const ViewModelFactory(this._getPostRequestsInteractor);

  PostRequestsCalendarPageViewModel build() {
    return PostRequestsCalendarPageViewModel(_getPostRequestsInteractor);
  }


  final GetPostRequestsInteractor _getPostRequestsInteractor;
}
