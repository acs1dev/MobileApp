import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class viewgamespage extends StatefulWidget {
  const viewgamespage({super.key});

  @override
  State<viewgamespage> createState() => _viewgamespageState();
}

class _viewgamespageState extends State<viewgamespage> {
  List GamesList = [];
  
CollectionReference gameRef = FirebaseFirestore.instance.collection("Games");
  ShowGames() async {
    
    var response = await gameRef.get();
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
    super.initState();
    ShowGames();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: GamesList.isEmpty || GamesList == null
          ? Center(child: Lottie.asset("assets/loading.json"))
          : ListView(
            children:[ Container(
              height: 650,
              color: Colors.grey.withOpacity(0.3),
              child: GridView.builder(
                  gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemCount: GamesList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(10),
                      child: Card(
                       
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image(image: NetworkImage(GamesList[index]["Image"]),height: 90,width: 170,),
                            Text(GamesList[index]["Gamename"],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor),),
                            Text(GamesList[index]["Price"].toString()+" SR",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor  )),
                          ],
                        ),
                      ),
                    );
                    
                  }
                  ),
            ),
            SizedBox(height: 10,),
            TextButton(onPressed: () {
              Navigator.pop(context);
            }, child: Text("Go Back",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 20),))
         ] ),
    );
  }
}
