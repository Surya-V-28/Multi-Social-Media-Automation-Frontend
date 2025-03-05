import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../destination_ui_state.dart';

abstract class FacebookPageDestinationUiState implements DestinationUiState {
  const FacebookPageDestinationUiState({required this.id});
  
  static LoadingFacebookPageDestinationUiState initial({required String id}) {
    return LoadingFacebookPageDestinationUiState(id: id);
  }

  @override
  final String id;
}

class LoadingFacebookPageDestinationUiState implements FacebookPageDestinationUiState, LoadingDestinationUiState {
  const LoadingFacebookPageDestinationUiState({required this.id});


  @override
  final String id;
}

class LoadedFacebookPageDestinationUiState extends FacebookPageDestinationUiState {
  const LoadedFacebookPageDestinationUiState({ required super.id, required this.pages, required this.selectedPage });

  LoadedFacebookPageDestinationUiState copyWith({String? id, IList<FacebookPageUiState>? pages, String? selectedPage}) {
    return LoadedFacebookPageDestinationUiState(
      id: id ?? this.id,
      pages: pages ?? this.pages,
      selectedPage: selectedPage ?? this.selectedPage,
    );
  }

  final IList<FacebookPageUiState> pages;
  final String selectedPage;
}

class FacebookPageUiState {
  const FacebookPageUiState({required this.id, required this.name});

  final String id;
  final String name;
}
