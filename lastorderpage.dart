import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class lastorderpage extends StatefulWidget {
  String date;
   lastorderpage({super.key,required this.date});

  @override
  State<lastorderpage> createState() => _lastorderpageState();
}

class _lastorderpageState extends State<lastorderpage> {
    List order = [];
  CollectionReference oRef = FirebaseFirestore.instance.collection("LastOrders");
  User? user = FirebaseAuth.instance.currentUser;
  final currentuser = FirebaseAuth.instance;
  ShowOrders()async{
   var response = await oRef
   .get();
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
    super.initState();
    ShowOrders();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 670,
            child: StreamBuilder(
              stream: oRef.snapshots(),
              builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
                if(snapshot.data!.docs.isEmpty){
                 return Center(child: Lottie.asset("assets/loading.json"),);
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                  final DocumentSnapshot documentsnapshot=
                  snapshot.data!.docs[index];
                  return 
                  documentsnapshot["Ordernum"] == widget.date ?
                   Padding(
             padding: const EdgeInsets.only(right: 8,left: 8,top: 120),
             child: Container(
              height: 300,
              width: 100,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(topLeft:Radius.circular(40),topRight: Radius.circular(40),bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Order number: ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 23),),
                    
                      Text(documentsnapshot["Ordernum"],style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 23),),
                    ],
                  
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Order Date: ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 21),),
                    
                      Text(documentsnapshot["orderDate"],style: TextStyle(color: Colors.white,fontSize: 20),),
                    ],
                  
                  ),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Total Price: ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 23),),
                    
                      Text(documentsnapshot["Total"].toString(),style: TextStyle(color: Colors.white,fontSize: 20),),
                      Text(" SR",style: TextStyle(color: Colors.white,fontSize: 20),)
                    ],
                  
                  ),
                ],
              ),
             ),
           ):Center();
                },);
              },
            ),
          ),

          TextButton(onPressed: () {
            Navigator.pop(context);
          }, child: Text("Go Back",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 22,fontWeight: FontWeight.bold),))
        ],
      ),
    );
  }
}