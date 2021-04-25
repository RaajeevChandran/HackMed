import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  String hospitalName;
  ChatPage({Key key, @required this.hospitalName}) : super(key: key);
  @override
  _ChatPageState createState() => _ChatPageState();
}

List<String> messages = [];
List<String> userMes = [];
List<String> preMes = [
  'Can you help me doctor?',
  'Can I get the hospital address'
];
TextEditingController controller = TextEditingController();

class _ChatPageState extends State<ChatPage> {
  @override
  void dispose() {
    messages.clear();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
          child: Column(
        children: [
          buildAppBar(context),
          Flexible(
              child: messages.isEmpty
                  ? Container(
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('assets/icon.png'),
                          width: 130.0,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Press one of the prompts below to start ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        GestureDetector(
                          child: Text(preMes[0],
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.blue)),
                          onTap: () {
                            setState(() {
                              controller.text = preMes[0];
                            });
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        GestureDetector(
                          child: Text(preMes[1],
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.blue)),
                          onTap: () {
                            setState(() {
                              controller.text = preMes[1];
                            });
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ))
                  : ListView.builder(
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        return bubble(messages[index], index);
                      },
                    )),
          Container(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: <Widget>[
                Flexible(
                    child: TextField(
                  controller: controller,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                      fillColor: Colors.black,
                      focusColor: Colors.black,
                      hoverColor: Colors.black,
                      border: new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: BorderSide(
                              width: 0.05, style: BorderStyle.solid)),
                      hintText: 'Type your message',
                      hintStyle: TextStyle(fontSize: 16.0)),
                )),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    //
                    child: IconButton(
                        icon: Icon(
                          Icons.send,
                          size: 30.0,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            
                            messages.add(controller.text);
                            if (controller.text == preMes[0]) {
                              messages.add(
                                  'Yes, we can help you. Can you elaborate on your disease?');
                            } else if (controller.text == preMes[1]) {
                              messages.add(
                                  'We are located at Adhvaitha Ashram Road');
                            }
                            controller.clear();
                          });
                        }),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 253, 188, 51),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    )),
              ],
            ),
          ),
          SizedBox(height: 10)
        ],
      )),
    ));
  }

  Widget bubble(String message, int index) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Bubble(
          radius: Radius.circular(15.0),
          color: index % 2 != 0 ? Color(0xFFe8eaf6) : Color(0xFFe8f3fc),
          elevation: 0.0,
          alignment: index % 2 != 0 ? Alignment.topLeft : Alignment.topRight,
          nip: index % 2 != 0 ? BubbleNip.leftBottom : BubbleNip.rightTop,
          child: Padding(
            padding: EdgeInsets.all(2.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: AssetImage(index % 2 != 0
                          ? "assets/bot.png"
                          : "assets/user.png"),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Flexible(
                      child: Text(
                        message,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
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
              child: Text("Chatting with ${widget.hospitalName}",
                  style: TextStyle(fontSize: 15)))
        ],
      ),
    );
  }
}
