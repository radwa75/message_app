// ignore_for_file: prefer_const_constructors, unused_local_variable, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

late User signedInUser;

class ChatScreen extends StatefulWidget {
  static const String screenRoute = 'chat_screen';

  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late User signedInUser;
  String? messageText;
  @override
  void initState() {
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signedInUser = user;
        print(signedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  /* void getmessages() async {
    final messages= await _firestore.collection('messages').get();
    for (var message in messages.docs) {
      print(message.data());
    }
  }

  void messagesStreams() async {
    await for (var snapshot in _firestore.collection('chat').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 182, 175, 179),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 179, 97, 128),
        title: Row(
          children: [
            Text('Chat...',style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 223, 198, 198))),
            Image.asset('images/chat.png', height: 27),
            SizedBox(width: 10),
            
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              
              _auth.signOut();
              Navigator.pop(context);
            },
            icon: Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('chat').orderBy('time').snapshots(),
        builder: (context, snapshot) {
          List<messageline> messageWidgets = [];

          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(
                    backgroundColor: Colors.pink[900]));
          }

          final messages = snapshot.data!.docs.reversed;
          for (var message in messages) {
            final messageText = message.get('text');
            final messageSender = message.get('sender');
            
            final newuser = signedInUser.email;
            final messageWeidget =
                messageline(sender: messageSender, text: messageText,isme: newuser == messageSender);
  
              messageWidgets.add(messageWeidget);

          }
          return  Expanded(
            child: ListView(
              reverse: true,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                children: messageWidgets),
          );
        },
            ),
        
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Color.fromARGB(255, 179, 97, 128),
                    width: 3,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        hintText: 'Write your message here...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messageTextController.clear();
                      _firestore.collection('chat').add(
                          {'text': messageText,
                          'sender': signedInUser.email,
                          'time':FieldValue.serverTimestamp()
                          });
                    },
                    child: Text(
                      'send',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                          color: Color.fromARGB(255, 179, 97, 128)),
                    ))
              ]),
            )
          ],
        ),
      ),
    );
  }
}
class messageline extends StatelessWidget {
  const messageline({this.text, this.sender, super.key,required this.isme});
  final String? text;
  final String? sender;
  final bool isme;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: isme ?CrossAxisAlignment.end:CrossAxisAlignment.start,
          children: [
            Text('$sender',
                style: TextStyle(
                    fontSize: 9,
                    color: const Color.fromARGB(255, 128, 109, 115))),
            Material(
              elevation: 4,
              borderRadius: isme? BorderRadius.only(
                  topLeft: Radius.circular(40),
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40)): BorderRadius.only(topRight: Radius.circular(40),
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40)),
              color:isme  ? Color.fromARGB(147, 231, 113, 155):Color.fromARGB(255, 255, 255, 255),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text('$text',
                    style: TextStyle(fontSize: 10, color:isme  ?Color.fromARGB(255, 255, 255, 255) :Color.fromARGB(147, 231, 113, 155),
                          fontWeight: FontWeight.w900,)),
              ),
            ),
        ]),
        );
  }
}
