import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gamesproject/botnavbar.dart';
import 'package:gamesproject/header_widget.dart';
import 'package:gamesproject/homepage.dart';
import 'package:gamesproject/theme_helper.dart';
import 'package:hexcolor/hexcolor.dart';

class regestrationpage extends StatefulWidget {
  const regestrationpage({super.key});

  @override
  State<regestrationpage> createState() => _regestrationpageState();
}


class _regestrationpageState extends State<regestrationpage> {
  GlobalKey<FormState> formState = new GlobalKey<FormState>();
  
 var Email;
 var Password;
 var Name;
 var RoleID = 1;

  Register() async{
    var formData = formState.currentState;
    formData!.save();
    try {
  final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: Email,
    password: Password,
  ).then((value) {
    FirebaseFirestore.instance.collection("Customers").doc(value.user?.uid).set({"Email":value.user?.email,
    "Name":Name,
    "RoleID":RoleID});
  });
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return botnavbar();
  },));
} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    print('The password provided is too weak.');
  } else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
  }
} catch (e) {
  print(e);
}
  }
  @override
  bool checkboxValue = false;
  bool checkedValue = false;
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 150,
              child: HeaderWidget(150,false,Icons.person_add_alt_1_rounded),
              alignment: Alignment.center,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 50, 25, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: [
                  
                  Form(
                    key: formState,
                    child: Column(
                      children: [
                        
                            GestureDetector(
                              child: Stack(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                        width: 5,color: Colors.white
                                      ),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 20,
                                          offset: const Offset(5, 5)
                                        ),
                                      ],
                                    ),
                                    child: Icon(Icons.person,
                                    color: Colors.grey.shade300,
                                    size: 80.0,),
                                  ),
                                  
                                  Container(
                                    padding: EdgeInsets.fromLTRB(80, 80, 0, 0),
                                    child: Icon( Icons.add_circle,
                                  color: Colors.grey.shade700,
                                  size: 25.0,),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 60,),
                             Text(
                    "Welcome",
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                   Text(
                    "Register to the world of gaming",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                            SizedBox(height: 60,),
                            Container(
                              child: TextFormField(
                                onSaved: (newValue) {
                                  Name = newValue;
                                },
                                decoration: ThemeHelper().textInputDecoration("Firstname","Enter your first name"),
                                 validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter your name";
                              }
                              return null;
                                 
                                 }
                            
                              ),
                              decoration: ThemeHelper().inputBoxDecorationShaddow(),
                            ),
                            // SizedBox(height: 30,),
                            // Container(
                            //   child: TextFormField(
                            //     decoration: ThemeHelper().textInputDecoration("Lastname","Enter your Last name"),
                            //   ),  
                            //     decoration: ThemeHelper().inputBoxDecorationShaddow(),
                            // ),
                             SizedBox(height: 30.0),
                        Container(
                          child: TextFormField(
                            onSaved: (newValue) {
                              Email = newValue;
                            },
                            decoration: ThemeHelper().textInputDecoration("E-mail address", "Enter your email"),
                            keyboardType: TextInputType.emailAddress,
                            validator: (val) {
                              if(val!.isEmpty){
                                return "Enter a valid email address";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                         
                        SizedBox(height: 30,),
                        Container(
                          child: TextFormField(
                            
                            onSaved: (newValue) {
                              Password = newValue;
                            },
                            obscureText: true,
                            decoration: ThemeHelper().textInputDecoration(
                                "Password", "Enter your password"),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter a password";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                         SizedBox(height: 15.0),
                        FormField<bool>(
                          builder: (state) {
                            return Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Checkbox(
                                        value: checkboxValue,
                                        onChanged: (value) {
                                          setState(() {
                                            checkboxValue = value!;
                                            state.didChange(value);
                                          });
                                        }),
                                    Text("I accept all terms and conditions.", style: TextStyle(color: Colors.grey,fontSize: 16),),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    state.errorText ?? '',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(color: Theme.of(context).errorColor,fontSize: 12,),
                                  ),
                                )
                              ],
                            );
                          },
                           validator: (value) {
                            if (!checkboxValue) {
                              return 'You need to accept terms and conditions';
                            } else {
                              return null;
                            }
                          },
                        ),
                         SizedBox(height: 20.0),
                        Container(
                          decoration: ThemeHelper().buttonBoxDecoration(context),
                          child: ElevatedButton(
                            
                            style: ThemeHelper().buttonStyle(),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                "Register".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: () {
                              if(formState.currentState!.validate()){
                             Register();
                              final snackBar = SnackBar(
                                  duration: Duration(seconds: 2),
                    /// need to set following properties for best effect of awesome_snackbar_content
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Account created successfuly',
                      message:
                          'you have been added to database successfully',

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
                        ),
                         TextButton(onPressed: () {
                           Navigator.pop(context);
                         }, child: Text("Go Back",style: TextStyle(color: Colors.blue,fontSize: 18),))
                        
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}