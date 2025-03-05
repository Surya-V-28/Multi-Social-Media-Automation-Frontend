import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationListTile extends StatefulWidget {
  const NotificationListTile({
    super.key,
    required this.leading,
    required this.message,
    required this.createdAt,
    this.onTap,
  });

  @override
  State<NotificationListTile> createState() => _NotificationListTileState();

  final Widget leading;
  final String message;
  final DateTime createdAt;
  final void Function()? onTap;
}

class _NotificationListTileState extends State<NotificationListTile> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      onTap: widget.onTap,
      leading: const CircleAvatar(
        child: Icon(Icons.notifications_on),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(widget.message,),

          Text(_dateFormat.format(widget.createdAt), style: theme.textTheme.bodySmall,),
        ],
      ),
    );
  }


  static final _dateFormat = DateFormat('d/M/y');
}
