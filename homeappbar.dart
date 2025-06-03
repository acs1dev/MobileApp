import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

import 'cartpage.dart';

class homeappbar extends StatefulWidget {
  
  const homeappbar({super.key});

  @override
  State<homeappbar> createState() => _homeappbarState();
}

class _homeappbarState extends State<homeappbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(25),
      child: Row(
        children: [
          // Icon(
          //   Icons.sort,
          //   size: 30,
          //   color: Theme.of(context).primaryColor,
          // ),
          // IconButton(onPressed: () {
            
          // }, icon: Icon(Icons.sort,size: 30,color: Theme.of(context).primaryColor,)),
          Padding(
            padding: EdgeInsets.only(
              left: 20,
            ),
            child: Text(
              "",
              style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          Spacer(

          ),
          Badge(
            badgeContent: Text("3",style: TextStyle(fontSize: 16,color: Colors.white),),
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return cartpage();
                },));
              },
              child: Icon(Icons.shopping_bag_outlined,size: 32,color:Theme.of(context).primaryColor,),
            ),
          )
        ],
      ),
    );
  }
}
