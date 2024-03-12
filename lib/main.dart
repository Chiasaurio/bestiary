import 'package:animal_collectables/presentation/providers/auth_provider.dart';
import 'package:animal_collectables/presentation/screens/home_page.dart';
import 'package:animal_collectables/presentation/screens/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'presentation/theme/colors.dart';

void main() async {
  // locatorSetupComponent(false, 'dev');
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthModel()),
        // other providers
      ],
      builder: (context, child) => MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          dividerColor: rebeccaPurple,
          primarySwatch: Colors.purple,
          primaryColor: purple,
          scaffoldBackgroundColor: Colors.transparent,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
          ),
          brightness: Brightness.light,
          dividerTheme:
              DividerThemeData(color: Colors.grey[350], thickness: 1.0),
          useMaterial3: true,
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(width: 1.0, color: primary),
              foregroundColor: Colors.white,
              backgroundColor: primary.withOpacity(0.5),
            ),
          ),
        ),
        home: Consumer<AuthModel>(builder: (context, authState, _) {
          return authState.isSignedIn ? const HomePage() : const SignInPage();
          // : FutureBuilder(
          //     future: authState.tryLogin(),
          //     builder: (context, snapshot) =>
          //         snapshot.connectionState == ConnectionState.waiting
          //             ? const SplashPage()
          //             : const SignInPage()
          //     // authState.displayedOnboard
          //     //     ? const LoginPage()
          //     //     : const OnboardScreen(),
          //     );
        }),
      ),
    );
  }
}
