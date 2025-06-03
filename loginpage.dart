// ignore_for_file: non_constant_identifier_names, prefer_final_fields, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gamesproject/adminhomepage.dart';
import 'package:gamesproject/botnavbar.dart';
import 'package:gamesproject/homepage.dart';
import 'package:gamesproject/regestrationpage.dart';
import 'package:gamesproject/theme_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'header_widget.dart';

class loginpage extends StatefulWidget {
  const loginpage({super.key});

  @override
  State<loginpage> createState() => _loginpageState();
}
  CollectionReference userRef =
        FirebaseFirestore.instance.collection("Customers");
class _loginpageState extends State<loginpage> {
  getData() async {
  
    await userRef.get().then((value) => value.docs.forEach((element) {
          print(element.data());
          print(element.id);
        }));
  }

  double _HeaderHeight = 250;
  GlobalKey<FormState> formState = new GlobalKey<FormState>();
  var Email;
  var Password;

  Log() async {
    var formData = formState.currentState;
    formData!.save();
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: Email,
        password: Password,
      );
      User? user = FirebaseAuth.instance.currentUser;
      var kk = FirebaseFirestore.instance.collection("Customers")
      .doc(user!.uid)
      .get()
      .then((DocumentSnapshot snapshot) {
        if(snapshot.get("RoleID")==1){
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return botnavbar();
          },));
        }
        else{
           Navigator.push(context, MaterialPageRoute(builder: (context) {
            return adminhomepage();
          },));
        }
      });

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  void initState(){
    super.initState();
    getData();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _HeaderHeight,
              child: HeaderWidget(_HeaderHeight, true, Icons.login_rounded),
            ),
            SafeArea(
                child: Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Column(
                children: [
                  Text(
                    "Hello",
                    style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Welcome Back!",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Form(
                      key: formState,
                      child: Column(
                        children: [
                          TextFormField(
                            onSaved: (newValue) {
                              Email = newValue;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: ThemeHelper().textInputDecoration(
                                "Username", "Enter your username"),
                                validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter you username";
                              }
                              return null;
                                }
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          TextFormField(
                            onSaved: (newValue) {
                              Password = newValue;
                            },
                            obscureText: true,
                            decoration: ThemeHelper().textInputDecoration(
                                "Password", "Enter your password"),
  
  validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter your password";
                              }
                              return null;}
                          ),
                          SizedBox(
                            height: 35.0,
                          ),
                          // Container(
                          //   margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                          //   alignment: Alignment.topRight,
                          //   child: Text("Forgot your password?"),
                          // ),
                          Container(
                            decoration:
                                ThemeHelper().buttonBoxDecoration(context),
                            child: ElevatedButton(
                              style: ThemeHelper().buttonStyle(),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                child: Text(
                                  "Sign In".toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              onPressed: () {
                                if(formState.currentState!.validate()){

                                
                                Log();
                                }
                              },
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 35,
                                  ),
                                  Text(
                                    "Don't have an account?",
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return regestrationpage();
                                          },
                                        ));
                                      },
                                      child: Text(
                                        "Create",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Theme.of(context).accentColor,
                                            fontSize: 17),
                                      ))
                                ],
                              )),
                        ],
                      ))
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
