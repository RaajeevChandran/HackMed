import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:skinmed/detectDisease.dart';

class HomeScreen extends StatelessWidget {
  final List<dynamic> trivia = [
    "Skin accounts for about 15% of your body weight.",
    "The skin renews itself every 28 days.",
    "Your skin is its thickest on your feet (1.4mm) and thinnest on your eyelids (0.2mm).",
    "The average person’s skin covers an area of 2 square meters.",
    "The average adult has approximately 21 square feet of skin, which weighs 9 lbs and contains more than 11 miles of blood vessels."
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xFFFf2f6fe),
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Container(
                    height: 50,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: Color(0xFFFe9eaff),
                                  borderRadius: BorderRadius.circular(10)),
                              child:
                                  Icon(Icons.menu, color: Color(0xFFF9fa2fc)),
                            ),
                          ),
                        ),
                        Align(
                            alignment: Alignment.center,
                            child: Image.asset("assets/icon.png")),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 20,
                              foregroundImage: AssetImage("assets/profile.png"),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Color(0xFFF585ce5),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Welcome to SkinMed!",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 29,
                                  fontWeight: FontWeight.bold)),
                          Padding(
                            padding: const EdgeInsets.all(11.0),
                            child: Text(
                                "Let's check your skin health with us.Care with your health from now on to get better!",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w300)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Material(
                              borderRadius: BorderRadius.circular(10),
                              clipBehavior: Clip.hardEdge,
                              child: Ink(
                                width: MediaQuery.of(context).size.width * .7,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xFFF54c1fb),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DetectDisease()));
                                  },
                                  child: Center(
                                    child: Text("Know your skin disease",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 17)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      child: Material(
                    elevation: 10,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40)),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40)),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Text("Skin Trivia",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold)),
                          ),
                          Column(
                              children: List.generate(trivia.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Material(
                                  elevation: 3,
                                  borderRadius: BorderRadius.circular(15),
                                  child: Container(
                                    constraints: BoxConstraints(minHeight: 80),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                              height: 50,
                                              width: 50,
                                              child: Lottie.asset(
                                                  "assets/info.json")),
                                        ),
                                        Expanded(
                                            child: Text(trivia[index],
                                                style: TextStyle(fontSize: 15)))
                                      ],
                                    ),
                                  )),
                            );
                          })),
                        ],
                      ),
                    ),
                  ))
                ],
              ),
            ),
          )),
    );
  }
}
