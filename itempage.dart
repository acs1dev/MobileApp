import 'package:clippy_flutter/arc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'itemappbar.dart';
import 'itembottomnavbar.dart';

class itempage extends StatefulWidget {
  var name;
  itempage({super.key,required this.name});

  @override
  State<itempage> createState() => _itempageState();
}

class _itempageState extends State<itempage> {
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
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 235, 235),
      body: ListView(
        children: [
         Container(
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
          child: Text(widget.name,style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor),),)
        ],
      ),
    ),
          Container(
           height: 568,
           child: ListView(
            children: [
              Container(
                height: 568,
                child: ListView.builder(
                  itemCount: GamesList.length
                  ,itemBuilder: (context, index) {
                    if(GamesList[index]["Gamename"]==widget.name){
                    return Column(
                      children: [
                        Padding(
            padding: EdgeInsets.all(16),
            child: Image(
              image:NetworkImage(GamesList[index]["Image"]),
              height: 300,
            ),
          ),
                      
          Arc(
            edge: Edge.TOP,
            arcType: ArcType.CONVEY,
            height: 30,
            child: Container(
              width: double.infinity,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 48, bottom: 15),
                      child: Row(
                        children: [
                          Text(
                            GamesList[index]["Gamename"],
                            style: TextStyle(
                                fontSize: 28,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RatingBar.builder(
                            initialRating: 4,
                            minRating: 1,
                            direction: Axis.horizontal,
                            itemCount: 5,
                            itemSize: 20,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            onRatingUpdate: (value) {},
                          ),
                          Row(
                            children: [
                              // Container(
                              //   padding: EdgeInsets.all(5),
                              //   decoration: BoxDecoration(
                              //       color: Colors.white,
                              //       borderRadius: BorderRadius.circular(20),
                              //       boxShadow: [
                              //         BoxShadow(
                              //           color: Colors.grey.withOpacity(0.5),
                              //           spreadRadius: 3,
                              //           blurRadius: 10,
                              //           offset: Offset(0, 3),
                              //         ),
                              //       ]),
                              //   child: Icon(CupertinoIcons.minus,
                              //       size: 18,
                              //       color: Theme.of(context).primaryColor),
                              // ),
                              // Container(
                              //   margin: EdgeInsets.symmetric(horizontal: 10),
                              //   child: Text(
                              //     "1",
                              //     style: TextStyle(
                              //         fontSize: 18,
                              //         fontWeight: FontWeight.bold,
                              //         color: Theme.of(context).primaryColor),
                              //   ),
                              // ),
                              // Container(
                              //   padding: EdgeInsets.all(5),
                              //   decoration: BoxDecoration(
                              //       color: Colors.white,
                              //       borderRadius: BorderRadius.circular(20),
                              //       boxShadow: [
                              //         BoxShadow(
                              //           color: Colors.grey.withOpacity(0.5),
                              //           spreadRadius: 3,
                              //           blurRadius: 10,
                              //           offset: Offset(0, 3),
                              //         ),
                              //       ]),
                              //   child: Icon(CupertinoIcons.plus,
                              //       size: 18,
                              //       color: Theme.of(context).primaryColor),
                              // ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        "This is more detailed description of "+widget.name + " You can here rate the game",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 17,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                   
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(GamesList[index]["Price"].toString()+" SR",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 30,fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
                ],
                    );  }
                    else{
                      return Container();
                    }
  }
  ,),
              )
            ],
           ),
          ),
        ],
      ),
      bottomNavigationBar: itembottomnavbar(),
    );
  }
}
