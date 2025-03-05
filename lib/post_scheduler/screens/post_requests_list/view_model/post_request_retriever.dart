import 'package:injectable/injectable.dart';

import 'package:business_logic/business_logic.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import 'mappers/post_request_mapper.dart';
import 'ui_state/post_request_ui_state.dart';

@singleton
class PostRequestRetriever {
  const PostRequestRetriever(this._getPostRequestsInteractor, this._mapper);

  Future<IList<PostRequestUiState>> retrieve(DateTime date) async {
    final DateTime fromTime = date;
    final DateTime toTime = date.add(const Duration(days: 1));

    return (await _getPostRequestsInteractor.get(fromTime: fromTime, toTime: toTime))
      .map((element) => _mapper.toUiState(element))
      .toIList();
  }


  final GetPostRequestsInteractor _getPostRequestsInteractor;
  final PostRequestMapper _mapper;
}
