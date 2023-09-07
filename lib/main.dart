import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nasa_app/pages/login_page.dart';
import 'package:nasa_app/pages/rovers_home_page.dart';
import 'package:nasa_app/routes.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await dotenv.load(
        fileName:
            "config/env/.${const String.fromEnvironment('env', defaultValue: 'prod')}.env");
    runApp(const ProviderScope(child: MyApp()));
  }, (error, stack) {
    //TODO: log with crashlytics
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(),
      routes: {
        Routes.roversHome: (context) => const RoversHomePage(),
        //Routes.roversDetails: (context) => const RestaurantDetailsPage()
      },
    );
  }
}
