import 'package:flutter/material.dart';

class PostTile extends StatefulWidget {
  const PostTile({
    super.key,
    required this.scheduledTime,
    required this.platformConnections,
    required this.image,
    required this.caption,
  });

  @override
  State<PostTile> createState() => _PostTileState();

  final DateTime scheduledTime;
  final List<PlatformConnection> platformConnections;
  final String image;
  final String caption;
}

class PlatformConnection {
  const PlatformConnection({required this.profilePicture, required this.platformIcon});

  final String profilePicture;
  final String platformIcon;
}

class _PostTileState extends State<PostTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1e1d22),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: DefaultTextStyle(
          style: const TextStyle(color: Colors.white),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DefaultTextStyle(
                style: const TextStyle(color: Color(0xFFC7C9CB)),
                child: Row(
                  children: [
                    const Text('Jan 14, 2024'),
                
                    const SizedBox(width: 8.0),
                
                    const Text('10:30AM'),
                
                    const Spacer(),
                
                    //ElevatedButton(onPressed: () {}, child: const Text('Posted'),),
                    //
                    //const SizedBox(width: 8.0),
                
                    IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert), color: const Color(0xFFBDC1CA),),
                  ]
                ),
              ),

              Row(
                children: widget.platformConnections
                  .map((e) => _buildPlatformConnection(e))
                  .toList(),
              ),

              const SizedBox(height: 16.0,),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: SizedBox(
                      width: 96.0,
                      height: 102.0,
                      child: Image(
                        image: NetworkImage(widget.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(width: 16.0),

                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.caption,
                          maxLines: 2,
                          style: const TextStyle(color: Color(0xFF7C7D80)),
                        ),
                    
                        TextButton(onPressed: () {}, child: const Text('Read more'),),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlatformConnection(PlatformConnection platformConnection) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(3000.0),
            child: SizedBox.square(
              dimension: 32.0,
              child: Image(
                image: NetworkImage(platformConnection.profilePicture),
              ),
            ),
          ),

          Positioned(
            bottom: -4.0,
            right: -4.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3000.0),
              child: SizedBox.square(
                dimension: 24.0,
                child: ColoredBox(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Image(
                      image: NetworkImage(platformConnection.platformIcon),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
