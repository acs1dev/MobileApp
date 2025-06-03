import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class adminorderspage extends StatefulWidget {
  const adminorderspage({super.key});

  @override
  State<adminorderspage> createState() => _adminorderspageState();
}

class _adminorderspageState extends State<adminorderspage> {
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
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back,color: Theme.of(context).primaryColor,size: 40,)),
                SizedBox(width: 40,),
                Icon(Icons.history,size: 35,
                color: Theme.of(context).primaryColor,),
                Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                  ),
                  child: Text(
                    "Customers Orders",
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
                   Padding(
                     padding: const EdgeInsets.only(right: 8,left: 8,top: 35),
                     child: Container(
                         height: 120,
                         width: 180,
                         decoration: BoxDecoration(
                           color: Color.fromARGB(255, 227, 228, 228),
                           borderRadius: BorderRadius.circular(20)
                         ),
                         child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          
                           children: [
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                               children: [
                                 Text("Order Date:",style: TextStyle(fontSize: 20,color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),),
                                Text(documentsnapshot["orderDate"],style: TextStyle(fontSize: 20,color: Theme.of(context).primaryColor))
                               ],
                             ),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                               children: [
                                 Text("Cust Email:",style: TextStyle(fontSize: 20,color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),),
                                Text(documentsnapshot["CustEmail"],style: TextStyle(fontSize: 20,color: Theme.of(context).primaryColor))
                               ],
                             ),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                               children: [
                                 Text("Total price:",style: TextStyle(fontSize: 20,color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),),
                                Text(documentsnapshot["Total"].toString()+" SR",style: TextStyle(fontSize: 20,color: Theme.of(context).primaryColor))
                               ],
                             ),
                           ],
                         ),
                     ),
                   );
                },
              );
            },),
          )
        ],
      ),
    );
  }
}