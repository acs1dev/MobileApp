import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:intl/intl.dart';

class cartservice{
  CollectionReference cart = FirebaseFirestore.instance.collection("Cart");
  User? user = FirebaseAuth.instance.currentUser;
  String formattedDate = DateFormat.yMMMEd().format(DateTime.now());
  Future<void>addToCart(String name,double price,String cat){
    cart.doc(user?.uid).set({
      "user":user?.uid,
      "orderdate":formattedDate,
    });
    return cart.doc(user?.uid).collection("Products").add({
      "Gamename":name,
      "Gamecategory":cat,
      "Price":price,
      "Qty":1
    });
  }
}
class ordero{
  CollectionReference order = FirebaseFirestore.instance.collection("Orders");
  User? user = FirebaseAuth.instance.currentUser;
   String formattedDate = DateFormat.yMMMEd().format(DateTime.now());
  Future<void>addToOrders(String gamename,double gamePrice){
    order.doc(user?.uid).set({
      "user":user?.uid,
      "orderdate":formattedDate
    });
    return order.doc(user?.uid).collection("Order").add({
      "Gamename":gamename,
      "Price":gamePrice,
   
    });
  }
}
// class cartoo{
//   Future<String?>addCollection(String name,int price)async{
//     CollectionReference users = FirebaseFirestore.instance.collection("Cart");
//     await users.add({
//       "Gamename":name,
//       "Price":price,
//     });
//   }
// }