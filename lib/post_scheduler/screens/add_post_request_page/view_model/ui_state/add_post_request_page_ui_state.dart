import 'package:business_logic/business_logic.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../../post_target_cards/post_target_card_ui_state.dart';


class AddPostRequestPageUiState {
  const AddPostRequestPageUiState({
    required this.isLoading,
    required this.scheduledDateTime,
    required this.medias,
    required this.title,
    required this.caption,
    required this.targets,
    required this.validationErrorsDialog,
    required this.poppingPage,
  });

  factory AddPostRequestPageUiState.initial() {
    return AddPostRequestPageUiState(
      isLoading: false,
      scheduledDateTime: DateTime.now().add(const Duration(days: 1)),
      medias: const IList<AddedMediaUiState>.empty(),
      title: '',
      caption: '',
      targets: const IList.empty(),
      validationErrorsDialog: const ValidationErrorsDialogUiState.initial(),
      poppingPage: false,
    );
  }

  AddPostRequestPageUiState copyWith({
    bool? isLoading, 
    DateTime? scheduledDateTime, 
    IList<AddedMediaUiState>? medias,
    String? title,
    String? caption, 
    IList<PostTargetCardUiState>? targets,
    ValidationErrorsDialogUiState? validationErrorsDialog,
    bool? poppingPage,
  }) {
    return AddPostRequestPageUiState(
      isLoading: isLoading ?? this.isLoading,
      scheduledDateTime: scheduledDateTime ?? this.scheduledDateTime,
      medias: medias ?? this.medias,
      title: title ?? this.title,
      caption: caption ?? this.caption,
      targets: targets ?? this.targets,
      validationErrorsDialog: validationErrorsDialog ?? this.validationErrorsDialog,
      poppingPage: poppingPage ?? this.poppingPage,
    );
  }



  final bool isLoading;
  final DateTime scheduledDateTime;
  final IList<AddedMediaUiState> medias;
  final String title;
  final String caption;
  final IList<PostTargetCardUiState> targets;
  final ValidationErrorsDialogUiState validationErrorsDialog;
  final bool poppingPage;
}

class AddedMediaUiState {
  const AddedMediaUiState({required this.id, required this.name, required this.mimeType, required this.size, required this.details,});

  final String id;
  final String name;
  final MimeType mimeType;
  final int size;
  final AddedMediaDetailsUiState details;
}

sealed class AddedMediaDetailsUiState { }

class ImageAddedMediaDetailsUiState implements AddedMediaDetailsUiState {
  const ImageAddedMediaDetailsUiState({required this.width, required this.height});

  final int width;
  final int height;
}

class VideoAddedMediaDetailsUiState implements AddedMediaDetailsUiState {
  const VideoAddedMediaDetailsUiState({required this.duration});

  final int duration;
}

class ValidationErrorsDialogUiState {
  const ValidationErrorsDialogUiState({
    required this.isOpen,
    required this.errors,
  });

  const ValidationErrorsDialogUiState.initial() :
    isOpen = false,
    errors = const IMap.empty();

  ValidationErrorsDialogUiState copyWith({bool? isOpen, IMap<PostTargetType, IList<String>>? errors}) {
    return ValidationErrorsDialogUiState(
      isOpen: isOpen ?? this.isOpen,
      errors: errors ?? this.errors,
    );
  }

  final bool isOpen;
  final IMap<PostTargetType, IList<String>> errors;
}
