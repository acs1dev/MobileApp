import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gamesproject/adminhomepage.dart';
import 'package:gamesproject/theme_helper.dart';
import 'package:lottie/lottie.dart';


class editgamespage extends StatefulWidget {
  const editgamespage({super.key});

  @override
  State<editgamespage> createState() => _editgamespageState();
}

class _editgamespageState extends State<editgamespage>
with SingleTickerProviderStateMixin {
  late AnimationController controller;
   bool isLoaded = false;
  // List GamesList = [];
  // CollectionReference gameRef = FirebaseFirestore.instance.collection("Games");

  // ShowGames() async {
  //   var response = await gameRef.get();
  //   response.docs.forEach((element) {
  //     setState(() {
  //       GamesList.add(element.data());
  //     });
  //   });
  //   print("--------------------------------------------------------------");
  //   print(GamesList);
  // }
  final CollectionReference gameRef =
      FirebaseFirestore.instance.collection("Games");
  final TextEditingController _PriceController = TextEditingController();
  Future<void> update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _PriceController.text = documentSnapshot["Price"].toString();
    }
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TextField(
                //   controller: _PriceController,
                //   decoration: const InputDecoration(
                //     labelText: 'Price',
                //   ),
                // ),
                Container(
                  child: TextFormField(
                     keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                    controller: _PriceController,
                    decoration: ThemeHelper()
                        .textInputDecoration("Price", "Enter new price"),
                  ),
                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                    style: ThemeHelper().buttonStyle(),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                      child: Text(
                        "Update".toUpperCase(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onPressed: () async {
                      final double? price = double.tryParse(_PriceController.text);
                      if (price != null) {
                        await gameRef
                            .doc(documentSnapshot!.id)
                            .update({"Price": price});

                        _PriceController.text = '';

                        Navigator.of(context).pop();
                        final snackBar = SnackBar(
                          duration: Duration(seconds: 3),

                          /// need to set following properties for best effect of awesome_snackbar_content
                          elevation: 0,
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          content: AwesomeSnackbarContent(
                            title: 'Price updated successfully',
                            message:
                                'The new price you have entered has been changed in database successfully',

                            /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                            contentType: ContentType.success,
                          ),
                        );

                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(snackBar);
                      }
                    },
                  ),
                )
              ],
            ),
          );
        });
  }

  @override
 void initState() {
    controller = AnimationController
    (vsync: this,
    duration: Duration(milliseconds: 750));
    controller.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        setState(() {
          isLoaded = true;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Container(
            height: 650,
            color: Colors.grey.withOpacity(0.3),
            child: StreamBuilder(
              stream: gameRef.snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.data == null) {
                return  Center(child: Lottie.asset("assets/loading.json"));
                }
                

                  return GridView.builder(
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
                                  image:
                                      NetworkImage(documentSnapshot["Image"]),
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
                                            color: Theme.of(context)
                                                .primaryColor)),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          update(documentSnapshot);
                                        });
                                      },
                                      child: Icon(
                                        Icons.edit,
                                        size: 30,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                
              },
            )),
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
