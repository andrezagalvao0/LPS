import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lps_ufs_tcc/empresa.dart';
import 'package:lps_ufs_tcc/login.dart';
import 'Cliente.dart';
import 'funcionario.dart';

void main() async{
  bool status_cliente;
  bool status_empresa;
  bool status_funcionario;

  var db = Firestore.instance;

    QuerySnapshot res = 
    await db.collection("produto_feature").getDocuments();
    
      res.documents.forEach((d){

      status_cliente = d.data['start'] as bool;
      print(status_cliente);
      
      });

            

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false, // Remover o Banner de Debug
    title: 'Cadastro',
    home: LPS_Cadastro(),
)); // Executa a Tela Principal do Aplicativo
}

// ignore: camel_case_types
class LPS_Cadastro extends StatelessWidget{
   
   bool habilitar_cliente;
   bool habilitar_empresa;
   bool habilitar_funcionario;
  

 @override
 Widget build(BuildContext context){
   bool isVisible = true;

  // Future<bool>  habilitarCliente = check_feature("produto_feature", "lps_cliente");
  //   habilitar_empresa = check_feature("produto_feature", "lps_empresa");
  //   habilitar_funcionario = check_feature("produto_feature", "lps_funcionario");
  //  var habilitar_notificacoes = check_feature("produto_feature", "lps_notificacoes") as bool;
   
   return Scaffold(

     appBar: AppBar(
       leading: IconButton(
                icon: Icon(Icons.home, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
         ), 
       title: Text('Menu de Cadastro', style: TextStyle(color: Colors.black)),
       backgroundColor: Colors.amberAccent,  
     ),

     body: Center(
       child:Container(
         child: Column(
          children: <Widget>[


           
             //SE O PRODUTO LPS 
             Visibility(
             // ignore: unrelated_type_equality_checks
             visible:  true,
             child:RaisedButton(   // // executa uma rota para a tela de cadastro de clientes ao clicar no botão
             key: ValueKey('chave_cadastro_cliente'),
             child: Text('Cliente'),
             color: Colors.amberAccent,
               onPressed: (){
               Navigator.push(context,MaterialPageRoute(builder: (context) => LPS_Cadastro_Cliente(),
               ));
              },
             ),
            ),
           
             Visibility(
             // ignore: unrelated_type_equality_checks
             visible: true,  
             child:RaisedButton(   // // executa uma rota para a tela de cadastro de empresas ao clicar no botão
             key: ValueKey('chave_cadastro_empresa'),
             child: Text('Empresa'),
             color: Colors.amberAccent,
             onPressed: (){
               Navigator.push(context,MaterialPageRoute(builder: (context) => LPS_Cadastro_Empresa(),
               ));
              },
             ),
            ),

             Visibility(
             // ignore: unrelated_type_equality_checks
             visible: true,  
             child:RaisedButton(  // // executa uma rota para a tela de cadastro de funcionarios ao clicar no botão
             key: ValueKey('chave_cadastro_funcionario'),
             child: Text('Funcionario'),
             color: Colors.amberAccent,
             onPressed: (){
               Navigator.push(context,MaterialPageRoute(builder: (context) => LPS_Cadastro_Funcionario(),
               ));
              },
             ),
            ),

         ],
       )
     )
    ),
    backgroundColor: Colors.amber[100],
   );
  }

  // recebe uma instancia do firestore e verifica 
  // se a feature será habilitada no aplicativo
  // ignore: non_constant_identifier_names
    Future<bool> check_feature(String t, String n) async {
    var db = Firestore.instance;

    QuerySnapshot res = 
    await db.collection(t).getDocuments();

      res.documents.forEach((n){

        if(n.data['start'] == true){
         return true;
        }

      });
  } 

  // ignore: non_constant_identifier_names
  bool retorno_status_feature(Future<bool> f){
     // ignore: unrelated_type_equality_checks
     if(f == true){
       return true;
     }
     else{
       return false;
     }

  }


}




