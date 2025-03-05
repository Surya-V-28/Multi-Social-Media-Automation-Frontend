import 'package:injectable/injectable.dart';

import 'post_request_retriever.dart';
import 'view_model.dart';

@singleton
class PostRequestsListPageViewModelFactory {
  const PostRequestsListPageViewModelFactory(this.postRequestRetriever);

  PostRequestsListPageViewModel build() {
    return PostRequestsListPageViewModel(
      postRequestRetriever: postRequestRetriever, 
      initialUiState: null
    );
  }


  final PostRequestRetriever postRequestRetriever;
}
