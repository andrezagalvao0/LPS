import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lps_ufs_tcc/models/feature.dart';
import 'package:lps_ufs_tcc/models/produto.dart';
import 'agendamento_sem_cadastro_lista.dart';
import 'cliente.dart';
import 'empreendedor.dart';
import 'funcionario.dart';




void main() async {
//
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false, // Remover o Banner de Debug
    title: 'Clientes Agendados',
    home: LPS_Empreendedor_Menu(),
)); // Executa a Tela Principal do Aplicativo
}

// ignore: camel_case_types
class LPS_Empreendedor_Menu extends StatelessWidget{
  
  Produto produto = new Produto(); // produto 2 da LPS

 
 @override
 Widget build(BuildContext context){  


   return Scaffold(

     appBar: AppBar(
       leading: IconButton(
                icon: Icon(Icons.home, color: produto.getIconCor),
              onPressed: () => Navigator.of(context).pop(),
         ), 
       title: Text('Área dos Agendamentos', style: TextStyle(color: produto.getTextCor)),
       backgroundColor: produto.getSecondaryCor,  
     ),

     body: Container(
       
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
         children: <Widget>[

           // botoes de agendamentos de clientes cadastrado e clientes sem cadastro
            new Container(
                width: 350,
                height: 100,

                child:Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                RaisedButton(   // // executa uma rota para a tela principal ao clicar no botão
                 child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text("Agendamentos dos Clientes Cadastrados", style: TextStyle(fontSize: 14.0, color: produto.getTextCor)),
                            ],
                          )),
                color: produto.getComponentCor,
                onPressed: (){
                 Navigator.push(context,MaterialPageRoute(builder: (context) => LPS_Empreendedor_Suite()));
              },
              shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(50.0))),
                ],
            ),
          ),         

             new Container(
                width: 350,

                child:Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                RaisedButton(   // // executa uma rota para a tela principal ao clicar no botão
                 child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text("Agendamentos dos Clientes sem Cadastro", style: TextStyle(fontSize: 14.0, color: produto.getTextCor)),
                            ],
                          )),
                color: produto.getComponentCor,
                onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context) => LPS_Agendamento_sem_Cadastro_Lista()));
              },
              shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(50.0))),
                ],
            ),
          ),         



         ],
       ),
     ), 

    backgroundColor: produto.getFundoCor,
   );
  }
  
}




