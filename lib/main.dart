import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:l_m_store/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/intro_screen.dart';


bool show=true;
Future <void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark
  ));
  
  final prefs=await SharedPreferences.getInstance();
  show= prefs.getBool('on boarding') ?? true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home:show ? const Introscreen():const LoginScreen(),);
  }
}

//ProfileScreen());//show ? const Introscreen():const LoginScreen(),);
