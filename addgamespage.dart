import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gamesproject/theme_helper.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gamesproject/viewgamespage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'header_widget.dart';
import 'dart:io';

class addgamespage extends StatefulWidget {
  const addgamespage({super.key});

  @override
  State<addgamespage> createState() => _addgamespageState();
}

class _addgamespageState extends State<addgamespage> {
  late File file;

  var Imagepicker = ImagePicker();
  var imageUrl;
  UploadImage() async {
    var SelectedImage =
        await Imagepicker.pickImage(source: ImageSource.gallery);

    if (SelectedImage != null) {
      file = File(SelectedImage.path);
      var imageName = basename(SelectedImage.path);
      var refImage = FirebaseStorage.instance.ref("games/$imageName");
      await refImage.putFile(file);
      imageUrl = await refImage.getDownloadURL();
      print("--------------------------------------------------------------------");
      print(imageUrl);
    } else {
      print("No Selected Image");
    }
  }

  double _HeaderHeight = 150;
  GlobalKey<FormState> formState = new GlobalKey<FormState>();
  var GameName;
var GamePrice;
  var GameCategory;
  addgame() async {
    var formData = formState.currentState;
    formData!.save();
    FirebaseFirestore.instance.collection("Games").add({
      "Gamename": GameName,
      "Price": GamePrice,
      "Gamecategory": GameCategory,
      "Image": imageUrl.toString(),
    });
  }

  List GamesList = [];
  CollectionReference gameRef = FirebaseFirestore.instance.collection("Games");
  
  ShowImage() async {
    var response =
        await gameRef.get().then((value) => {GamesList.add(value.toString())});

    print(GamesList);
  }

  @override
  void initState() {
    super.initState();
    ShowImage();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 150,
              child: HeaderWidget(150, false, Icons.add_to_photos),
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
                                  border:
                                      Border.all(width: 5, color: Colors.white),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 20,
                                        offset: const Offset(5, 5)),
                                  ],
                                ),
                                child: Icon(
                                  Icons.add_to_photos,
                                  color: Color.fromARGB(255, 139, 139, 139),
                                  size: 80.0,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(80, 80, 0, 0),
                                child: Icon(
                                  Icons.add_circle,
                                  color: Color.fromARGB(255, 99, 99, 99),
                                  size: 25.0,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        Container(
                          child: TextFormField(
                            onSaved: (newValue) {
                              GameName = newValue;
                            },
                            decoration: ThemeHelper().textInputDecoration(
                                "Game name", "Enter game name"),
  validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter a gamename";
                              }
                              return null;}
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 30.0),
                        Container(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            onSaved: (newValue) {
                              GamePrice = newValue;
                            },
                            
                            decoration: ThemeHelper().textInputDecoration(
                                "Price", "Enter game price"),
                                validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter a price";
                              }
                              return null;}
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 30.0),
                        Container(
                          child: TextFormField(
                            onSaved: (newValue) {
                              GameCategory = newValue;
                            },
                            decoration: ThemeHelper().textInputDecoration(
                                "Game Category", "Enter game category"),
                                validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter the game category";
                              }
                              return null;}
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: 55,
                        ),
                        FormField<bool>(
                          builder: (state) {
                            return Column(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    state.errorText ?? '',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Theme.of(context).errorColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                        Container(
                          decoration:
                              ThemeHelper().buttonBoxDecoration(context),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                "add game Image".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: () {
                              UploadImage();
                              final snackBar = SnackBar(
                                duration: Duration(seconds: 15),

                                /// need to set following properties for best effect of awesome_snackbar_content
                                elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                content: AwesomeSnackbarContent(
                                  title: 'Image Added Succesfully',
                                  message:
                                      'The image you have selected has been added to database storage',

                                  /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                  contentType: ContentType.success,
                                ),
                              );

                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(snackBar);
                            },
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          decoration:
                              ThemeHelper().buttonBoxDecoration(context),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                "add game".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: () {
                              if(formState.currentState!.validate()){

                              
                              addgame();
                              final snackBar = SnackBar(
                                duration: Duration(seconds: 5),

                                /// need to set following properties for best effect of awesome_snackbar_content
                                elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                content: AwesomeSnackbarContent(
                                  title: 'Game Added Succesfully',
                                  message:
                                      'The Game data you have Entered has been added to database',

                                  /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                  contentType: ContentType.success,
                                ),
                              );

                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(snackBar);
                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return viewgamespage();
                              },));
                              }
                              
                            },
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Go Back",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 20),
                            ))
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
