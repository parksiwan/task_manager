import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_manager/firebase_options.dart';
import 'package:task_manager/data/database.dart';
import 'package:task_manager/screens/auth/auth.dart';
import 'package:task_manager/screens/dashboard/dashboard_screen.dart';
import 'dart:async';
import 'package:provider/provider.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessaging.instance.setAutoInitEnabled(true);

  final fcmToken = await FirebaseMessaging.instance.getToken();
  print("FCMToken $fcmToken");

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        print('Notification caused app launch.');
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        print('-----------');
        print(notification.body);
        _showNotification(notification);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
    });
  }

  void _showNotification(RemoteNotification notification) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(notification.title ?? ''),
            content: Text(notification.body ?? ''),
          );
        });
  }
  // -------------------------------------------------------------------------------------

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

                secondaryContainer: const Color.fromRGBO(40, 36, 68, 1), // from hollden (main background color)
                secondaryFixed: const Color.fromRGBO(144, 140, 188, 1), // from hollden

                surface: const Color.fromRGBO(40, 36, 68, 1), //   const Color.fromRGBO(40, 36, 68, 1),
                onSurface: const Color.fromRGBO(144, 140, 188, 1),
              ), //Colors.white),
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
