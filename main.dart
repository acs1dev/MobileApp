import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gamesproject/addgamespage.dart';
import 'package:gamesproject/adminhomepage.dart';
import 'package:gamesproject/botnavbar.dart';
import 'package:gamesproject/editgamespage.dart';
import 'package:gamesproject/gamespage.dart';
import 'package:gamesproject/homepage.dart';
import 'package:gamesproject/itempage.dart';
import 'package:gamesproject/loginpage.dart';
import 'package:gamesproject/lotipage.dart';
import 'package:gamesproject/regestrationpage.dart';
import 'package:gamesproject/spalshscreen.dart';
import 'package:gamesproject/viewgamespage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';

var isLoggedin;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    isLoggedin = false;
  } else {
    isLoggedin = true;
  }
  runApp(MyApp());
  ErrorWidget.builder = (FlutterErrorDetails details) => Scaffold(
    backgroundColor: Colors.white,
    body: Center(child: Lottie.asset("assets/loading.json"),),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color _primaryColor = HexColor("#0F6A7F");
  Color _accentColor = HexColor("#2EB9C1");

  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: _primaryColor,
          accentColor: _accentColor,
          primarySwatch: Colors.grey),
      home: isLoggedin == true ? 
       botnavbar() : splashscreen(),
    );
  }
}
