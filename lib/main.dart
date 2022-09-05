import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:material_color_generator/material_color_generator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/Start/mainPage.dart';
import 'Screens/Start/onBoarding.dart';
import 'Screens/Start/start_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
      statusBarBrightness: Brightness.light, // For iOS (dark icons)
    ),
  );
  await Firebase.initializeApp();
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;
  final loggedIn = prefs.getBool('LoggedIn') ?? false;
  prefs.setBool("showHome", true);
  runApp(MyApp(
    showHome: showHome,
    LoggedIn: loggedIn,
  ));
}

class MyApp extends StatelessWidget {
  bool showHome;
  bool LoggedIn;

  MyApp({Key? key, required this.showHome, required this.LoggedIn})
      : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: generateMaterialColor(color: const Color(0xFF22A45D)),
      ),
      home: showHome
          ? LoggedIn
              ? const mainPage()
              : Start()
          : const introPage(),
    );
  }
}
