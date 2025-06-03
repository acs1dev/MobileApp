import 'package:flutter/material.dart';
import 'package:gamesproject/gamespage.dart';

class categorieswidget extends StatefulWidget {
  
   const categorieswidget({super.key});
   
  @override
  State<categorieswidget> createState() => _categorieswidgetState();
}

class _categorieswidgetState extends State<categorieswidget> {
  cat(var img, String catname) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(img),
            height: 50,
            width: 60,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            catname,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Theme.of(context).primaryColor),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
            InkWell(
            onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) {
                return gamespage(cat: "All",con: "images/conto.jpg");
              },));
            },
            child: cat("images/conto.jpg", "All Games"),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return gamespage(cat: "Shooter",con: "images/aim.png");
              },));
            },
            child: cat("images/aim.png", "Shooter"),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return gamespage(cat: "Horror",con:"images/ghost.png" );
              },));
            },
            child:  cat("images/ghost.png", "Horror"),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return gamespage(cat: "Sport",con:"images/foot.jpg" );
              },));
            },
            child:    cat("images/foot.jpg", "Sport"),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return gamespage(cat: "Cars",con: "images/caro.jpg");
              },));
            },
            child:   cat("images/caro.jpg", "Cars"),
          ),
         
        
       
        ],
      ),
    );
  }
}
