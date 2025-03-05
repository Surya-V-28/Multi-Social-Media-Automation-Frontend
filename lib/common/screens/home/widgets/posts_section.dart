import 'package:dart_scope_functions/dart_scope_functions.dart';
import 'package:flutter/material.dart';

import 'post_tile.dart';

class PostsSection extends StatefulWidget {
  const PostsSection({super.key, required this.title, required this.postCount, required this.postBuilder});

  @override
  State<PostsSection> createState() => _PostsSectionState();

  final String title;
  final int postCount;
  final Widget Function(BuildContext context, int index) postBuilder;
}

class _PostsSectionState extends State<PostsSection> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(left: Radius.circular(16.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.title, style: theme.textTheme.headlineSmall,),
        
                  TextButton(onPressed: () {}, child: const Text('See all')),
                ],
              ),
            ),
        
            const SizedBox(height: 16.0),
        
            SizedBox(
              height: 256.0,
              child: PageView.builder(
                controller: _postsListController,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return PostTile(
                    platformConnections: const [
                      PlatformConnection(
                        profilePicture: 'https://i.pinimg.com/736x/a3/42/a5/a342a5261e23a03fdfa88be4c793e27e.jpg', 
                        platformIcon: 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/Instagram_icon.png/2048px-Instagram_icon.png',
                      ),
                    ],
                    scheduledTime: DateTime(2024, 01, 04),
                    caption: 'A nice post caption for an amazing post that is',
                    image: 'https://static.vecteezy.com/system/resources/previews/022/471/646/non_2x/super-delicious-burger-social-media-post-template-suitable-for-social-media-posts-and-web-or-internet-ads-illustration-with-photo-college-free-vector.jpg',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  final _postsListController = PageController(viewportFraction: 0.9,);
}
