import 'package:business_logic/business_logic.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:post_scheduler/utils/option.dart';

class PlatformConnectionsPageUiState extends Equatable {
  const PlatformConnectionsPageUiState({
    required this.isLoading,
    required this.isAddMenuOpen,
    required this.platformConnections,
    required this.navigatingToOAuthUrl,
  });
  
  const PlatformConnectionsPageUiState.initial() :
    isLoading = true,
    isAddMenuOpen = false,
    platformConnections = const IList.empty(),
    navigatingToOAuthUrl = null;

  PlatformConnectionsPageUiState copyWith({
    bool? isLoading,
    bool? isAddMenuOpen,
    IList<PlatformConnectionListItemUiState>? platformConnections,
    Option<Uri?>? navigatingToOAuthUrl,
  }) {
    return PlatformConnectionsPageUiState(
      isLoading: isLoading ?? this.isLoading,
      isAddMenuOpen: isAddMenuOpen ?? this.isAddMenuOpen,
      platformConnections: platformConnections ?? this.platformConnections,
      navigatingToOAuthUrl: Option.resolveWithFallback(navigatingToOAuthUrl, this.navigatingToOAuthUrl),
    );
  }
  
  @override
  List<Object?> get props => [isLoading, isAddMenuOpen, platformConnections, navigatingToOAuthUrl];


  final bool isLoading;
  final bool isAddMenuOpen;
  final IList<PlatformConnectionListItemUiState> platformConnections;
  final Uri? navigatingToOAuthUrl;
}

class PlatformConnectionListItemUiState extends Equatable {
  const PlatformConnectionListItemUiState({required this.id, required this.platform, required this.userId, required this.name,});

  @override
  List<Object?> get props => [id, platform, userId];

  final String id;
  final SocialMediaPlatform platform;
  final String userId;
  final String name;
}
