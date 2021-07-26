import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'agendamento.dart';
import 'cadastro.dart';
import 'login.dart';
import 'models/notificacoes.dart';
import 'models/produto.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main(){
  
 Produto produto = new Produto("Estetica");

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false, // Remover o Banner de Debug
    theme: ThemeData(
    
    // Define the default brightness and colors.
    primaryColor: produto.getPrimaryCor,
    accentColor: produto.getSecondaryCor),

       localizationsDelegates: GlobalMaterialLocalizations.delegates,
         supportedLocales: [
           const Locale('en', 'US'), // American English
           const Locale('ru', 'RU'), // Russian
           const Locale("pt") // Portuguese
      ],


    // criar o metodo interruptor da Linha de Produto
    title: 'Login',
    home: LPS_Login(),
)); // Executa a Tela Principal do Aplicativo
}

class Homescreen extends StatelessWidget{
  
  Produto produto = new Produto("Estetica");


 @override
 Widget build(BuildContext context){

   return Scaffold(

     appBar: AppBar(
       iconTheme: IconThemeData(
       color: produto.getIconCor),
       title: Text('Meus Agendamentos', style: TextStyle(color: produto.getTextCor)),
       backgroundColor: produto.getSecondaryCor,
     ),
      
     drawer: Drawer(

       child: Container(

         decoration: BoxDecoration(
           gradient: LinearGradient(colors: <Color>[
                 produto.getPrimaryCor,
                 produto.getSecondaryCor,
                 
             ])
         ),

       child: ListView(
         children: <Widget>[ 
           DrawerHeader(
              decoration: BoxDecoration(
                 image: DecorationImage( image: produto.getAppImage),
                 gradient: LinearGradient(colors: <Color>[
                 produto.getPrimaryCor,
                 produto.getSecondaryCor,
             ])
            ),
           ),
            
           // lista de features principais da linha de produto de software
            

             ListTile(
             key: ValueKey('chave_inicio'),
             title: Text('Inicio', style: TextStyle(color: produto.getTextCor)),
             leading: Icon(Icons.home,  color: produto.getIconCor),
             trailing: Icon(Icons.arrow_right,  color: produto.getIconCor),
             
             onTap: (){
               Navigator.pop(context);
                 Navigator.push(context,MaterialPageRoute(builder: (context) => Homescreen(),
               ));
             },
           ),

             ListTile(
             key: ValueKey('chave_cadastro'),
             title: Text('Cadastro', style: TextStyle(color: produto.getTextCor)),
             leading: Icon(Icons.add,  color: produto.getIconCor),
             trailing: Icon(Icons.arrow_right,  color: produto.getIconCor),
             
             onTap: (){
               Navigator.pop(context);
                 Navigator.push(context,MaterialPageRoute(builder: (context) => LPS_Cadastro(),
               ));
             },
           ),
          

             ListTile(
             key: ValueKey('chave_agendamento'),
             title: Text('Agendamento', style: TextStyle(color: produto.getTextCor)),
             leading: Icon(Icons.calendar_today,  color: produto.getIconCor),
             trailing: Icon(Icons.arrow_right,  color: produto.getIconCor),
             onTap: (){
               Navigator.pop(context);
               Navigator.push(context,MaterialPageRoute(builder: (context) => LPS_Agendamento(),
               ));
             },
           ),

          ListTile(
             key: ValueKey('chave_notificacoes'),
             title: Text('Notificações', style: TextStyle(color: produto.getTextCor)),
             leading: Icon(Icons.notifications,  color: produto.getIconCor),
             trailing: Icon(Icons.arrow_right,  color: produto.getIconCor),
             onTap: (){
               Navigator.pop(context);
               Navigator.push(context,MaterialPageRoute(builder: (context) => HomeNotify(),
               ));
             },
           ),

          ListTile(
             key: ValueKey('chave_configuracoes'),
             title: Text('Configurações', style: TextStyle(color: produto.getTextCor)),
             leading: Icon(Icons.settings,  color: produto.getIconCor),
             trailing: Icon(Icons.arrow_right,  color: produto.getIconCor),
             onTap: (){
          //     Navigator.push(context,MaterialPageRoute(builder: (context) => MyApp(),
          //     ));
             },
           ),
          
          ListTile(
             key: ValueKey('chave_sobre'),
             title: Text('Sobre', style: TextStyle(color: produto.getTextCor)),
             leading: Icon(Icons.info,  color: produto.getIconCor),
             trailing: Icon(Icons.arrow_right,  color: produto.getIconCor),
             onTap: (){
              // Navigator.push(context,MaterialPageRoute(builder: (context) => LPS_Agendamento_Cliente(),
             //  ));
             },
           ),
          
          ListTile(
             key: ValueKey('chave_sair'),
             title: Text('Sair', style: TextStyle(color: produto.getTextCor)),
             leading: Icon(Icons.exit_to_app, color: produto.getIconCor),
             trailing: Icon(Icons.arrow_right, color: produto.getIconCor),
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
body:  StreamBuilder(
       stream: Firestore.instance.collection("Agendamento").snapshots(),
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
             return Center(child: Text('Nenhum Agendamento Existente'));
         }
         
         return ListView.builder(
           itemCount: snapshot.data.documents.length,
           itemBuilder: (BuildContext context, int i) {

           var item = snapshot.data.documents[i].data;

           return Container(

  

                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: <Color>[
                     produto.getPrimaryCor,
                     produto.getSecondaryCor,
                    ]),
                    borderRadius: BorderRadius.circular(10),  
                  ),

                  margin: const EdgeInsets.all(5),

                   child: Container(
                     height: 150,
                     child: Column(  
                     
                      children: [
                        Row(
                           children: [
                           Icon(Icons.person, color: produto.getIconCor),
                           Text(item["Profissional"],style: TextStyle(color: produto.getTextCor, fontSize: 18)),
                        ],
                      ),
                        Row(
                           children: [
                           Icon(Icons.calendar_today, color: produto.getIconCor),
                           Text(item["Data"],style: TextStyle(color: produto.getTextCor, fontSize: 18)),
                        ],
                      ),
                        Row(
                           children: [
                           Icon(Icons.alarm, color: produto.getIconCor),
                           Text(item["Horario"],style: TextStyle(color: produto.getTextCor, fontSize: 18)),
                        ],
                      ),
                        Row(
                           children: [
                           Icon(Icons.home_repair_service, color: produto.getIconCor),
                           Text(item["Servico"],style: TextStyle(color: produto.getTextCor, fontSize: 18)),
                        ],
                      ),
                         Expanded(
                          flex: 3,
                          child: Image(
                            image: produto.getAppImageService,
                          ),
                       ),
                      ],
                     ),
                   ),
                   //  onLongPress: () => model_options_cliente(context,Text(item['Nome']), item),
                 );
                },

              );
             },
           ),
        backgroundColor: produto.getFundoCor,
    );
    
  }
}





