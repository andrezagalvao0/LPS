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

  @required var ct_profis = TextEditingController();
  
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
     body: Container(
                     
                   child: TextField(  
                   cursorColor: Colors.amberAccent,
                   decoration: InputDecoration(
                   prefixIcon: Icon(Icons.search,  color: Colors.black),
                   hintText: 'Profissional',
                   contentPadding: EdgeInsets.all(5),
                   border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black),
                   borderRadius: BorderRadius.circular(8.0)),
                   
                   ),
                   controller: ct_profis,
                  ), 
          // child: Text('Escolher Profissionais -> Dias Disponiveis -> Procedimento -> Agendar'),
     ),
           
           
           
     

  //   floatingActionButton: FloatingActionButton(
  //     child: Icon(Icons.person_add),
  //     backgroundColor: Colors.amberAccent,
  //     onPressed: (){},
  //   ),

     backgroundColor: Colors.amber[100],
   );

  }
}