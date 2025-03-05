import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:business_logic/business_logic.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'authentication/screens/sign_up/email_sign_up_page.dart';
import 'authentication/screens/sign_up/sign_up_page.dart';
import 'package:post_scheduler/authentication/screens/login/login_page.dart';
import 'package:post_scheduler/authentication/screens/oauth_callback/oauth_callback_page.dart';

import 'package:post_scheduler/common/screens/home/home_page.dart';

import 'package:post_scheduler/media_library/screens/media_library/media_library_page.dart';
import 'package:post_scheduler/media_library/screens/media_library_picker/media_library_picker_page.dart';
import 'package:post_scheduler/notification/screens/notifications/notifications_page.dart';
import 'package:post_scheduler/platform_connection/screens/oauth_callback/oauth_callback_page.dart';
import 'package:post_scheduler/platform_connection/screens/platform_connections/platform_connections_page.dart';
import 'package:post_scheduler/post_scheduler/screens/add_post_request_page/add_post_request_page.dart';
import 'package:post_scheduler/post_scheduler/screens/analytics/facebook_page_analytics_page.dart';
import 'package:post_scheduler/post_scheduler/screens/analytics/instagram_feed/instagram_feed_analytics_page.dart';
import 'package:post_scheduler/post_scheduler/screens/calendar_widget/calendar_widget_page.dart';
import 'package:post_scheduler/post_scheduler/screens/post_requests_calendar_page/post_requests_calendar_page.dart';
import 'package:post_scheduler/post_scheduler/screens/post_requests_list/post_requests_list_page.dart';
import 'package:post_scheduler/post_scheduler/screens/scheduled_post_details_page/scheduled_post_details_page.dart';
import 'post_scheduler/screens/splash/splash_page.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();

    _appLinksStreamSubscription = _appLinks.uriLinkStream.listen((uri) {
      if (!mounted) return;

      _router.go(uri.toString());
    });
  }

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     theme: ThemeData.light(useMaterial3: true).copyWith(
  //       inputDecorationTheme: InputDecorationTheme(
  //         enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
  //         contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
  //       ),
  //     ),
  //     home: const SplashPage(),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData.light();

    const primaryColor = Color(0xFF21A54D);

    final colorScheme = ColorScheme.fromSeed(
      seedColor: primaryColor, 
      surface: const Color(0xFFdee1e6),
      primaryContainer: primaryColor,
      onPrimaryContainer: Colors.white,
      onSurface: Colors.black,
    );

    return MaterialApp.router(
      theme: ThemeData.light()
      .copyWith(
        colorScheme: colorScheme,
        scaffoldBackgroundColor: const Color(0xFFbdc1ca),
        textTheme: GoogleFonts.alataTextTheme()
        .copyWith(
          bodySmall: GoogleFonts.anuphan(textStyle: theme.textTheme.bodySmall),
          bodyMedium: GoogleFonts.anuphan(textStyle: theme.textTheme.bodyMedium),
          bodyLarge: GoogleFonts.anuphan(textStyle: theme.textTheme.bodyLarge),
          labelSmall: GoogleFonts.anuphan(textStyle: theme.textTheme.labelSmall),
          labelMedium: GoogleFonts.anuphan(textStyle: theme.textTheme.labelMedium),
          labelLarge: GoogleFonts.anuphan(textStyle: theme.textTheme.labelLarge),
        ),
        appBarTheme: const AppBarTheme(centerTitle: true, backgroundColor: Colors.transparent, elevation: 0.0,),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: BorderSide.none),
          filled: true,
          fillColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: WidgetStateProperty.resolveWith((states) {
              return RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              );
            }),
            backgroundColor: WidgetStateProperty.resolveWith((states) {
              if (!states.contains(WidgetState.disabled)) {
                return colorScheme.primaryContainer;
              }
              
              return null;
            }),
            foregroundColor: WidgetStateProperty.all(colorScheme.onPrimaryContainer), 
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0),)
            ),
            side: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.disabled)) return const BorderSide(color: Color(0xFF8F97A8));

              return null;
            }),
            backgroundColor: WidgetStateProperty.all(Colors.white),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            textStyle: WidgetStateProperty.all(const TextStyle(fontWeight: FontWeight.bold)),
            foregroundColor: WidgetStateProperty.all(const Color(0xFF1F5FAF)),
          ),
        ),
        cardTheme: CardThemeData(elevation: 0.0, color: colorScheme.surface,),
        tabBarTheme: TabBarThemeData(
          dividerHeight: 0.0,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          labelColor: colorScheme.onSurface,
          indicatorColor: colorScheme.onSurface,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          elevation: 0.0,
        ),
      ),
      routerConfig: _router,
    );
  }
  
  @override
  void dispose() {
    _appLinksStreamSubscription.cancel();

    super.dispose();
  }


  final _appLinks = AppLinks();
  late final StreamSubscription<Uri> _appLinksStreamSubscription;

  final GoRouter _router = GoRouter(
    initialLocation: '/splash',
    routes: <RouteBase>[
      GoRoute(
        path: '/calendar-widget',
        builder: (context, state) => const CalendarWidgetPage(),
      ),
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashPage(),
      ),

      GoRoute(
        path: '/auth/sign-up',
        builder: (context, state) => const SignUpPage(),
      ),

      GoRoute(
        path: '/auth/sign-up/email',
        builder: (context, state) => EmailSignUpPage(email: (state.extra as Map<String, String>)['email']!),
      ),

      GoRoute(
        path: '/auth/login',
        builder: (context, state) => const LoginPage(),
      ),

      GoRoute(
        path: "/auth/cognito/oauth-callback",
        builder: (context, state) => OAuthCallbackPage(authorizationCode: state.uri.queryParameters['code']!),
      ),

      GoRoute(
        path: '/home',
        builder: (context, state) => const HomePage(),
      ),

      GoRoute(
        path: '/platform-connections',
        builder: (context, state) => const PlatformConnectionsPage(),
      ),

      GoRoute(
        path: '/platform-connection-oauth-callback',
        builder: (context, state) {
          return PlatformConnectionsOAuthCallbackPage(
            authorizationCode: state.uri.queryParameters['code']!,
            platform: SocialMediaPlatform.parse(state.uri.queryParameters['state']!),
          );
        },
      ),

      GoRoute(
        path: '/calendar',
        builder: (context, state) => const PostRequestsCalendarPage(),
        routes: <RouteBase>[
          GoRoute(
            path: '/:date',
            builder: (context, state) => PostRequestsListPage(date: DateTime.parse(state.pathParameters['date']!),),
          ),
        ],
      ),

      GoRoute(
        path: '/media-library',
        builder: (context, state) => const MediaLibraryPage(),
      ),

      GoRoute(
        path: '/media-library/picker',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? <String, dynamic>{};
          return MediaLibraryPickerPage(picked: extra['picked'] as List<String>? ?? []);
        },
      ),

      GoRoute(
        path: "/post-requests/add",
        builder: (context, state) => const AddPostRequestPage(),
      ),

      GoRoute(
        path: '/post-requests/:id',
        builder: (context, state) => ScheduledPostDetailsPage(state.pathParameters['id']!,),
      ),

      GoRoute(
        path: '/analytics/facebook-page/:postId',
        builder: (context, state) => FacebookPageAnalyticsPage(postId: state.pathParameters['postId']!,),
      ),

      GoRoute(
        path: '/analytics/instagram-feed/:postId/:postTargetId',
        builder: (context, state) => InstagramFeedAnalyticsPage(postId: state.pathParameters['postId']!, postTargetId: state.pathParameters['postTargetId']!,),
      ),

      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationsPage(),
      ),
    ],
  );
}
