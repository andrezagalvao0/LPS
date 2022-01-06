//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:lps_ufs_tcc/models/produto.dart';

class HomeNotify extends StatefulWidget {
  String idProdutoSelecionado;
  
  HomeNotify({this.idProdutoSelecionado});

  @override
  _HomeNotifyState createState() => _HomeNotifyState();
}

class _HomeNotifyState extends State<HomeNotify> {

  Produto produto; // produto 3 da LPS
 

  //final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String _message = '';

  //_registerOnFirebase() {
  //  _firebaseMessaging.subscribeToTopic('all');
  //  _firebaseMessaging.getToken().then((token) => print(token));
  //}

  @override
  void initState() {
  //  _registerOnFirebase();
    getMessage();
    super.initState();
  }

  void getMessage() {
   // _firebaseMessaging.configure(
  //      onMessage: (Map<String, dynamic> message) async {
  //    print('received message');
  //    setState(() => _message = message["notification"]["body"]);
  //  }, onResume: (Map<String, dynamic> message) async {
  //    print('on resume $message');
  //    setState(() => _message = message["notification"]["body"]);
  //  }, onLaunch: (Map<String, dynamic> message) async {
  //    print('on launch $message');
  //    setState(() => _message = message["notification"]["body"]);
  //  });
  }

  @override
  Widget build(BuildContext context) {

    produto = new Produto.CriarProduto(widget.idProdutoSelecionado);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
                icon: Icon(Icons.home, color: produto.getIconCor),
              onPressed: () => Navigator.of(context).pop(),
         ), 
        title: Text('Notificações', style: TextStyle(color: produto.getTextCor)),
        backgroundColor: produto.getSecondaryCor,
      ),
      body: Container(
          child: Center(
        child: Text("As notificações ficarão aqui!$_message", style: TextStyle(color: produto.getTextCor)),
      )),
      backgroundColor: produto.getFundoCor,
    );
  }
}