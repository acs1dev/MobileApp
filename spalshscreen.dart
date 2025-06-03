// ignore_for_file: prefer_final_fields, unnecessary_new, deprecated_member_use, prefer_const_constructors, sort_child_properties_last, camel_case_types

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gamesproject/loginpage.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  bool _isVisible = false;
  _splashscreenState(){
    new Timer(const Duration(milliseconds: 2000),(){
      setState(() {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => loginpage()), (route) => false);
      });
    });
    new Timer(Duration(milliseconds: 10),
    (() {
      setState(() {
        _isVisible = true;
      });
    }
    ));
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [
                Theme.of(context).accentColor,
                Theme.of(context).primaryColor
              ],
              begin: const FractionalOffset(0, 0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp)),
      child: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0,
        duration: Duration(milliseconds: 1200),
        child: Center(
          child: Container(
            height: 220.0,
            width: 220.0,
            child: Center(
              child: ClipOval(
                  child: Image(image: AssetImage("images/gamelogo.PNG"),) 
              ),
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 8.0,
                  offset: Offset(12.0,1.0),
                  spreadRadius: 2.0
                )
              ]
            ),
          ),
        ),
      ),
    );
  }
}
