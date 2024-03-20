import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meditation/theme/dark_theme.dart';
import 'package:meditation/theme/light_theme.dart';
import 'package:meditation/view/login/login_screen.dart';
import 'package:meditation/view_model/controller/localization/localization_controller.dart';
import 'package:meditation/view_model/controller/login/login_controller.dart';
import 'package:meditation/view_model/controller/signup/signup_controller.dart';
import 'package:meditation/view_model/controller/stats/stats_controller.dart';
import 'package:meditation/view_model/controller/theme/theme_controller.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>LoginController()),
        ChangeNotifierProvider(create: (_)=>SignUpController()),
        ChangeNotifierProvider(create: (_)=>StatsController()),
        ChangeNotifierProvider(create: (_)=>ThemeModeProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ],

      child:Consumer<ThemeModeProvider>(
        builder: (context, themeModeProvider, _) {
          return MaterialApp(

            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeModeProvider.themeMode,
            home: LoginScreen(),
          );
        },
      ),
    );
  }
}
