import 'package:flutter/material.dart';

class itemappbar extends StatefulWidget {
  const itemappbar({super.key});

  @override
  State<itemappbar> createState() => _itemappbarState();
}

class _itemappbarState extends State<itemappbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(25),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              size: 30,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Padding(padding: EdgeInsets.only(left: 20),
          child: Text("Product",style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor),),)
        ],
      ),
    );
  }
}
