import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/app/app.dart';
import 'package:stream_feed_flutter_core/stream_feed_flutter_core.dart';
import '../components/login/login.dart';

/// {@template app}
/// Main entry point to the Stream-agram application.
/// {@endtemplate}
class MyApp extends StatefulWidget {
  /// {@macro app}
  const MyApp({
    Key? key,
    required this.appTheme,
  }) : super(key: key);

  /// App's theme data.
  final AppTheme appTheme;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _client = StreamFeedClient('9knd6zpadf8m');
  late final appState = AppState(client: _client);

  // Important to only initialize this once.
  // Unless you want to update the bloc state
  late final feedBloc = FeedBloc(client: _client);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: appState,
      child: MaterialApp(
        title: 'Удачи!',
        theme: widget.appTheme.lightTheme,
        darkTheme: widget.appTheme.darkTheme,
        themeMode: ThemeMode.light,
        builder: (context, child) {
          // Stream Feeds provider to give access to [FeedBloc]
          // This class comes from Stream Feeds.
          return FeedProvider(
            bloc: feedBloc,
            child: child!,
          );
        },
        home: const LoginScreen(),
      ),
    );
  }
}
