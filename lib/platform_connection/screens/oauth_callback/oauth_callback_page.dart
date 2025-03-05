import 'package:business_logic/business_logic.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class PlatformConnectionsOAuthCallbackPage extends StatefulWidget {
  const PlatformConnectionsOAuthCallbackPage({super.key, required this.authorizationCode, required this.platform, this.redirectTo,});

  @override
  State<PlatformConnectionsOAuthCallbackPage> createState() => _PlatformConnectionsOAuthCallbackPageState();


  final String authorizationCode;
  final SocialMediaPlatform platform;
  final String? redirectTo;
}

class _PlatformConnectionsOAuthCallbackPageState extends State<PlatformConnectionsOAuthCallbackPage> {
  @override
  void initState() {
    super.initState();

    print("CustomLog: Authorization code = ${widget.authorizationCode}");

    Future<void> asyncPart() async {
      final getAccessTokenResponse = await _getPlatformAccessTokenInteractor.getAccessToken(widget.platform, widget.authorizationCode);

      await _addPlatformConnectionsInteractor.add(widget.platform, getAccessTokenResponse.accessToken, getAccessTokenResponse.refreshToken, getAccessTokenResponse.expiresAt);
      if (!mounted) return;

      GoRouter.of(context).go(widget.redirectTo ?? '/platform-connections');
    }

    asyncPart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Platform Connections OAuth Callback',),),
      body: Container(
        padding: const EdgeInsets.all(16.0,),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),

            const SizedBox(height: 32.0,),

            Text(widget.authorizationCode,),
          ],
        ),
      ),
    );
  }


  final _getPlatformAccessTokenInteractor = GetIt.instance<GetPlatformAccessTokenInteractor>();
  final _addPlatformConnectionsInteractor = GetIt.instance<ConnectToPlatformInteractor>();
}
