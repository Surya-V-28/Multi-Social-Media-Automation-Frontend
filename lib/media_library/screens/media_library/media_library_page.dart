import 'package:business_logic/business_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';

import 'package:dart_scope_functions/dart_scope_functions.dart';
import 'package:post_scheduler/media_library/screens/media_library/add_media_dialog.dart';

class MediaLibraryPage extends HookWidget {
  const MediaLibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final getUserMediasInteractor = useRef(GetIt.instance<GetUserMediasInteractor>()).value;
    final deleteMediaInteractor = useRef(GetIt.instance<DeleteMediaInteractor>()).value;

    final loading = useState<bool>(false);
    final medias = useState<List<Media>>([]);

    Future<void> fetchMedia() async {
      loading.value = true;
      medias.value = await getUserMediasInteractor.perform();
      loading.value = false;
    }

    useEffect(
      () {
        fetchMedia();
        return null;
      },
      []
    );

    Future<void> deleteMedia(String id) async {
      loading.value = true;
      await deleteMediaInteractor.perform(id);
      loading.value = false;

      fetchMedia();
    }

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text('Media Library'),
            actions: [
              IconButton(
                onPressed: () async {
                  await showModalBottomSheet(
                    context: context,
                    builder: (context) => const AddMediaDialog(),
                  );

                  await fetchMedia();
                }, 
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          body: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: medias.value.length,
            itemBuilder: (context, index) {
              final media = medias.value[index];
        
              return Card(
                clipBehavior: Clip.hardEdge,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    media.let((e) {
                      if (e.typeDetails is ImageMediaTypeDetails) {
                        return Image(
                          image: NetworkImage(e.mediaInfo.url),
                          fit: BoxFit.cover,
                        );
                      }
                      else {
                        return const Center(
                          child: Icon(Icons.video_library, size: 64.0),
                        );
                      }
                    }),

                    Positioned(
                      top: 4.0,
                      right: 4.0,
                      child: IconButton(
                        onPressed: () => deleteMedia(media.mediaInfo.keyId),
                        icon: const Icon(Icons.delete),
                      ),
                    ),
                  ],
                ),
              );
            }
          ),
        ),

        if (loading.value)
          Container(
            width: double.infinity, height: double.infinity,
            color: Colors.black.withValues(alpha: 0.5),
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          ),
      ],
    );
  }
}
