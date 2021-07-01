import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lps_ufs_tcc/empresa.dart';
import 'package:lps_ufs_tcc/login.dart';
import 'package:lps_ufs_tcc/models/feature.dart';
import 'Cliente.dart';
import 'funcionario.dart';
import 'models/produto.dart';



void main() async {
//
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false, // Remover o Banner de Debug
    title: 'Cadastro',
    home: LPS_Cadastro(),
)); // Executa a Tela Principal do Aplicativo
}

// ignore: camel_case_types
class LPS_Cadastro extends StatelessWidget{
  
 
 @override
 Widget build(BuildContext context){  

     Firestore.instance.collection('Produto_Feature').getDocuments().then((value){
       value.documents.forEach((element) {
       print(element.data);
    //  habilitar_cliente = element.data['start'];
      
       });
     });

   return Scaffold(

     appBar: AppBar(
       leading: IconButton(
                icon: Icon(Icons.home, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
         ), 
       title: Text('Menu de Cadastro', style: TextStyle(color: Colors.black)),
       backgroundColor: Colors.amberAccent,  
     ),

     body: StreamBuilder(
       stream: Firestore.instance.collection('Produto_Feature/Estetica/Cadastro').snapshots(),
       builder: (
         BuildContext context,
         AsyncSnapshot<QuerySnapshot> snapshot,
       ) {

         if(snapshot.hasError){
             return Center(child: Text('Error: ${snapshot.error}'));
         }

         if(snapshot.connectionState == ConnectionState.waiting){
             return Center(child: CircularProgressIndicator());
         }

         if(snapshot.data.documents.length == 0){
             return Center(child: Text('Sem Novas Features Adicionadas no Momento'));
         }
         
         return ListView.builder(
           itemCount: snapshot.data.documents.length,
           itemBuilder: (BuildContext context, int i) {

           var item = snapshot.data.documents[i].data;
           
           
           return Container(
                  // retorna um objeto do tipo feature com os seus atributos em forma de botão
                  // status, nome
                  
                 child: new Feature(item['nome'], item['enabled']),
                  
                 );
                },
              );
             },
           ),

    backgroundColor: Colors.amber[100],
   );
  }
  
}




