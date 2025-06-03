

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gamesproject/itempage.dart';

class itemswidget extends StatefulWidget {
  const itemswidget({super.key});

  @override
  State<itemswidget> createState() => _itemswidgetState();
}

class _itemswidgetState extends State<itemswidget> {

    List GamesList = [];
CollectionReference gameRef = FirebaseFirestore.instance.collection("Games");

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      childAspectRatio: 0.68,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      shrinkWrap: true,
      children: [
         Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 10),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
       
          InkWell(
            onTap: () {
              
            },
            child: Container(
              margin: EdgeInsets.all(10),
              child: Image(
                image: AssetImage("images/gamelogo.PNG"),
                height: 120,
                width: 120,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 8),
            alignment: Alignment.centerLeft,
            child: Text(
              "GTA V",
              style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "A game",
              style: TextStyle(fontSize: 15, color: Theme.of(context).primaryColor),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$55",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
                Icon(
                  Icons.shopping_cart_checkout,
                  color: Theme.of(context).primaryColor,
                )
              ],
            ),
          )
        ],
      ),
    ),
      

        ],
    );
  }
}
