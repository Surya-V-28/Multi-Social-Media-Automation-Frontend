import 'package:flutter/material.dart';

class MediaListTile extends StatelessWidget {
  const MediaListTile({
    super.key, 
    required this.name,
    required this.removeButtonOnClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(name),
            trailing: _buildCancelButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildCancelButton() {
    return IconButton(onPressed: removeButtonOnClicked, icon: const Icon(Icons.cancel));
  }
  


  final String name;
  final void Function() removeButtonOnClicked;
}
