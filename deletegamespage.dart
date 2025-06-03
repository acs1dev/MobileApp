import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quickalert/quickalert.dart';
class deletegamespage extends StatefulWidget {
  const deletegamespage({super.key});

  @override
  State<deletegamespage> createState() => _deletegamespageState();
}

class _deletegamespageState extends State<deletegamespage> {
    final CollectionReference gameRef = FirebaseFirestore.instance.collection("Games");
  final TextEditingController _PriceController = TextEditingController();

  Future<void>Delete(String GameId)async{
    await gameRef.doc(GameId).delete();

  
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  ListView(children: [
              Container(
                height: 650,
                color: Colors.grey.withOpacity(0.3),
                child: StreamBuilder(
                  stream: gameRef.snapshots(),
                  builder: (context,AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if(streamSnapshot.hasData){
                     return  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                      return Padding(
                        padding: EdgeInsets.all(10),
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image(
                                image: NetworkImage(documentSnapshot["Image"]),
                                height: 90,
                                width: 170,
                              ),
                              Text(
                                documentSnapshot["Gamename"],
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(documentSnapshot["Price"].toString() + " SR",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Theme.of(context).primaryColor)),
                                  InkWell(
                                    onTap: () {
                                      QuickAlert.show(
                                        type: QuickAlertType.warning,
                                        context: context,
                                        text: "Are you sure, you want to delete this game ?",
                                        showCancelBtn: true,
                                        cancelBtnText: "Cancel",
                                        confirmBtnColor: Theme.of(context).primaryColor,
                                        confirmBtnText: "Yes, delete",
                                        onCancelBtnTap: () {
                                          Navigator.pop(context);
                                        },
                                        onConfirmBtnTap: () {
                                            setState(() {
                                     
                                     Delete(documentSnapshot.id);
                                       Navigator.pop(context);
                                       final snackBar = SnackBar(
                                  duration: Duration(seconds: 3),
                    /// need to set following properties for best effect of awesome_snackbar_content
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Game deleted successfuly',
                      message:
                          'The game you have selected has been deleted from database successfully',

                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                      contentType: ContentType.success,
                    ),
                  );

                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);
                                      });
                                        },
                                      );
                                    
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      size: 30,
                                      color: Colors.red,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    });
                    }
                    return  Center(child: Lottie.asset("assets/loading.json"))
                    ;
                  },
                )
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Go Back",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 20),
                  ))
            ]),
    );
  }
}