import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:midjo/firebase_options.dart';
import 'package:midjo/src/states/userinfos.dart';
import 'package:provider/provider.dart';

import 'src/view/home_view.dart';
import 'src/view/splash_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => UserDataProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
