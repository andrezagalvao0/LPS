import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lps_ufs_tcc/models/feature.dart';
import 'package:lps_ufs_tcc/models/produto.dart';
import 'package:lps_ufs_tcc/views/login.dart';




void main() async {
//
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false, // Remover o Banner de Debug
    title: 'Cadastro',
    home: LPS_Select_App(),
)); // Executa a Tela Principal do Aplicativo
}


class LPS_Select_App extends StatelessWidget{


 // classe responsavel por apresentar os produtos da linha de produto de software 
 // para o dominio do Setor Terciario 
 
 @override
 Widget build(BuildContext context){  

   //  Firestore.instance.collection('/Produtos/Estetica/Francielly_Estetica_Design/f4qVyClZ6etPxvpFwfmC').getDocuments().then((value){
   //    value.documents.forEach((element) {
   //    print(element.data);
    //  habilitar_cliente = element.data['start'];
      
   //    });
   //  });

   return Scaffold(

     appBar: AppBar(
       leading: IconButton(
                icon: Icon(Icons.home, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
         ), 
       title: Text('Selecionar Produto', style: TextStyle(color: Colors.black)),
       backgroundColor: Colors.white, 
     ),
     
     backgroundColor: Colors.white,
     body:Container(
                  
                 padding: EdgeInsets.only(top:10),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.stretch,
                   children: <Widget>[   
                  
                  new Container(
                     child: Padding(
                          padding: EdgeInsets.all(10.0),
                     child: IconButton(
                        icon: Image.asset("assets/images/header_advocacia.png"),
                        iconSize: 150,
                        onPressed: () { 
                          Navigator.push(context,MaterialPageRoute(builder: (context) => LPS_Login()));
                        },
                      ), 
                     ),
                  ),
                 
                  new Container(
                     child: Padding(
                          padding: EdgeInsets.all(10.0),
                     child:IconButton(
                        icon: Image.asset("assets/images/header_estetica.png"),
                        iconSize: 150,
                        onPressed: () {
                           Navigator.push(context,MaterialPageRoute(builder: (context) => LPS_Login()));
                        },
                      ),
                     ),
                  ),  

                 new Container(
                     child: Padding(
                          padding: EdgeInsets.all(10.0),
                     child:IconButton(
                        icon: Image.asset("assets/images/header_fisioterapia.png"),
                        iconSize: 150,
                        onPressed: () {
                           Navigator.push(context,MaterialPageRoute(builder: (context) => LPS_Login()));
                        },
                      ),
                     ),
                  ), 
                ],
 
                 ),
               ),
              );         
  }
  
}


