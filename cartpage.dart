import 'dart:math';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gamesproject/cartservice.dart';
import 'package:gamesproject/orderspage.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import 'cartappbar.dart';
import 'cartbottomnavbar.dart';
import 'cartitemsaple.dart';

class cartpage extends StatefulWidget {
  const cartpage({super.key});
  @override
  State<cartpage> createState() => _cartpageState();
}

class _cartpageState extends State<cartpage> {

  User? user = FirebaseAuth.instance.currentUser;
  final currentuser = FirebaseAuth.instance;
  

  List MyList = [];

  CollectionReference ListRef = FirebaseFirestore.instance.collection("Cart");

  myprav() async {
    var res =
        await ListRef.where("UserUid", isEqualTo: currentuser.currentUser!.uid)
            .get();
    res.docs.forEach((element) {
      setState(() {
        MyList.add(element.data());
      });
    });
    print(MyList);
  }

  Future<void> Delete(String GameId) async {
    await ListRef.doc(GameId).delete();
  }

  DeleteAll(String Uid)async{
   ListRef.where("UserUid",isEqualTo: currentuser.currentUser!.uid)
   .get()
   .then((value) => value.docs.forEach((element) { 
    ListRef.doc(element.id).delete();
   }));
  }
  String formattedDate = DateFormat.yMMMEd().add_jm().format(DateTime.now());
  var ordernum = Random().nextInt(11111);
  CollectionReference LO = FirebaseFirestore.instance.collection("LastOrders");
  LastOrders(String Uid,double TotalPrice,var CustEmail)async{
   FirebaseFirestore.instance.collection("LastOrders").add(
    {
      "UserUid":Uid,
      "orderDate":formattedDate,
      "Total":TotalPrice,
      "Ordernum":"#$ordernum",
        "CustEmail":CustEmail
    }
   );
  }

  double total2 = 0;
  gettotal() {
    double total = 0;

    FirebaseFirestore.instance
        .collection("Cart")
        .where("UserUid", isEqualTo: currentuser.currentUser!.uid)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        setState(() {
          total = total + element["Price"];
          total2 = total;
        });
      });
    });
  }

  int count = 1;
  @override
  void initState() {
    // TODO: implement initState
    gettotal();
    myprav();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          cartappbar(),
          Container(
            height: 700,
            padding: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 235, 235, 235),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35))),
            child: Column(
              children: [
                Container(
                  height: 420,
                  child: StreamBuilder(
                    stream: ListRef.snapshots(),
                    builder:
                        (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      if (streamSnapshot.data!.docs.isEmpty) {
                        return Container(
                          child: Column(
                            children: [
                              Lottie.asset("assets/emptycart.json"),
                              Text(
                                "Sorry your cart is empty!!",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: streamSnapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                              streamSnapshot.data!.docs[index];
                          return Container(
                              height: 110,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(children: [
                                Container(
                                  height: 140,
                                  width: 140,
                                  margin: EdgeInsets.only(right: 15),
                                  child: Image(
                                    image: NetworkImage(
                                        documentSnapshot["Image"].toString()),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Container(
                                    height: 100,
                                    width: 140,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          documentSnapshot["Gamename"],
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                        Text(
                                          documentSnapshot["Price"].toString(),
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                Delete(documentSnapshot.id);
                                              });
                                            },
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                              size: 30,
                                            ),
                                          ),
                                        ]))
                              ]));
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          height: 130,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total:",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "$total2",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    
                    LastOrders(currentuser.currentUser!.uid, total2,currentuser.currentUser!.email);
                    
                    DeleteAll(currentuser.currentUser!.uid);
                    
                    total2 = 0.0;
                    final snackBar = SnackBar(
                                                    duration:
                                                        Duration(seconds: 3),

                                                    /// need to set following properties for best effect of awesome_snackbar_content
                                                    elevation: 0,
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    content:
                                                        AwesomeSnackbarContent(
                                                      title:
                                                          'Your order has been placed successfuly',
                                                      message:
                                                          'You will be navigated to your orders page',

                                                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                                      contentType:
                                                          ContentType.success,
                                                    ),
                                                  );

                                                  ScaffoldMessenger.of(context)
                                                    ..hideCurrentSnackBar()
                                                    ..showSnackBar(snackBar);
                                                
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return orderspage();
                    },));
                    
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "Check Out",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
