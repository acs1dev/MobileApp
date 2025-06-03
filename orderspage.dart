import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamesproject/botnavbar.dart';
import 'package:lottie/lottie.dart';

import 'lastorderpage.dart';

class orderspage extends StatefulWidget {
  const orderspage({super.key});

  @override
  State<orderspage> createState() => _orderspageState();
}

class _orderspageState extends State<orderspage> {
  List order = [];
  CollectionReference oRef = FirebaseFirestore.instance.collection("LastOrders");
  User? user = FirebaseAuth.instance.currentUser;
  final currentuser = FirebaseAuth.instance;
  ShowOrders()async{
   var response = await oRef.where("UserUid",isEqualTo: currentuser.currentUser!.uid).get();
   response.docs.forEach((element) {
    setState(() {
      order.add(element.data());
    });
   });
   print(order);
  }
  @override
  void initState() {
    // TODO: implement initState
     ShowOrders();
    super.initState();
   
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
           Container(
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
                  child: Icon(Icons.arrow_back,color: Theme.of(context).primaryColor,size: 40,)),
                SizedBox(width: 40,),
                Icon(Icons.history,size: 40,
                color: Theme.of(context).primaryColor,),
                Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                  ),
                  child: Text(
                    "My Orders",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                  ),
                ),
                
               
              ],
            ),
          ),
          
          Container(
            height: 530,
            
            child: StreamBuilder(
              stream: oRef.snapshots(),
              builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
              if(snapshot.data!.docs.isEmpty){
               return Center(child: Lottie.asset("assets/loading.json"));
              }
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentsnapshot = 
                  snapshot.data!.docs[index];
                  return
                  documentsnapshot["UserUid"] == currentuser.currentUser!.uid?
                   InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return lastorderpage(date: documentsnapshot["Ordernum"],);
                      },));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          height: 80,
                          width: 180,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 227, 228, 228),
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Order Date:",style: TextStyle(fontSize: 20,color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),),
                             Text(documentsnapshot["orderDate"],style: TextStyle(fontSize: 20,color: Theme.of(context).primaryColor))
                            ],
                          ),
                      ),
                    ),
                  ):Center();
                },
              );
            },),
          )
        ],
      ),
    );
  }
}