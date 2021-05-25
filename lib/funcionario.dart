import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false, // Remover o Banner de Debug
    title: 'Funcionario',
    home: LPS_Cadastro_Funcionario(),
)); // Executa a Tela de Cadastro de Funcionario
}

class LPS_Cadastro_Funcionario extends StatelessWidget {
  
  @override
 Widget build(BuildContext context){
   return Scaffold(
     appBar: AppBar(
       title: Text('Cadastro de Funcionario'),
       backgroundColor: Colors.amberAccent,
     ),
     body: Center(
       child: Text('Cadastro de Funcionario da Nossa LPS'),
     ),

     floatingActionButton: FloatingActionButton(
       child: Icon(Icons.person),
       backgroundColor: Colors.amberAccent,
       onPressed: (){},
     ),

     backgroundColor: Colors.amber[100],
   );

  }
}