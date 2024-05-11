import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_manager/firebase_options.dart';
import 'package:task_manager/data/database.dart';
import 'package:task_manager/screens/auth/auth.dart';
import 'package:task_manager/screens/dashboard/dashboard_screen.dart';
import 'dart:async';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserInfoProvider>(
      create: (context) => UserInfoProvider(),
      child: MaterialApp(
          title: "Task Manager",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                  seedColor: const Color.fromRGBO(1, 45, 115, 1),
                  primary: const Color.fromRGBO(120, 180, 156, 1), // from hollden
                  onPrimary: const Color.fromRGBO(176, 244, 252, 1), // from hollden
                  secondary: const Color.fromRGBO(42, 41, 77, 1), // from holden (background color of tile or card)
                  background: const Color.fromRGBO(40, 36, 68, 1), // from hollden (main background color)
                  onBackground: const Color.fromRGBO(144, 140, 188, 1), // from hollden
                  surface: const Color.fromRGBO(40, 36, 68, 1),
                  onSurface: Colors.white),
              useMaterial3: true),
          home: const AuthPage() // SplashScreen(),
          ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashboardScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [
            Color(0xFFFF800B),
            Color(0xFFCE1010),
          ]),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                //Image.asset(
                //  "assets/images/challan.png",
                //  height: 300.0,
                //  width: 300.0,
                //),
                Text(
                  "Task Manager",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "powered by Siwan",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
            ),
          ],
        ),
      ),
    );
  }
}
