import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gamesproject/editgamespage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class lotipage extends StatefulWidget {
  const lotipage({super.key});

  @override
  State<lotipage> createState() => _lotipageState();
}

class _lotipageState extends State<lotipage> 
with SingleTickerProviderStateMixin{
  late AnimationController controller;
   bool isLoaded = false;
  @override
  void initState() {
    controller = AnimationController
    (vsync: this,
    duration: Duration(milliseconds: 750));
    controller.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        setState(() {
          isLoaded = true;
        });
      }
    });
    super.initState();
  }
  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Lottie.asset("assets/loading.json",
        controller: controller,
        onLoaded: (comp) {
          controller.duration = comp.duration;
          controller.forward().whenComplete(() => Navigator.push(context, MaterialPageRoute(builder: (context) {
            return editgamespage();
          },)));
        },),
        
      ),
    );
  }
}