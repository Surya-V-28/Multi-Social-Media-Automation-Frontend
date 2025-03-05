import 'package:collection/collection.dart';
import 'package:dart_scope_functions/dart_scope_functions.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:post_scheduler/utils/side_effect.dart';

import 'post_target_cards/facebook_page/add_dialog.dart';
import 'post_target_cards/instagram_feed/add_dialog.dart';
import 'target_card_builder.dart';
import 'post_target_cards/instagram_story/add_dialog.dart';
import 'validation_errors_dialog.dart';
import 'view_model/add_post_request_page_view_model.dart';

import 'view_model/ui_state/add_post_request_page_ui_state.dart';
import 'widgets/image_list_tile.dart';
import 'widgets/date_picker_field/date_picker_field.dart';
import 'widgets/time_picker_field/time_picker_field.dart';

class AddPostRequestPage extends StatefulWidget {
  const AddPostRequestPage({super.key});

  @override
  State<AddPostRequestPage> createState() => _AddPostRequestPageState();
}

class _AddPostRequestPageState extends State<AddPostRequestPage> {
  @override
  void initState() {
    super.initState();

    _popPageSideEffect = SideEffect<bool>(
      observee: _viewModel.uiState.map((value) => value.poppingPage),
      doWhen: (previous, current) => previous != current && current == true,
      sideEffect: (value) => GoRouter.of(context).pop(),
    );

    _openValidationErrorsDialogSideEffect = SideEffect<bool>(
      observee: _viewModel.uiState.map((value) => value.validationErrorsDialog.isOpen,),
      doWhen: (previous, current) => previous != current && current == true,
      sideEffect: (value) async {
        await showDialog(context: context, builder: (context) => ValidationErrorsDialog(_viewModel.uiState.value.validationErrorsDialog.errors));
        _viewModel.validationErrorsDialogClosed();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AddPostRequestPageUiState>(
      stream: _viewModel.uiState,
      builder: (context, snapshot) {
        return Stack(
          children: <Widget>[
            Scaffold(
              appBar: AppBar(
                title: const Text('Add Post Request'),
                actions: <Widget>[
                  _viewModel.uiState.value.validationErrorsDialog.let((dialogUiState) {
                    var hasErrors = dialogUiState.errors.values.flattenedToList.isNotEmpty;

                    return IconButton(
                      onPressed: (hasErrors) ?
                        () => _viewModel.openValidationErrorsDialogButtonClicked() :
                        null,
                      icon: Icon(
                        Icons.warning,
                        color: (hasErrors) ? Colors.red : Colors.grey,
                      ),
                    );
                  }),

                  IconButton(
                    // onPressed: _confirmButtonOnClicked,
                    onPressed: () => _viewModel.confirmButtonClicked(),
                    icon: const Icon(Icons.check,),
                  ),
                ],
              ),
              // floatingActionButton: FloatingActionButton(
              //   onPressed: _addImageButtonOnPressed,
              //   tooltip: 'Add Image',
              //   child: const Icon(Icons.add),
              // ),
              body: _buildBody(),
            ),

            if (_viewModel.uiState.value.isLoading)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withValues(alpha: 0.3),
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator.adaptive(),
                ),
              ),
          ],
        );
      }
    );
  }

  Widget _buildBody() {
    final ThemeData theme = Theme.of(context);
    
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildScheduledDateTimeCard(),

            const SizedBox(height: 32.0),

            TextField(
              controller: _titleFieldController,
              onChanged: (value) => _viewModel.titleChanged(value),
              decoration: const InputDecoration(hintText: 'Title'),
            ),

            const SizedBox(height: 32.0),

            TextField(
              controller: _captionFieldController,
              onChanged: (value) => _viewModel.captionChanged(value),
              decoration: const InputDecoration(hintText: 'Caption'),
            ),

            const SizedBox(height: 32.0),

            _buildMediasArea(theme),

            const SizedBox(height: 32.0),
    
            _buildPostTargetCardsArea(),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduledDateTimeCard() {
    final DateTime scheduledDateTime = _viewModel.uiState.value.scheduledDateTime;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
        mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            DatePickerField(
              value: DateTime(scheduledDateTime.year, scheduledDateTime.month, scheduledDateTime.day),
              lastDate: DateTime.now().add(const Duration(days: 365)),
              onChanged: (value) {
                _viewModel.scheduledDateTimeChanged(
                  scheduledDateTime.copyWith(
                    year: value.year,
                    month: value.month,
                    day: value.day,
                  )
                );
              },
              decoration: const InputDecoration(label: Text('Scheduled Date')),
            ),
            
            const SizedBox(height: 16.0),
            
            TimePickerField(
              value: scheduledDateTime,
              onChanged: (value) {
                _viewModel.scheduledDateTimeChanged(
                  scheduledDateTime.copyWith(hour: value.hour, minute: value.minute)
                );
              },
              decoration: const InputDecoration(label: Text('Scheduled Time')),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMediasArea(final ThemeData theme) {
    final IList<AddedMediaUiState> medias = _viewModel.uiState.value.medias;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Medias', style: theme.textTheme.headlineMedium),

                IconButton(
                  onPressed: () async {
                    final pickedMedia = await GoRouter.of(context).push<List<String>>('/media-library/picker', extra: {'picked': medias.map((e) => e.id).toList()});
                    if (pickedMedia == null) {
                      return;
                    }

                    _viewModel.mediaPicked(pickedMedia);
                  },
                  icon: const Icon(Icons.add)
                ),
              ],
            ),
        
            const SizedBox(height: 16.0),
        
            ...medias
              .mapIndexed(
                (index, element) => MediaListTile(
                  name: element.name,
                  removeButtonOnClicked: () => _viewModel.mediaRemoved(index),
                )
              ),
          ]
        ),
      ),
    );
  }

  Widget _buildPostTargetCardsArea() {
    final ThemeData theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Targets', style: theme.textTheme.headlineMedium),

            MenuAnchor(
              menuChildren: [
                MenuItemButton(
                  onPressed: () async {
                    final dialogResponse = await showDialog<AddFacebookPagePostTargetDialogResponse>(
                        context: context,
                        builder: (context) => const AddFacebookPagePostTargetDialog(),
                    );

                    _viewModel.addTargetDialogClosed(dialogResponse);
                  },
                  child: const Text('Facebook Page'),
                ),

                MenuItemButton(
                  onPressed: () async {
                    final dialogResponse = await showDialog<AddInstagramFeedPostTargetDialogResponse>(
                      context: context,
                      builder: (context) => const AddInstagramFeedPostTargetDialog(),
                    );

                    _viewModel.addTargetDialogClosed(dialogResponse);
                  },
                  child: const Text('Instagram Feed'),
                ),

                MenuItemButton(
                  onPressed: () async {
                    final dialogResponse = await showDialog<AddInstagramStoryPostTargetDialogResponse>(
                      context: context,
                      builder: (context) => const AddInstagramStoryPostTargetDialog(),
                    );

                    _viewModel.addTargetDialogClosed(dialogResponse);
                  },
                  child: const Text('Instagram Story'),
                ),
              ],
              builder: (context, controller, child) {
                return IconButton(
                  onPressed: () {
                    if (!controller.isOpen) {
                      controller.open();
                    }
                    else {
                      controller.close();
                    }
                  },
                  icon: child!,
                );
              },
              child: const Icon(Icons.add)
            ),
          ],
        ),

        const SizedBox(height: 32.0),

        for (final targetUiState in _viewModel.uiState.value.targets)
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 32.0),

              buildTargetCard(targetUiState, _viewModel),
            ],
          ),
      ]
    );
  }

  //void _addImageButtonOnPressed() async {
  //  final XFile? selectedImage = await _imagePicker.pickImage(source: ImageSource.gallery);
  //
  //  if (!mounted || selectedImage == null) {
  //    return;
  //  }
  //
  //  _viewModel.imageAdded(selectedImage);
  //}
  //
  //void _addVideoButtonOnPressed() async {
  //  final selectedVideo = await _imagePicker.pickVideo(source: ImageSource.gallery);
  //
  //  if (!mounted || selectedVideo == null) {
  //    return;
  //  }
  //
  //  _viewModel.videoAdded(selectedVideo);
  //}

  @override
  void dispose() {
    _popPageSideEffect.dispose();
    _openValidationErrorsDialogSideEffect.dispose();

    super.dispose();
  }


  late final SideEffect<bool> _popPageSideEffect;
  late final SideEffect<bool> _openValidationErrorsDialogSideEffect;

  final TextEditingController _titleFieldController = TextEditingController();
  final TextEditingController _captionFieldController = TextEditingController();

  final AddPostRequestPageViewModel _viewModel = AddPostRequestPageViewModel();
}
