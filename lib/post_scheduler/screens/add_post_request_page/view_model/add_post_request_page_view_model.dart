import 'package:dart_scope_functions/dart_scope_functions.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:get_it/get_it.dart';
import '../post_target_cards/details_ui_state.dart';
import '../post_target_cards/instagram_feed/add_dialog.dart';
import 'package:rxdart/rxdart.dart';

import 'package:business_logic/business_logic.dart';
import '../post_target_cards/instagram_story/add_dialog.dart';
import '../post_target_cards/post_target_card_ui_state.dart';
import 'package:uuid/uuid.dart';

import '../post_target_cards/facebook_page/add_dialog.dart';
import 'ui_state/add_post_request_page_ui_state.dart';

class AddPostRequestPageViewModel {
  void scheduledDateTimeChanged(DateTime dateTime) {
    uiState.add(uiState.value.copyWith(scheduledDateTime: dateTime));
  }

  void mediaPicked(List<String> mediaIds) async {
    print('CustomLog: Media ids = $mediaIds');
    final medias = (await _getUserMediasInteractor.perform())
      .where((e) => mediaIds.contains(e.mediaInfo.keyId))
      .toList();

    uiState.add(
      uiState.value.copyWith(
        medias: medias
          .map((e) {
            AddedMediaDetailsUiState details;
            switch(e.typeDetails) {
              case ImageMediaTypeDetails(:final width, :final height):
                details = ImageAddedMediaDetailsUiState(width: width, height: height);
              case VideoMediaTypeDetails(:final duration):
                details = VideoAddedMediaDetailsUiState(duration: duration.inSeconds);
            }

            return AddedMediaUiState(id: e.mediaInfo.keyId, name: e.mediaInfo.name, mimeType: e.mediaInfo.mimeType, size: e.mediaInfo.size, details: details);
          })
          .toIList(),
      )
    );
  }

  //void imageAdded(XFile file) async {
  //  final fileExtension = file.name.substring(file.name.lastIndexOf(".") + 1);
  //
  //  var image = await decodeImageFromList(await file.readAsBytes());
  //
  //  final media = AddedMediaUiState(
  //    mimeType: MimeType.fromFileExtension(fileExtension),
  //    file: file,
  //    details: ImageAddedMediaDetailsUiState(width: image.width, height: image.height,),
  //  );
  //
  //  uiState.add(
  //    uiState.value.copyWith(
  //      medias: uiState.value.medias.add(media),
  //    )
  //  );
  //}

  //void videoAdded(XFile file) {
  //  final fileExtension = file.name.substring(file.name.lastIndexOf(".") + 1);
  //
  //  final media = AddedMediaUiState(
  //    mimeType: MimeType.fromFileExtension(fileExtension),
  //    file: file,
  //    details: const VideoAddedMediaDetailsUiState(duration: 10),
  //  );
  //
  //  uiState.add(
  //    uiState.value.copyWith(
  //      medias: uiState.value.medias.add(media),
  //    )
  //  );
  //}
  
  void mediaRemoved(int index) {
    uiState.add(
      uiState.value.copyWith(
        medias: uiState.value.medias.removeAt(index),
      ),
    );
  }

  void titleChanged(String newTitle) {
    uiState.add( uiState.value.copyWith(title: newTitle) );
  }

  void captionChanged(String newCaption) {
    uiState.add( uiState.value.copyWith(caption: newCaption) );
  }

  void addTargetDialogClosed(dynamic dialogResponse) async {
    if (dialogResponse == null) return;

    PostTargetCardUiState cardUiState;
    if (dialogResponse is AddFacebookPagePostTargetDialogResponse) {
      final page = (await _getFacebookPagesInteractor.perform(dialogResponse.platformConnection))
        .firstWhere((element) => element.id == dialogResponse.pageId);

      cardUiState = PostTargetCardUiState(
        id: _uuid.v1().toString(),
        platformConnectionId: dialogResponse.platformConnection,
        targetType: PostTargetType.facebookPage,
        details: FacebookPagePostTargetDetailsUiState(
          pageId: dialogResponse.pageId,
          pageName: page.name
        ),
      );
    }
    else if (dialogResponse is AddInstagramFeedPostTargetDialogResponse) {
      cardUiState = PostTargetCardUiState(
        id: _uuid.v1().toString(),
        platformConnectionId: dialogResponse.platformConnectionId,
        targetType: PostTargetType.instagramFeed,
        details: InstagramFeedPostTargetDetailsUiState(userId: dialogResponse.userId,),
      );
    }
    else if (dialogResponse is AddInstagramStoryPostTargetDialogResponse) {
      cardUiState = PostTargetCardUiState(
        id: _uuid.v1().toString(),
        platformConnectionId: dialogResponse.platformConnectionId,
        targetType: PostTargetType.instagramStory,
        details: InstagramStoryPostTargetDetailsUiState(userId: dialogResponse.userId,),
      );
    }
    else {
      throw UnimplementedError();
    }

    uiState.add(
      uiState.value.copyWith(
        targets: uiState.value.targets.add(cardUiState)
      )
    );
  }

  void targetRemoved(String id) {
    uiState.add(
      uiState.value.copyWith(
        targets: uiState.value.targets
            .removeWhere((element) => element.id == id),
      )
    );
  }

  Future<void> confirmButtonClicked() async {
    if (uiState.value.targets.isEmpty) {
      return;
    }

    uiState.add( uiState.value.copyWith(isLoading: true) );

    final validationErrors = await _validatePost();

    if (validationErrors.values.where((e) => e.isNotEmpty).isNotEmpty) {
      uiState.add(
        uiState.value.copyWith(
          isLoading: false,
          validationErrorsDialog: uiState.value.validationErrorsDialog.copyWith(
            isOpen: true,
            errors: validationErrors.map((key, value) => MapEntry(key, value.toIList())).toIMap(),
          ),
        ),
      );

      return;
    }

    uiState.add(
      uiState.value.copyWith(validationErrorsDialog: uiState.value.validationErrorsDialog.copyWith(errors: const IMap.empty()),)
    );

    try {
      final schedulePostParameters = SchedulePostInteractorParameters(
        scheduledTime: uiState.value.scheduledDateTime,
        targets: uiState.value.targets
          .map((target) {
            return SchedulePostRequestPostTarget(
              targetType: target.targetType,
              platformConnectionId: target.platformConnectionId,
              details: target.details.let((it) {
                switch (it) {
                  case FacebookPagePostTargetDetailsUiState():
                    return FacebookPageSchedulePostRequestTargetDetails(
                      pageId: it.pageId,
                    );

                  case InstagramFeedPostTargetDetailsUiState():
                    return InstagramFeedSchedulePostRequestTargetDetails(
                      userId: it.userId,
                    );
                  
                  case InstagramStoryPostTargetDetailsUiState():
                    return InstagramStorySchedulePostRequestTargetDetails(
                    userId: it.userId,
                  );
                }
              }),
            );
          })
          .toList(),

        title: uiState.value.title,
        caption: uiState.value.caption,
        medias: uiState.value.medias.map((e) => e.id).toIList(),
      );

      await _schedulePostInteractor.perform(schedulePostParameters);
    }
    finally {
      uiState.add( uiState.value.copyWith(isLoading: false) );
    }

    uiState.value = uiState.value.copyWith(poppingPage: true);
  }

  void openValidationErrorsDialogButtonClicked() {
    uiState.add(
      uiState.value.copyWith(
        validationErrorsDialog: uiState.value.validationErrorsDialog.copyWith(isOpen: true,),
      ),
    );
  }

  void validationErrorsDialogClosed() {
    uiState.add(
      uiState.value.copyWith(
        validationErrorsDialog: uiState.value.validationErrorsDialog.copyWith(isOpen: false,),
      ),
    );
  }

  Future<Map<PostTargetType, List<String>>> _validatePost() async {
    final medias = <ValidatePostRequestMedia>[];
    for (final uploadedMedia in uiState.value.medias) {
      var media = ValidatePostRequestMedia(
        mimeType: uploadedMedia.mimeType,
        size: uploadedMedia.size,
        details: uploadedMedia.details.let((aDetails) {
          if (uploadedMedia.mimeType.type == 'image') {
            var details = aDetails as ImageAddedMediaDetailsUiState;
            return ValidatePostRequestImageMediaDetails(width: details.width, height: details.height,);
          }
          else if (uploadedMedia.mimeType.type == 'video') {
            return const ValidatePostRequestVideoMediaDetails(length: 0);
          }
          else {
            throw Error();
          }
        }),
      );

      medias.add(media);
    }

    Map<PostTargetType, List<String>> validationErrors = await _validatePostInteractor.validate(
      ValidatePostRequest(
        targets: uiState.value.targets.map((e) => e.targetType).toList(),
        validatingPost: ValidatePostRequestValidatingPost(
          title: uiState.value.title,
          caption: uiState.value.caption,
          media: medias.toList(),
        ),
      )
    );

    return validationErrors;
  }


  final uiState = BehaviorSubject.seeded(AddPostRequestPageUiState.initial());

  final Uuid _uuid = const Uuid();

  final _getFacebookPagesInteractor =
    GetIt.instance<GetPlatformConnectionFacebookPagesInteractor>();
  final _schedulePostInteractor = GetIt.instance<SchedulePostInteractor>();
  final _validatePostInteractor = GetIt.instance<ValidatePostInteractor>();
  final _getUserMediasInteractor = GetIt.instance<GetUserMediasInteractor>();
}
