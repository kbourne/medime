import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'screens/dashboard_screen.dart';
import 'models/muser.dart';
import 'screens/login/login_screen.dart';
import 'transition_route_observer.dart';

/// Requires that a Firebase local emulator is running locally.
/// See https://firebase.flutter.dev/docs/auth/start/#optional-prototype-and-test-with-firebase-local-emulator-suite
bool shouldUseFirebaseEmulator = false;

void main() async {

  // DotEnv dotenv = DotEnv() is automatically called during import.
  // If you want to load multiple dotenv files or name your dotenv object differently, you can do the following and import the singleton into the relavant files:
  // DotEnv another_dotenv = DotEnv()
  // To load the .env file contents into dotenv.
  // NOTE: fileName defaults to .env and can be omitted in this case.
  // Ensure that the filename corresponds to the path in step 1 and 2.
  // await dotenv.load(fileName: ".env");

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();


  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor:
      SystemUiOverlayStyle.dark.systemNavigationBarColor,
    ),
  );

  // runApp(const MyApp());

  runApp(ChangeNotifierProvider<Muser>(
    create: (_) => Muser(),
    child: MyApp(),),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Demo',
      theme: _buildTheme(),
      debugShowCheckedModeBanner: false,
      navigatorObservers: [TransitionRouteObserver()],
      initialRoute: LoginScreen.routeName,
      // initialRoute: (userExists) ? (emailVerified) ? BottomNavigator.routeName : EmailVerification.routeName : LoginScreen.routeName,
      routes: {
        LoginScreen.routeName: (context) => const LoginScreen(),
        DashboardScreen.routeName: (context) => const DashboardScreen(),
      },
    );
  }
}

ThemeData _buildTheme() {
  var baseTheme = ThemeData();

  return baseTheme.copyWith(
    useMaterial3: true,
    primaryColor: Colors.blue.shade900,
    // brightness: Brightness.light,
    textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.white),
    // fontFamily: 'SourceSansPro',
    textTheme: TextTheme(
      displaySmall: const TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 45.0,
        // fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      labelLarge: const TextStyle(
        // OpenSans is similar to NotoSans but the uppercases look a bit better IMO
        fontFamily: 'OpenSans',
      ),
      bodySmall: TextStyle(
        fontFamily: 'NotoSans',
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: Colors.deepPurple[300],
      ),
      displayLarge: const TextStyle(fontFamily: 'Quicksand'),
      displayMedium: const TextStyle(fontFamily: 'Quicksand'),
      headlineMedium: const TextStyle(fontFamily: 'Quicksand'),
      headlineSmall: const TextStyle(fontFamily: 'NotoSans'),
      titleLarge: const TextStyle(fontFamily: 'NotoSans'),
      titleMedium: const TextStyle(fontFamily: 'NotoSans'),
      bodyLarge: const TextStyle(fontFamily: 'NotoSans'),
      bodyMedium: const TextStyle(fontFamily: 'NotoSans'),
      titleSmall: const TextStyle(fontFamily: 'NotoSans'),
      labelSmall: const TextStyle(fontFamily: 'NotoSans'),
    ),
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple)
        .copyWith(secondary: Colors.orange),
  );
}