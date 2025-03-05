import 'package:business_logic/business_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class AddMediaDialog extends HookWidget {
  const AddMediaDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final addMediaInteractor = useRef(GetIt.instance<AddMediaInteractor>()).value;

    final loading = useState<bool>(false);

    Future<void> uploadMedia(XFile file) async {
      await addMediaInteractor.perform(file);
      if (!context.mounted) return;

      GoRouter.of(context).pop();
    }

    Future<void> pickImageButtonClicked() async {
      loading.value = true;
      final imagePicker = ImagePicker();
      final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
      if (!context.mounted) return;

      if (pickedImage == null) {
        loading.value = false;
        return;
      }

      await uploadMedia(pickedImage);
    }

    Future<void> pickVideoButtonClicked() async {
      loading.value = true;
      final imagePicker = ImagePicker();
      final pickedVideo = await imagePicker.pickVideo(source: ImageSource.gallery);
      if (!context.mounted) return;

      if (pickedVideo == null) {
        loading.value = false;
        return;
      }

      await uploadMedia(pickedVideo);
    }

    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text('Upload', style: theme.textTheme.headlineSmall),
          ),

          const SizedBox(height: 16.0),

          ListTile(
            onTap: pickImageButtonClicked,
            leading: const Icon(Icons.image), 
            title: const Text('Image'),
          ),

          ListTile(
            onTap: pickVideoButtonClicked,
            leading: const Icon(Icons.video_library),
            title: const Text('Video'),
          ),
        ],
      ),
    );
  }
} 
