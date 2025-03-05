import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:post_scheduler/platform_connection/screens/platform_connections/view_model/view_model_factory.dart';
import 'package:post_scheduler/post_scheduler/screens/post_requests_calendar_page/viewmodel/view_model_factory.dart';
import 'package:post_scheduler/post_scheduler/screens/post_requests_list/view_model/mappers/post_request_mapper.dart';
import 'package:post_scheduler/post_scheduler/screens/post_requests_list/view_model/post_request_retriever.dart';
import 'package:post_scheduler/post_scheduler/screens/post_requests_list/view_model/view_model_factory.dart';
import 'package:post_scheduler/post_scheduler/screens/scheduled_post_details_page/view_model_factory.dart';

@InjectableInit()
void configureDependencies() {
  var getIt = GetIt.instance;

  getIt.registerLazySingleton(() => PostRequestMapper());
  getIt.registerLazySingleton(() => PostRequestRetriever(getIt(), getIt()));
  getIt.registerLazySingleton(() => PostRequestsListPageViewModelFactory(getIt()));
  getIt.registerLazySingleton(() => ScheduledPostDetailsPageViewModelFactory(getIt()));

  getIt.registerLazySingleton(() => PlatformConnectionsPageViewModelFactory(getIt(), getIt(), getIt()));

  getIt.registerLazySingleton(() => ViewModelFactory(getIt()));
}
