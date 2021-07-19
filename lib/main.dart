import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'agendamento.dart';
import 'cadastro.dart';
import 'login.dart';
import 'models/notificacoes.dart';
import 'models/produto.dart';



void main(){
  
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false, // Remover o Banner de Debug
    theme: ThemeData(
    
    // Define the default brightness and colors.
    primaryColor: Colors.amberAccent,
    accentColor: Colors.amberAccent),

    // criar o metodo interruptor da Linha de Produto
    title: 'Login',
    home: LPS_Login(),
)); // Executa a Tela Principal do Aplicativo
}

class Homescreen extends StatelessWidget{
  

 @override
 Widget build(BuildContext context){

   return Scaffold(

     appBar: AppBar(
       iconTheme: IconThemeData(
       color: Colors.black),
       title: Text('Meus Agendamentos', style: TextStyle(color: Colors.black)),
       backgroundColor: Colors.amberAccent,
     ),
      
     drawer: Drawer(

       child: Container(

         decoration: BoxDecoration(
           gradient: LinearGradient(colors: <Color>[
               //Colors.green[100],
               //Colors.green[400],
                 Colors.amber[100],
                 Colors.amber[400],
             ])
         ),

       child: ListView(
         children: <Widget>[ 
           DrawerHeader(
              decoration: BoxDecoration(
                 image: DecorationImage( image: AssetImage('images/header_estetica.png')),
                 gradient: LinearGradient(colors: <Color>[
                 Colors.amber[100],
                 Colors.amber[400],
                 // Colors.green[100],
                //  Colors.green[400],
             ])
            ),
           ),
           
           
           // lista de features principais da linha de produto de software

             ListTile(
             key: ValueKey('chave_cadastro'),
             title: Text('Cadastro', style: TextStyle(color: Colors.black)),
             leading: Icon(Icons.add_box,  color: Colors.black),
             trailing: Icon(Icons.arrow_right,  color: Colors.black),
             
             onTap: (){
               Navigator.pop(context);
               Navigator.push(context,MaterialPageRoute(builder: (context) => LPS_Cadastro(),
               ));
             },
           ),
          

             ListTile(
             key: ValueKey('chave_agendamento'),
             title: Text('Agendamento', style: TextStyle(color: Colors.black)),
             leading: Icon(Icons.calendar_today,  color: Colors.black),
             trailing: Icon(Icons.arrow_right,  color: Colors.black),
             onTap: (){
               Navigator.pop(context);
               Navigator.push(context,MaterialPageRoute(builder: (context) => LPS_Agendamento(),
               ));
             },
           ),

          ListTile(
             key: ValueKey('chave_notificacoes'),
             title: Text('Notificações', style: TextStyle(color: Colors.black)),
             leading: Icon(Icons.notifications,  color: Colors.black),
             trailing: Icon(Icons.arrow_right,  color: Colors.black),
             onTap: (){
               Navigator.pop(context);
               Navigator.push(context,MaterialPageRoute(builder: (context) => HomeNotify(),
               ));
             },
           ),

          ListTile(
             key: ValueKey('chave_configuracoes'),
             title: Text('Configurações', style: TextStyle(color: Colors.black)),
             leading: Icon(Icons.settings,  color: Colors.black),
             trailing: Icon(Icons.arrow_right,  color: Colors.black),
             onTap: (){
              // Navigator.push(context,MaterialPageRoute(builder: (context) => LPS_Agendamento_Cliente(),
             //  ));
             },
           ),
          
          ListTile(
             key: ValueKey('chave_sobre'),
             title: Text('Sobre', style: TextStyle(color: Colors.black)),
             leading: Icon(Icons.info,  color: Colors.black),
             trailing: Icon(Icons.arrow_right,  color: Colors.black),
             onTap: (){
              // Navigator.push(context,MaterialPageRoute(builder: (context) => LPS_Agendamento_Cliente(),
             //  ));
             },
           ),
          
          ListTile(
             key: ValueKey('chave_sair'),
             title: Text('Sair', style: TextStyle(color: Colors.black)),
             leading: Icon(Icons.exit_to_app, color: Colors.black),
             trailing: Icon(Icons.arrow_right, color: Colors.black),
             onTap: (){
             //  Navigator.push(context,MaterialPageRoute(builder: (context) => LPS_Agendamento_Cliente(),
             //  ));
             },
           ),
        ],
       )
     ),
     ),
     
     // implementação dos serviços da linha de produto utilizando cards
body: new ListView.builder(
        padding: const EdgeInsets.all(5),
        itemBuilder: (context, i) {
          return Container(
            height: 130,
            child: Card(
                color: Colors.amberAccent.shade100,
              elevation: 5,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {

                      },
                      child: Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                          //  color: Colors.red,
                            image: DecorationImage(
                                image: AssetImage('images/endermoterapia.png'),
                                fit: BoxFit.cover),
                            borderRadius:
                                BorderRadius.all(Radius.circular(100.0)),
                           ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      return showDialog<void>(
                        context: context,
                          barrierDismissible: false,
                          builder: (BuildContext conext) {
                          return AlertDialog(
                            title: Text('Not in stock'),
                            content:
                                const Text('This item is no longer available'),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('Ok'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    
                    child: Container(
                        padding: EdgeInsets.all(30.0),
                        alignment: Alignment.topRight,
                        child: Chip(
                          label: Text('Detalhes'),
                          backgroundColor: Colors.amberAccent,
                          elevation: 5,
                          autofocus: true,
                        )),
                  ),
                ],
              ),
            ),
          );
        },
      ),
     
 //    floatingActionButton: FloatingActionButton(
 //      child: Icon(Icons.calendar_today),
 //      backgroundColor: Colors.amberAccent,
 //      onPressed: (){},
 //    ),
    );
  }
}





