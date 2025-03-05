import 'package:flutter/material.dart';
import 'package:post_scheduler/common/screens/home/widgets/posts_section.dart';

import 'widgets/post_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 16.0,),
              child: Column(
                spacing: 16.0,
                children: [
                  PostsSection(
                    title: 'Recent Posts',
                    postCount: 5,
                    postBuilder: (context, index) {
                      return _buildPostTile();
                    },
                  ),
            
                  PostsSection(
                    title: 'Scheduled',
                    postCount: 5,
                    postBuilder: (context, index) {
                      return _buildPostTile();
                    }
                  ),
      
                  PostsSection(
                    title: 'Top Posts',
                    postCount: 5,
                    postBuilder: (context, index) {
                      return _buildPostTile();
                    }
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: const TabBar(
            labelStyle: TextStyle(fontSize: 10.0),
            tabs: [
               Tab(
                text: 'Home',
                icon: Icon(Icons.home),
              ),

               Tab(
                text: 'Stats',
                icon: Icon(Icons.bar_chart),
              ),

               Tab(
                text: 'Create',
                icon: Icon(Icons.add_circle, size: 48.0),
              ),

               Tab(
                text: 'Planner',
                icon: Icon(Icons.calendar_month),
              ),

               Tab(
                text: 'Settings',
                icon: Icon(Icons.person),
              )
            ]
          ),
        ),
      ),
    );
  }

  Widget _buildPostTile() {
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
  }
}
