import 'package:business_logic/business_logic.dart';
import 'package:flutter/material.dart';
import 'package:post_scheduler/utils/string_utils.dart';

class PlatformConnectionTile extends StatefulWidget {
  const PlatformConnectionTile({
    super.key, 
    required this.platform,
    required this.username,
    this.connected = false,
  });

  @override
  State<PlatformConnectionTile> createState() => _PlatformConnectionTileState();
  
  final SocialMediaPlatform platform;
  final String username;
  final bool connected;
}

class _PlatformConnectionTileState extends State<PlatformConnectionTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: (widget.connected) ? Colors.transparent : null,
      clipBehavior: Clip.hardEdge,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: (widget.connected) 
            ? const LinearGradient(colors: [Color(0xFF9095A1), Color(0xFF171A1F)], begin: Alignment.topCenter, end: Alignment.bottomCenter,) 
            : null,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.platform.name.toSentenceCase(), style: const TextStyle(fontWeight: FontWeight.bold)),
              
                  const SizedBox(height: 8.0),
              
                  Text(widget.username),
              
                  const SizedBox(height: 16.0),
              
                  OutlinedButton(
                    onPressed: (widget.connected) ? () {} : null, 
                    child: Text((widget.connected) ? 'Connected' : 'Disconnected'),
                  ),
                ]
              ),
            
              const Spacer(),
            
              SizedBox.square(
                dimension: 128.0,
                child: Image(
                  image: AssetImage('assets/platform_connections_page/platform_icons/${widget.platform.name}.webp'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
