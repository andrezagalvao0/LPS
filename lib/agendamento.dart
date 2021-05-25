import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false, // Remover o Banner de Debug
    title: 'Agendamento',
    home: LPS_Agendamento_Cliente(),
)); // Executa a Tela de Cadastro de Cliente
}

class LPS_Agendamento_Cliente extends StatelessWidget {
  
  @override
 Widget build(BuildContext context){
   return Scaffold(
     appBar: AppBar(
         leading: IconButton(
                icon: Icon(Icons.home, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
         ), 
       title: Text('Agendamento'),
       backgroundColor: Colors.amberAccent,
     ),
     body: Center(
       child:Text('Agendamentos da Nossa LPS'),
     ),

     floatingActionButton: FloatingActionButton(
       child: Icon(Icons.person_add),
       backgroundColor: Colors.amberAccent,
       onPressed: (){},
     ),

     backgroundColor: Colors.amber[100],
   );

  }
}