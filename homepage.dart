import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gamesproject/cartservice.dart';
import 'package:gamesproject/gamespage.dart';
import 'package:gamesproject/homeappbar.dart';
import 'package:gamesproject/itempage.dart';
import 'package:gamesproject/loginpage.dart';
import 'package:gamesproject/orderspage.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:quickalert/quickalert.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import 'cartpage.dart';
import 'categorieswidget.dart';
import 'itemswidget.dart';

class homepage extends StatefulWidget {
  
  
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List GamesList = [];

  CollectionReference gameRef = FirebaseFirestore.instance.collection("Games");
  CollectionReference user = FirebaseFirestore.instance.collection("Customers");
  User? user1 = FirebaseAuth.instance.currentUser;

  ShowGames() async {
    var response =
        await gameRef.orderBy("Price", descending: true).limit(6).get();
    response.docs.forEach((element) {
      setState(() {
        GamesList.add(element.data());
      });
    });
    print("--------------------------------------------------------------");
    print(GamesList);
  }
  
  String formattedDate = DateFormat.yMMMEd().add_jm().format(DateTime.now());
  addgame(String gamname, double prc, String image) async {
    FirebaseFirestore.instance.collection("Cart").add({
      
      "Gamename": gamname,
      "Price": prc,
      "Image": image,
      "UserUid": user1!.uid,
      "orderdate": formattedDate,
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
      key: _scaffoldKey,
      drawer: Drawer(
          backgroundColor: Theme.of(context).primaryColor,
          child: Column(
            children: [
              SizedBox(
                height: 45,
              ),
              Container(
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 6.5,
                        spreadRadius: 0.1)
                  ],
                  image: DecorationImage(
                    image: AssetImage("images/user.png"),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                "Welcome,",
                style: TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                 "${user1!.email}",
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
              SizedBox(
                height: 60,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return orderspage();
                    },
                  ));
                },
                child: Card(
                  color: Color.fromARGB(255, 18, 127, 170).withOpacity(0.1),
                  child: ListTile(
                    title: Text(
                      "My orders",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    leading: Icon(
                      Icons.history,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 225,
              ),
              InkWell(
                onTap: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return loginpage();
                      },
                    ));
                  });
                },
                child: Card(
                  color: Color.fromARGB(255, 18, 127, 170).withOpacity(0.1),
                  child: ListTile(
                    title: Text(
                      "Log Out",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    leading: Icon(
                      Icons.logout_outlined,
                      color: Colors.red,
                      size: 35,
                    ),
                  ),
                ),
              ),
            ],
          )),
      body: ListView(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(25),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      _scaffoldKey.currentState?.openDrawer();
                    },
                    icon: Icon(
                      Icons.sort,
                      size: 30,
                      color: Theme.of(context).primaryColor,
                    )),
                Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                  ),
                  child: Text(
                    "Pro Gamers Shop",
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                  ),
                ),
                Spacer(),
                
                Badge(
                  badgeContent: Text(
                   "",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return cartpage();
                        },
                      ));
                    },
                    child: Icon(
                      Icons.shopping_bag_outlined,
                      size: 32,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 235, 235, 235),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      35,
                    ),
                    topRight: Radius.circular(
                      35,
                    ))),
            child: Column(
              children: [
                // Container(
                //   margin: EdgeInsets.symmetric(horizontal: 15),
                //   padding: EdgeInsets.symmetric(horizontal: 15),
                //   height: 50,
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(30),
                //   ),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Container(
                //         margin: EdgeInsets.only(left: 5),
                //         height: 50,
                //         width: 327,
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.end,
                //           children: [
                //             Text("Search Here...",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Theme.of(context).primaryColor),),
                //             IconButton(onPressed: () {
                            
                //             }, icon: Icon(Icons.search,size: 30,),color: Theme.of(context).primaryColor)
                //           ],
                //         ),
                //         child: TextFormField(
                //           decoration: InputDecoration(
                //             border: InputBorder.none,
                //             hintText: "Search here...",
                //             suffixIcon: Icon(
                //               Icons.search,
                //               size: 30,
                //             ),
                //           ),
                //         ),
                //       )
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text(
                    "Categories",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                  ),
                ),
                categorieswidget(),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Text(
                    "Best selling",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                  ),
                ),
                Container(
                  height: 350,
                  child: GamesList.isEmpty || GamesList == null
                      ? Center(child: Lottie.asset("assets/loading.json"))
                      : ListView(children: [
                          Container(

                            height: 330,
                            color: Color.fromARGB(255, 235, 235, 235),
                            child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2),
                                itemCount: GamesList.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 6),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                InkWell(
                                                    onTap: () {
                                                      Navigator.push(context,
                                                          MaterialPageRoute(
                                                        builder: (context) {
                                                          return itempage(
                                                            name: GamesList[
                                                                    index]
                                                                ["Gamename"],
                                                          );
                                                        },
                                                      ));
                                                    },
                                                    child: Icon(
                                                      Icons.info_outline,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    ))
                                              ],
                                            ),
                                          ),
                                          Image(
                                            image: NetworkImage(
                                                GamesList[index]["Image"]),
                                            height: 100,
                                            width: 140,
                                          ),
                                          Text(
                                            GamesList[index]["Gamename"],
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                  GamesList[index]["Price"]
                                                          .toString() +
                                                      " SR",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                              InkWell(
                                                onTap: () {
                                               
                                                  addgame(
                                                      GamesList[index]
                                                          ["Gamename"],
                                                      GamesList[index]["Price"],
                                                      GamesList[index]
                                                          ["Image"]
                                                          );
                                                  setState(() {
                                                    co++;
                                                  });
                                                  final snackBar = SnackBar(
                                                    duration:
                                                        Duration(seconds: 1),

                                                    /// need to set following properties for best effect of awesome_snackbar_content
                                                    elevation: 0,
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    content:
                                                        AwesomeSnackbarContent(
                                                      title:
                                                          'Added to cart successfuly',
                                                      message:
                                                          'The game you have selected has been added to your cart successfully',

                                                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                                      contentType:
                                                          ContentType.success,
                                                    ),
                                                  );

                                                  ScaffoldMessenger.of(context)
                                                    ..hideCurrentSnackBar()
                                                    ..showSnackBar(snackBar);
                                                },
                                                child: Icon(
                                                  Icons.shopping_cart_checkout,
                                                  color: Theme.of(context)
                                                      .primaryColor,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}


