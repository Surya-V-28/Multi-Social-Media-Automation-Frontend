import 'package:business_logic/business_logic.dart';
import 'package:collection/collection.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ValidationErrorsDialog extends StatefulWidget {
  const ValidationErrorsDialog(this.errors, {super.key,});

  @override
  State<ValidationErrorsDialog> createState() => _ValidationErrorsDialogState();

  final IMap<PostTargetType, IList<String>> errors;
}

class _ValidationErrorsDialogState extends State<ValidationErrorsDialog> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SimpleDialog(
      title: const Text('Errors'),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                ...widget.errors.entries.map((entry) {
                  return [
                    Text(entry.key.displayForm, style: theme.textTheme.bodyLarge,),
              
                    const SizedBox(height: 8.0),
              
                    ...entry.value.mapIndexed((index, value) {
                      return Padding(
                        padding: EdgeInsets.only(top: (index != 0) ? 8.0 : 0.0),
                        child: Text(value, style: theme.textTheme.bodySmall,),
                      );
                    }),
                  ];
                })
                  .flattenedToList,

              const SizedBox(height: 32.0),

              Align(
                alignment: Alignment.centerRight, 
                child: ElevatedButton(
                  onPressed: () => GoRouter.of(context).pop(),
                  child: const Text('Close'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
