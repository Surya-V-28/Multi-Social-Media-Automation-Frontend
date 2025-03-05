import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class PostListTile extends StatelessWidget {
  const PostListTile({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Card(
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: _calculateBorderRadius(theme)),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(Icons.timer),

            const SizedBox(width: 4.0),

            Text("${DateFormat('hh:mm').format(DateTime.now())} am"),
          ],
        ),
        subtitle: const Text('Sample Caption for the sample app #TestCaption2024', overflow: TextOverflow.ellipsis),
        onTap: () {},
        trailing: const Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FaIcon(FontAwesomeIcons.facebook),

            SizedBox(width: 8.0),

            FaIcon(FontAwesomeIcons.instagram),
          ],
        ),
      ),
    );
  }

  BorderRadiusGeometry _calculateBorderRadius(ThemeData theme) {
    return (theme.cardTheme.shape as RoundedRectangleBorder?)?.borderRadius ?? BorderRadius.circular(8.0);
  }
}
