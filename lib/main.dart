import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
// import 'package:system_network_proxy/system_network_proxy.dart';

import 'package:first/screens/login_screen.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemNetworkProxy.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android,
  );
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Email And Password Login',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}