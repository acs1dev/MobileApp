import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamesproject/addgamespage.dart';
import 'package:gamesproject/adminorderspage.dart';
import 'package:gamesproject/deletegamespage.dart';
import 'package:gamesproject/editgamespage.dart';
import 'package:gamesproject/itemswidget.dart';
import 'package:gamesproject/lastorderpage.dart';
import 'package:gamesproject/loginpage.dart';
import 'package:gamesproject/lotipage.dart';
import 'package:gamesproject/orderspage.dart';
import 'package:gamesproject/viewgamespage.dart';

class adminhomepage extends StatefulWidget {
  
  const adminhomepage({super.key});

  @override
  State<adminhomepage> createState() => _adminhomepageState();
}

class _adminhomepageState extends State<adminhomepage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
   User? user1 = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        backgroundColor: Theme.of(context).primaryColor,
        child:Column(children: [ 
              SizedBox(height: 45,),
              Container(height: 160,decoration: BoxDecoration(
                shape: BoxShape.circle,
                 boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 6.5,
                    spreadRadius: 0.1
                  )
                 ],
                image: DecorationImage(
                  image: AssetImage("images/user.png"),
                  fit: BoxFit.contain,
                ),
    
              ),),
              SizedBox(height: 25,),
              Text("Welcome,",style: TextStyle(fontSize: 26,color: Colors.white,fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
                             Text("${user1!.email}",style: TextStyle(fontSize: 22,color: Colors.white),),
                                SizedBox(height: 50,),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return viewgamespage();
                      },));
                    },
                    child: Card(
                    color: Color.fromARGB(255, 18, 127, 170).withOpacity(0.1),
                     child: ListTile(
                        title: Text("View Games",style: TextStyle(fontSize: 20,color: Colors.white),),
                        leading: Icon(Icons.gamepad_rounded,color: Colors.white,size: 35,),
                      ),
                                   ),
                  ),      
                 InkWell(
                  onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return addgamespage();
                      },));
                  },
                   child: Card(
                    color: Color.fromARGB(255, 18, 127, 170).withOpacity(0.1),
                     child: ListTile(
                        title: Text("Add Games",style: TextStyle(fontSize: 20,color: Colors.white),),
                        leading: Icon(Icons.add_box_rounded,color: Colors.white,size: 35,),
                      ),
                   ),
                 ),
                 InkWell(
                  onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return editgamespage();
                      },));
                  },
                   child: Card(
                    color: Color.fromARGB(255, 18, 127, 170).withOpacity(0.1),
                     child: ListTile(
                        title: Text("Edit Games",style: TextStyle(fontSize: 20,color: Colors.white),),
                        leading: Icon(Icons.edit,color: Colors.white,size: 35,),
                      ),
                   ),
                 ),
                 InkWell(
                  onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return deletegamespage();
                      },));
                  },
                   child: Card(
                    color: Color.fromARGB(255, 18, 127, 170).withOpacity(0.1),
                     child: ListTile(
                        title: Text("Delete Games",style: TextStyle(fontSize: 20,color: Colors.white),),
                        leading: Icon(Icons.delete,color: Colors.red,size: 35,),
                      ),
                   ),
                 ),    
                  InkWell(
                  onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return adminorderspage();
                      },));
                  },
                   child: Card(
                    color: Color.fromARGB(255, 18, 127, 170).withOpacity(0.1),
                     child: ListTile(
                        title: Text("View Orders",style: TextStyle(fontSize: 20,color: Colors.white),),
                        leading: Icon(Icons.history,color: Colors.white,size: 35,),
                      ),
                   ),
                 ), 
              SizedBox(height: 55,),

               InkWell(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return loginpage();
                  },));
                },
                 child: Card(
                  color: Color.fromARGB(255, 18, 127, 170).withOpacity(0.1),
                   child: ListTile(
                      title: Text("Log Out",style: TextStyle(fontSize: 20,color: Colors.white),),
                      leading: Icon(Icons.logout_outlined,color: Colors.red,size: 35,),
                    ),
                 ),
               ),
              
        ],) 
      ),
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
                    "Control Panel",
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                  ),
                ),
                Spacer(),
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
            child: Container(
                height: 600,
                child: Column(
                  children: [
                    Icon(
                      Icons.construction_rounded,
                      size: 80,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return addgamespage();
                            },));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 20.0,
                                  spreadRadius: 5.0,
                                  
                                  color: Color.fromARGB(255, 17, 185, 82)
                                )
                              ],
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(colors: [
                                Color.fromARGB(255, 6, 226, 79),
                                Color.fromARGB(255, 17, 185, 82)
                              ]),
                            ),
                            height: 180,
                            width: 160,
                            
                            child: Column(
                              
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only( left: 8,top: 8,right: 95),
                                  
                                  child: Icon(
                                    Icons.add_box_rounded,
                                    color: Colors.white,
                                    size: 45,
                                  ),
                                ),
                               SizedBox(height: 30,),
                               Text("Add Games",style: TextStyle(fontSize: 24),)
                              ],
                            ),
                          ),
                        ),
                         InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return editgamespage();
                            },));
                          },
                           child: Container(
                            decoration: BoxDecoration(
                               boxShadow: [
                                  BoxShadow(
                                    blurRadius: 20.0,
                                    spreadRadius: 5.0,
                                    
                                    color: Color.fromARGB(255, 178, 196, 78)
                                  )
                                ],
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(colors: [
                                Color.fromARGB(255, 239, 243, 7),
                                Color.fromARGB(255, 178, 196, 78)
                              ]),
                            ),
                            height: 180,
                            width: 160,
                            
                            child: Column(
                              
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only( left: 8,top: 8,right: 95),
                                  
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 45,
                                  ),
                                ),
                               SizedBox(height: 30,),
                               Text("Edit Games",style: TextStyle(fontSize: 24),)
                              ],
                            ),
                                                 ),
                         ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                         InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return deletegamespage();
                            },));
                          },
                           child: Container(
                            decoration: BoxDecoration(
                               boxShadow: [
                                  BoxShadow(
                                    blurRadius: 20.0,
                                    spreadRadius: 5.0,
                                    
                                    color: Color.fromARGB(255, 150, 27, 27)
                                  )
                                ],
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(colors: [
                                Color.fromARGB(255, 226, 3, 3),
                                Color.fromARGB(255, 150, 27, 27)
                              ]),
                            ),
                            height: 180,
                            width: 160,
                            
                            child: Column(
                              
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only( left: 8,top: 8,right: 95),
                                  
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                    size: 45,
                                  ),
                                ),
                               SizedBox(height: 30,),
                               Text("Delete Games",style: TextStyle(fontSize: 24),)
                              ],
                            ),
                                                 ),
                         ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return viewgamespage();
                            },));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                               boxShadow: [
                                  BoxShadow(
                                    blurRadius: 20.0,
                                    spreadRadius: 5.0,
                                    
                                    color: Color.fromARGB(255, 2, 148, 92)
                                  )
                                ],
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(colors: [
                                Color.fromARGB(255, 6, 202, 143),
                                Color.fromARGB(255, 2, 148, 92)
                              ]),
                            ),
                            height: 180,
                            width: 160,
                            
                            child: Column(
                              
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only( left: 8,top: 8,right: 95),
                                  
                                  child: Icon(
                                    Icons.games_rounded,
                                    color: Colors.white,
                                    size: 45,
                                  ),
                                ),
                               SizedBox(height: 30,),
                               Text("View Games",style: TextStyle(fontSize: 24),)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
