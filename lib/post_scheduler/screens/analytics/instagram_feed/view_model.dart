part of './instagram_feed_analytics_page.dart';

ViewModel useViewModel(String mediaId, String postTargetId) {
  final getMetricsInteractor = useRef(GetIt.instance<GetInstagramFeedPostInsightsInteractor>());

  final isLoading = useState<bool>(true);
  final metrics = useState<List<MediaInsight>>([]);

  return ViewModel(
    mediaInsights: metrics.value,

    pageOpened: () async {
      final fetchedMetrics = await getMetricsInteractor.value
          .perform(mediaId, postTargetId);
      metrics.value = fetchedMetrics;
      isLoading.value = false;
    },
  );
}

class ViewModel {
  const ViewModel({
    required this.pageOpened,
    required this.mediaInsights,
  });

  final void Function() pageOpened;
  final List<MediaInsight> mediaInsights;
}