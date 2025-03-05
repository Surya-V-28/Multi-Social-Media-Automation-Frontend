import 'package:business_logic/business_logic.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:post_scheduler/utils/list_insert_between_extension.dart';

class PostRequestListTile extends StatelessWidget {
  const PostRequestListTile({
    super.key,
    required this.scheduledDateTime,
    required this.isFulfilled,
    required this.caption,
    required this.platforms,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Card(
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: _calculateBorderRadius(theme)),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (!isFulfilled)
              const Icon(Icons.timer)
            else
              const Icon(Icons.check, color: Colors.green),

            const SizedBox(width: 4.0),

            Text("${DateFormat('hh:mm').format(scheduledDateTime.toLocal())} am"),
          ],
        ),
        subtitle: Text(caption, overflow: TextOverflow.ellipsis),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: platforms
            .map<Widget>(
              (element) {
                final IconData icon;
                if (element == SocialMediaPlatform.facebook) {
                  icon = FontAwesomeIcons.facebook;
                }
                else if (element == SocialMediaPlatform.instagram) {
                  icon = FontAwesomeIcons.instagram;
                }
                else {
                  throw Error();
                }

                return FaIcon(icon);
              }
            )
            .insertBetween(const SizedBox(width: 8.0)),
        ),
      ),
    );
  }

  BorderRadiusGeometry _calculateBorderRadius(ThemeData theme) {
    return (theme.cardTheme.shape as RoundedRectangleBorder?)?.borderRadius ?? BorderRadius.circular(8.0);
  }


  final DateTime scheduledDateTime;
  final bool isFulfilled;
  final String caption;
  final List<SocialMediaPlatform> platforms;
  final void Function()? onTap;
}
