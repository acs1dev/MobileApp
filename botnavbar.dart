import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gamesproject/cartpage.dart';
import 'package:gamesproject/gamespage.dart';
import 'package:gamesproject/homepage.dart';
import 'package:gamesproject/orderspage.dart';

class botnavbar extends StatefulWidget {
  
  const botnavbar({super.key});

  @override
  State<botnavbar> createState() => _botnavbarState();
}

class _botnavbarState extends State<botnavbar> {
    int index = 0;
  final pages = [homepage(),cartpage(),orderspage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: CurvedNavigationBar(
        index: 0,
        backgroundColor: Colors.transparent,
        onTap: (index) => setState(() 
          => this.index = index, 
        ),
        
        height: 70,
        color: Theme.of(context).primaryColor,
        items: [
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            CupertinoIcons.cart_fill,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.history,
            size: 30,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}