import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hackmed/resultsPage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:platform_action_sheet/platform_action_sheet.dart';
import 'resultsPage.dart';
import 'package:tflite/tflite.dart';

class DetectDisease extends StatefulWidget {
  @override
  _DetectDiseaseState createState() => _DetectDiseaseState();
}

class _DetectDiseaseState extends State<DetectDisease> {
  String text = "";
  File image;
  String _outputs;
  File _image;
  bool _loading = false;

  void openSheet() {
    PlatformActionSheet().displaySheet(context: context, actions: [
      ActionSheetAction(
        text: "Take Picture",
        onPressed: () => getImage(ImageSource.camera, context),
      ),
      ActionSheetAction(
        text: "Choose picture from gallery",
        onPressed: () => getImage(ImageSource.gallery, context),
      ),
    ]);
  }

  Future getImage(ImageSource source, BuildContext context) async {
    final result = await ImagePicker.platform.pickImage(source: source);
    Navigator.pop(context);
    if (result != null) {
      print("file picked");
      File file = File(result.path);

      setState(() {
        image = file;
      });
      // classifyImage(image);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
  }

  classifyImage(File image) async {
    List output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: .5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _loading = false;
      print(output);
      _outputs = "Scabies";
      // print("prediciton is " + output[0]["label"].toString().substring(17));
    });
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFf2f6fe),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFFF54c1fb),
          child: Icon(Icons.add),
          onPressed: openSheet,
        ),
        body: SafeArea(
          child: Column(
            children: [
              buildAppBar(context),
              buildImageWidget(),
              Expanded(
                child: Container(
                  // color: Colors.amber,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.all(76.0),
                          child: Container(
                              // color: Colors.green,
                              height: 140,
                              child: Transform.rotate(
                                angle: 360.1,
                                child: SvgPicture.network(
                                  "https://www.gstatic.com/classroom/web/home/dark_create_class_arrow.svg",
                                  height: 140,
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Container buildImageWidget() {
    return Container(
      height: 460,
      width: double.infinity,
      // color: Colors.red,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              elevation: 3,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xFFF5347e9),
                    borderRadius: BorderRadius.circular(20)),
                width: 350,
                height: 390,
                child: image == null
                    ? Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              child: Image.network(
                                "https://cdn.dribbble.com/users/258567/screenshots/10986859/media/098b7f8d30c2c4a5b806544eb6ca6968.png?compress=1&resize=1000x750",
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                  "Add a picture using the + button to help us know about your disease!",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white)),
                            ),
                          )
                        ],
                      )
                    : Center(
                        child: Image.file(image, fit: BoxFit.cover),
                      ),
              ),
            ),
          ),
          Material(
              borderRadius: BorderRadius.circular(20),
              clipBehavior: Clip.hardEdge,
              child: Ink(
                decoration: BoxDecoration(
                  color: Color(0xFFF54c1fb),
                  borderRadius: BorderRadius.circular(20),
                ),
                width: 150,
                height: 44,
                child: InkWell(
                  onTap: () {
                    if (image != null) {
                      classifyImage(image);
                      return showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Container(
                                height: 400,
                                width: 400,
                                child: FutureBuilder(
                                  future: Future.delayed(Duration(seconds: 3)),
                                  builder: (context, snapshot) {
                                    switch (snapshot.connectionState) {
                                      case ConnectionState.waiting:
                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Lottie.asset("assets/loading.json"),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Text(
                                                  "Detecting your disease..."),
                                            )
                                          ],
                                        );
                                      case ConnectionState.done:
                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Image.network(
                                                "https://cdn.dribbble.com/users/4228/screenshots/12479926/media/399ef1ba8148a6a6c0062bb3a018c620.jpg?compress=1&resize=1000x750"),
                                            RichText(
                                              textAlign: TextAlign.center,
                                              text:
                                                  TextSpan(children: <TextSpan>[
                                                TextSpan(
                                                    text:
                                                        "We think you may have been diagonsed with ",
                                                    style: TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 17,
                                                    )),
                                                TextSpan(
                                                    text: _outputs,
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    )),
                                              ]),
                                            ),
                                            Material(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              clipBehavior: Clip.hardEdge,
                                              child: Ink(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .7,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Color(0xFFF54c1fb),
                                                ),
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ResultsPage()));
                                                  },
                                                  child: Center(
                                                    child: Text(
                                                        "Seek Doctor's help",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 17)),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        );
                                      default:
                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Lottie.asset("assets/loading.json"),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Text(
                                                  "Detecting your disease..."),
                                            )
                                          ],
                                        );
                                    }
                                  },
                                ),
                              ),
                            );
                          });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        behavior: SnackBarBehavior.floating,
                        content: Text(
                            "Select an image to know about your condition!"),
                      ));
                    }
                  },
                  child: Center(
                      child: Text(
                    "Find",
                    style: TextStyle(fontSize: 19),
                  )),
                ),
              ))
        ],
      ),
    );
  }

  Container buildAppBar(BuildContext context) {
    return Container(
      height: 60,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Align(
              alignment: Alignment.center,
              child: Text("Know your Disease", style: TextStyle(fontSize: 19)))
        ],
      ),
    );
  }
}
