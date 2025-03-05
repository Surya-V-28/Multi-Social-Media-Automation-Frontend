import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import 'package:business_logic/business_logic.dart';

class OAuthCallbackPage extends StatefulWidget {
  const OAuthCallbackPage({super.key, required this.authorizationCode});

  @override
  State<OAuthCallbackPage> createState() => _OAuthCallbackPageState();


  final String authorizationCode;
}

class _OAuthCallbackPageState extends State<OAuthCallbackPage> {
  @override
  void initState() {
    super.initState();

    Future<void> asyncPart() async {
      await _cognitoSocialLoginInteractor.login(widget.authorizationCode);
      if (!mounted) return;

      GoRouter.of(context).go('/calendar');
    }

    asyncPart();
  }


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Logging in'),
      
            SizedBox(height: 32.0),
      
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }



  final _cognitoSocialLoginInteractor = GetIt.instance<CognitoSocialLoginInteractor>();
}
