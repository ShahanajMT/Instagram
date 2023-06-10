import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/Views/UI/screens/login_Screen.dart';
import 'package:instagram_flutter/Views/UI/screens/signup_screen.dart';
import 'package:instagram_flutter/responsive/mobile_Screen_layout.dart';
import 'package:instagram_flutter/responsive/responsive_screen_layout.dart';
import 'package:instagram_flutter/responsive/web_screen_layout.dart';
import 'package:instagram_flutter/util/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDSPwzhItyxOU5hl5HcHaE1XuF3cz5Jecs",
        appId: "1:125942513678:web:b66de3652ba75f5a713c5f",
        messagingSenderId: "125942513678",
        projectId: "125942513678",
        storageBucket: "instagramapp-89166.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram clone',
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
      // home: const ResponsiveScreenLayout(
      //   webScreenLayout: WebScreenLayout(),
      //   mobileScreenLayout: MobileScreenLayout(),
      // ),
      home: const LoginScreen(),
    );
  }
}
