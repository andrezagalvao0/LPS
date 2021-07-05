import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class HomeNotify extends StatefulWidget {
  HomeNotify({Key key}) : super(key: key);

  @override
  _HomeNotifyState createState() => _HomeNotifyState();
}

class _HomeNotifyState extends State<HomeNotify> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String _message = '';

  _registerOnFirebase() {
    _firebaseMessaging.subscribeToTopic('all');
    _firebaseMessaging.getToken().then((token) => print(token));
  }

  @override
  void initState() {
    _registerOnFirebase();
    getMessage();
    super.initState();
  }

  void getMessage() {
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      print('received message');
      setState(() => _message = message["notification"]["body"]);
    }, onResume: (Map<String, dynamic> message) async {
      print('on resume $message');
      setState(() => _message = message["notification"]["body"]);
    }, onLaunch: (Map<String, dynamic> message) async {
      print('on launch $message');
      setState(() => _message = message["notification"]["body"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
                icon: Icon(Icons.home, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
         ), 
        title: Text('Notificações'),
      ),
      body: Container(
          child: Center(
        child: Text("Message: $_message"),
      )),
    );
  }
}