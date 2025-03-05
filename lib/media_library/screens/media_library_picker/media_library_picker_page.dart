import 'package:dart_scope_functions/dart_scope_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import 'view_model.dart';

class MediaLibraryPickerPage extends HookWidget {
  const MediaLibraryPickerPage({super.key, required this.picked});

  @override
  Widget build(BuildContext context) {
    final viewModel = useViewModel(picked);

    useEffect(
      () {
        viewModel.pageOpened();
        return null;
      }, 
      []
    );

    useEffect(
      () {
        if (!viewModel.poppingPage) return;

        final selectedMediaIds = viewModel.mediaCards.where((e) => e.isSelected).map((e) => e.id).toList();
        GoRouter.of(context).pop(selectedMediaIds);
        return null;
      },
      [viewModel.poppingPage]
    );

    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          (viewModel.selectionCount == 0)
            ? 'Media Picker'
            : '${viewModel.selectionCount} selected'
        ),
        actions: [
          IconButton(onPressed: viewModel.confirmButtonClicked, icon: const Icon(Icons.check)),
        ]
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), 
        itemCount: viewModel.mediaCards.length,
        itemBuilder: viewModel.mediaCards.let((it) {
          final finalMediaCards = <MediaCardUiState>[];
          finalMediaCards.addAll(it.where((e) => e.isSelected));
          finalMediaCards.addAll(it.where((e) => !e.isSelected));

          return (context, index) {
              final mediaCard = finalMediaCards[index];

              return Card(
                key: ValueKey<String>(mediaCard.id),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    InkWell(
                      onTap: () => viewModel.mediaCardClicked(mediaCard.id),
                      child: Image(
                        image: NetworkImage(mediaCard.url),
                        fit: BoxFit.cover,
                      ),
                    ),

                    Positioned(
                      right: 8.0,
                      top: 8.0,
                      child: Checkbox(
                        fillColor: WidgetStateProperty.fromMap({
                          WidgetState.selected: null,
                          WidgetState.any : theme.colorScheme.surface,
                        }),
                        value: mediaCard.isSelected,
                        onChanged: (value) {},
                      ),
                    )
                  ],
                ),
              );
            };
        }),
      ),
    );
  }


  final List<String> picked;
}

