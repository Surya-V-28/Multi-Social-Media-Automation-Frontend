// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:business_logic/business_logic.dart' as _i939;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:post_scheduler/post_scheduler/screens/post_requests_calendar_page/viewmodel/view_model_factory.dart'
    as _i186;
import 'package:post_scheduler/post_scheduler/screens/post_requests_list/view_model/mappers/post_request_mapper.dart'
    as _i512;
import 'package:post_scheduler/post_scheduler/screens/post_requests_list/view_model/post_request_retriever.dart'
    as _i566;
import 'package:post_scheduler/post_scheduler/screens/post_requests_list/view_model/view_model_factory.dart'
    as _i975;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i512.PostRequestMapper>(() => _i512.PostRequestMapper());
    gh.singleton<_i186.ViewModelFactory>(
        () => _i186.ViewModelFactory(gh<_i939.GetPostRequestsInteractor>()));
    gh.singleton<_i566.PostRequestRetriever>(() => _i566.PostRequestRetriever(
          gh<_i939.GetPostRequestsInteractor>(),
          gh<_i512.PostRequestMapper>(),
        ));
    gh.singleton<_i975.PostRequestsListPageViewModelFactory>(() =>
        _i975.PostRequestsListPageViewModelFactory(
            gh<_i566.PostRequestRetriever>()));
    return this;
  }
}
