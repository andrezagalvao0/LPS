import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false, // Remover o Banner de Debug
    title: 'Empresa',
    home: LPS_Cadastro_Empresa(),
)); // Executa a Tela de Cadastro de Empresas
}

class LPS_Cadastro_Empresa extends StatelessWidget {


  @override
 Widget build(BuildContext context){

   return Scaffold(
     appBar: AppBar(
       title: Text('Cadastro de Empresa'),
       backgroundColor: Colors.amberAccent,
     ),
     body: Center(
       child: Text('Cadastro de Empresa da Nossa LPS'),
     ),

     floatingActionButton: FloatingActionButton(
       child: Icon(Icons.work),
       backgroundColor: Colors.amberAccent,
       onPressed: (){},
     ), 
     
     backgroundColor: Colors.amber[100],
   );
  }
}