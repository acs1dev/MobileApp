import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamesproject/cartpage.dart';
import 'package:gamesproject/cartservice.dart';
import 'package:gamesproject/homeappbar.dart';
import 'package:gamesproject/homepage.dart';
import 'package:lottie/lottie.dart';

import 'itempage.dart';

class gamespage extends StatefulWidget {
  var cat;
  String con = "";
  gamespage({super.key, required this.cat, required this.con});

  @override
  State<gamespage> createState() => _gamespageState();
}

class _gamespageState extends State<gamespage> {
  List GamesList = [];

  CollectionReference gameRef = FirebaseFirestore.instance.collection("Games");
    User?user1=FirebaseAuth.instance.currentUser;
  ShowGames() async {
    if(widget.cat=="All"){
       var response =
    
        await  gameRef.get();
    response.docs.forEach((element) {
      setState(() {
        GamesList.add(element.data());
      });
    });
     print("--------------------------------------------------------------");
    print(GamesList);
    }
    else{
 var response =
    
        await  gameRef.where("Gamecategory", isEqualTo: widget.cat).get();
    response.docs.forEach((element) {
      setState(() {
        GamesList.add(element.data());
      });
    });
    print("--------------------------------------------------------------");
    print(GamesList);
    }
   
  }
  
addgame(String gamname,double prc,String image) async {
    FirebaseFirestore.instance.collection("Cart").add({
      "Gamename": gamname,
      "Price": prc,
      "Image":image,
      "UserUid":user1!.uid
    });
   
  }
  cartservice _cart = cartservice();
  int co = 0;
  @override
  void initState() {
    // TODO: implement initState
    ShowGames();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Container(
          color: Colors.white,
          padding: EdgeInsets.all(25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image(
                image: AssetImage(widget.con),
                height: 60,
                width: 60,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 20,
                ),
                child: Text(
                  widget.cat + " Games",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Badge(
                  badgeContent: Text(
                    "",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return cartpage();
                      },));
                    },
                    child: Icon(
                      Icons.shopping_bag_outlined,
                      size: 32,
                      color: Theme.of(context).primaryColor,
                    ),
                  ))
            ],
          ),
        ),
        Container(
          height: 570,
          child: GamesList.isEmpty || GamesList == null
              ? Center(child: Lottie.asset("assets/loading.json"))
              : ListView(children: [
                  Container(
                    height: 570,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 235, 235, 235),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                              30,
                            ),
                            topRight: Radius.circular(
                              30,
                            ))),
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemCount: GamesList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(10),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 6),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                builder: (context) {
                                                  return itempage(
                                                    name: GamesList[index]
                                                        ["Gamename"],
                                                  );
                                                },
                                              ));
                                            },
                                            child: Icon(Icons.info_outline,
                                                color: Theme.of(context)
                                                    .primaryColor))
                                      ],
                                    ),
                                  ),
                                  Image(
                                    image:
                                        NetworkImage(GamesList[index]["Image"]),
                                    height: 80,
                                    width: 140,
                                  ),
                                  Text(
                                    GamesList[index]["Gamename"],
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                          GamesList[index]["Price"].toString() +
                                              " SR",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                      InkWell(
                                        onTap: () {
                                               addgame(GamesList[index]["Gamename"], GamesList[index]["Price"], GamesList[index]["Image"]);
                                              setState(() {
                                                
                                              });
                                                final snackBar = SnackBar(
                                  duration: Duration(seconds: 1),
                    /// need to set following properties for best effect of awesome_snackbar_content
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Added to cart successfuly',
                      message:
                          'The game you have selected has been added to your cart successfully',

                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                      contentType: ContentType.success,
                    ),
                  );

                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);
                                        },
                                        child: Icon(
                                          Icons.shopping_cart_checkout,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ]),
        ),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Go Back",
              style: TextStyle(
                  fontSize: 23, color: Theme.of(context).primaryColor),
            ))
      ]),
    );
  }
}
