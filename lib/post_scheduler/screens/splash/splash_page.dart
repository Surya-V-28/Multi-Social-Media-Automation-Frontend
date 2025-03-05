import 'package:business_logic/business_logic.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future asyncPart() async {
      await initializeLoggedInUserInteractor.perform();
      final user = await getLoggedInUserInteractor.perform();
      if (!mounted) return;

      final openingPage = (user == null) ?
        '/auth/login' :
        '/calendar';

      GoRouter.of(context).go(openingPage);
    }

    asyncPart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Splash Page')),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return const Center(
        child: CircularProgressIndicator.adaptive(),
    );
  }


  final initializeLoggedInUserInteractor = GetIt.instance<InitializeLoggedInUserInteractor>();
  final getLoggedInUserInteractor = GetIt.instance<GetLoggedInUserInteractor>();
}
