import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
var loggedInUser;

class ChatScreen extends StatefulWidget {
  static const String id = '/chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  var chatMessages;
  final messageTextController = TextEditingController();
  void getCurrentUser() async{// to know who is currently using the app
    try{
      final user = _auth.currentUser;
      if(user!=null){
        loggedInUser = user.email;
      }
    }catch(e){
      print(e);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamedWidget(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      onChanged: (value) {
                        chatMessages=value;

                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messageTextController.clear();
                     _firestore.collection('messages').add({
                       'sender':loggedInUser,
                       'text': chatMessages,
                       'time': DateTime.now(),
                     });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
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
class StreamedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(//it has a builder function that returns a widget
        stream: _firestore.collection('messages').snapshots(),
        builder: (context, snapshot){
          List<MessageBubbles> messageBubbles = [];
          if(snapshot.hasData){
            final messages =snapshot.data.docs;
            for(var message in messages){
              Map messageMap = message.data();
              final messageText = messageMap['text'];
              final messageSender = messageMap['sender'];
              final messageTimer = messageMap['time'];
              print(messageText.toString()+'      '+messageSender.toString());
              final messageBubble =  MessageBubbles(
                  text: messageText,
                  sender: messageSender,
                  isMe: loggedInUser==messageSender?true:false,
                  time: messageTimer);
              messageBubbles.add(messageBubble);
              messageBubbles.sort((MessageBubbles a, MessageBubbles b){
                return b.time.compareTo(a.time);
              });
            }
          }

          return Expanded(
            child: ListView(
             reverse: true,
              padding: EdgeInsets.all(15),
              children: messageBubbles,
            ),
          );
        });
  }
}
class MessageBubbles extends StatelessWidget {
  MessageBubbles({this.text,this.sender,this.isMe,this.time});
  final String text;
  final String sender;
  final bool isMe;
  final Timestamp time;
  @override
  Widget build(BuildContext context) {
    return    Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment:isMe==true? CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: [
          Text(sender,
          style: TextStyle(
            fontSize: 10,
            color: Colors.black54,
          ),),
          Material(
            borderRadius: isMe==true? BorderRadius.only(topLeft: Radius.circular(30),
            bottomLeft: Radius.circular(30),bottomRight:  Radius.circular(30)): BorderRadius.only(topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),bottomRight:  Radius.circular(30)),
            color: isMe==true?Colors.lightBlueAccent: Colors.orangeAccent,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
              text,
              style: TextStyle(
                fontSize: 15,
              ),
          ),
            ),),
          Text(
            '  '+time.toDate().day.toString()+'/'+time.toDate().month.toString()+'/'+time.toDate().year.toString()+"  "+time.toDate().hour.toString()+' - '+time.toDate().minute.toString(),
          ),
        ],
      ),
    );
  }
}
