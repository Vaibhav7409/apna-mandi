import 'package:apna_mandi/pages/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:apna_mandi/providers/user_provider.dart';
import 'package:apna_mandi/providers/slot_bookings_provider.dart';
import 'package:apna_mandi/providers/theme_provider.dart';
import 'package:apna_mandi/providers/cart_provider.dart';
import 'package:apna_mandi/providers/language_provider.dart';
import 'package:logging/logging.dart';
import 'package:apna_mandi/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';

// Debug checker to help with development
bool isDebugMode = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize EasyLocalization
  await EasyLocalization.ensureInitialized();

  // Initialize logging
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    debugPrint('${record.level.name}: ${record.time}: ${record.message}');
  });

  // Set debug mode based on Flutter's assert mode
  isDebugMode = true;
  assert(() {
    isDebugMode = true;
    return true;
  }());

  final logger = Logger('Main');
  logger.info('App started in ${isDebugMode ? 'DEBUG' : 'RELEASE'} mode');

  try {
    // Initialize Firebase with options
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    logger.info('Firebase initialized successfully');

    // Check Firebase Auth
    final auth = FirebaseAuth.instance;
    logger.info('Firebase Auth initialized: ${auth.app.name}');

    // Check if user is already signed in
    final currentUser = auth.currentUser;
    if (currentUser != null) {
      logger.info('User already signed in: ${currentUser.uid}');
    } else {
      logger.info('No user currently signed in');
    }
  } catch (e, stackTrace) {
    logger.severe('Failed to initialize Firebase: $e');
    logger.fine('Stack trace: $stackTrace');
  }

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('hi'),
        Locale('pa'),
        Locale('gu'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => SlotBookingsProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Apna Mandi',
            theme: themeProvider.theme,
            home: const Onboarding(),
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
          );
        },
      ),
    );
  }
}
