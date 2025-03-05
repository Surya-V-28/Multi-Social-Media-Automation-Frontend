import 'package:business_logic/business_logic.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';

MediaPickerPageViewModel useViewModel(List<String> picked) {
  final getMediasInteractor = useRef(GetIt.instance<GetUserMediasInteractor>()).value;

  final isLoading = useState<bool>(true);
  final mediaCards = useState<IList<MediaCardUiState>>(const IList.empty());
  final poppingPage = useState<bool>(false);

  return MediaPickerPageViewModel(
    isLoading: isLoading.value,
    mediaCards: mediaCards.value,
    selectionCount: mediaCards.value.where((e) => e.isSelected).length,
    poppingPage: poppingPage.value,

    pageOpened: () async {
      final medias = await getMediasInteractor.perform();
      mediaCards.value = medias
        .map((e) => MediaCardUiState(id: e.mediaInfo.keyId, mimeType: e.mediaInfo.mimeType, url: e.mediaInfo.url, isSelected: picked.contains(e.mediaInfo.keyId)))
        .toIList();

      isLoading.value = false;
    },
    mediaCardClicked: (id) {
      mediaCards.value = mediaCards.value.replaceFirstWhere(
        (e) => e.id == id, 
        (x) => x!.copyWith(isSelected: !x.isSelected),
      );
    },
    confirmButtonClicked: () {
      poppingPage.value = true;
    },
  );
}

class MediaPickerPageViewModel {
  const MediaPickerPageViewModel({
    required this.isLoading,
    required this.mediaCards,
    required this.selectionCount,
    required this.poppingPage,

    required this.pageOpened,
    required this.mediaCardClicked,
    required this.confirmButtonClicked,
  });

  final bool isLoading;
  final IList<MediaCardUiState> mediaCards;
  final int selectionCount;
  final bool poppingPage;

  final void Function() pageOpened;
  final void Function(String id) mediaCardClicked;
  final void Function() confirmButtonClicked;
}

class MediaCardUiState {
  const MediaCardUiState({
    required this.id,
    required this.mimeType,
    required this.url,
    required this.isSelected,
  });

  MediaCardUiState copyWith({
    String? id,
    MimeType? mimeType,
    String? url,
    bool? isSelected,
  }) {
    return MediaCardUiState(
      id: id ?? this.id,
      mimeType: mimeType ?? this.mimeType,
      url: url ?? this.url,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  final String id;
  final MimeType mimeType;
  final String url;
  final bool isSelected;
}
