import 'package:flutter/material.dart';
import 'package:gamesproject/botnavbar.dart';
import 'package:gamesproject/homepage.dart';

class cartappbar extends StatefulWidget {
  const cartappbar({super.key});

  @override
  State<cartappbar> createState() => _cartappbarState();
}

class _cartappbarState extends State<cartappbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(25),
      child: Row(
        children: [
          InkWell(
            onTap: () {
             Navigator.push(context, MaterialPageRoute(builder: (context) {
               return botnavbar();
             },));
            },
            child: Icon(
              Icons.arrow_back,
              size: 30,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "Cart",
              style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          Spacer(),
          Icon(Icons.more_vert,
          size: 30,color: Theme.of(context).primaryColor,)
        ],
      ),
    );
  }
}
