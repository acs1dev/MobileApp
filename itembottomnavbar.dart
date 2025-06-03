import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class itembottomnavbar extends StatefulWidget {
  const itembottomnavbar({super.key});

  @override
  State<itembottomnavbar> createState() => _itembottomnavbarState();
}

class _itembottomnavbarState extends State<itembottomnavbar> {
  List GamesList = [];
  CollectionReference gameRef = FirebaseFirestore.instance.collection("Games");

    ShowGames() async {
    var response =
        await gameRef.get();
    response.docs.forEach((element) {
      setState(() {
        GamesList.add(element.data());
      });
    });
    print("--------------------------------------------------------------");
    print(GamesList);
  }
  @override
  void initState() {
    // TODO: implement initState
    ShowGames();
    super.initState();
  }
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 10,
                offset: Offset(0, 3),
              )
            ]),
        // child: Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
           
        //     ElevatedButton.icon(
        //       onPressed: () {},
        //       icon: Icon(CupertinoIcons.cart_badge_plus,color: Colors.white,size: 30,),
        //       label: Text(
        //         "Add to cart",
        //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
        //       ),
        //       style: ButtonStyle(
        //         backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
        //         padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 13,horizontal: 15)),
        //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        //         ),
        //       ),
              
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
