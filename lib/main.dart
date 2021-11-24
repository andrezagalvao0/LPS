import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lps_ufs_tcc/views/agendamento.dart';
import 'package:lps_ufs_tcc/views/agendamento_sem_cadastro.dart';
import 'package:lps_ufs_tcc/views/agendamento_sem_cadastro_lista.dart';
import 'package:lps_ufs_tcc/views/cadastro.dart';
import 'package:lps_ufs_tcc/views/cadastro_profissional.dart';
import 'package:lps_ufs_tcc/views/empreendedor.dart';
import 'package:lps_ufs_tcc/views/empreendedor_menu.dart';
import 'package:lps_ufs_tcc/views/login.dart';
import 'models/notificacoes.dart';
import 'models/produto.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/selecionar_produto.dart'; // biblioteca utilizada para capturar os dados do utilizador logado



void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  
  Produto produto = new Produto(); // produto 2 da LPS

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
    home: LPS_Select_App(),
)); // Executa a Tela Principal do Aplicativo
}

// ignore: must_be_immutable
class Homescreen extends StatelessWidget{
  
  Produto produto = new Produto(); // produto 2 da LPS
  String uid;

  Homescreen({Key key, this.uid}) : super(key: key); // recebe o uid do utilizador 

 @override
 Widget build(BuildContext context){
     
     var item = null;
    

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
                 produto.getDrawerDecorationPrimaryColor,
                 produto.getDrawerDecorationSecondaryColor,
             ])
         ),

       child: ListView(
         children: <Widget>[ 
           DrawerHeader(
              decoration: BoxDecoration(
                 image: DecorationImage( image: produto.getAppImage),
                 gradient: LinearGradient(colors: <Color>[
                 produto.getDrawerHeaderPrimaryColor,
                 produto.getDrawerHeaderSecondaryColor,
             ])
            ),
           ),
        
      StreamBuilder(  
      stream: Firestore.instance.collection(produto.getUrlConfigFeatures).orderBy("nome").snapshots(),
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
             return Center(child: Text('Nenhuma Feature Encontrada'));
         }

         return ListView.builder(
              itemCount:snapshot.data.documents.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int i){

                var item = snapshot.data.documents[i].data;
              
              return  Container(
                
                    child:produto.CarregarFeaturesMenu(context,item['nome'], 
                                                   item['enabled']),
                  
                );
              },
            );   
          }),
  
         // Features Fixas
     //       ListTile(
     //        title: Text('Personalizar', style: TextStyle(color: produto.getTextCor)),
     //        leading: Icon(Icons.science,  color: produto.getIconCor),
     //        trailing: Icon(Icons.arrow_right,  color: produto.getIconCor),
             
     //        onTap: (){
     //            Navigator.pop(context);
     //            Navigator.push(context,MaterialPageRoute(builder: (context) => LPS_Select_App(),

     //          ));
     //        },
     //      ),

            ListTile(
             title: Text("Sair", style: TextStyle(color: produto.getTextCor)),
             leading: Icon(Icons.exit_to_app,  color: produto.getIconCor),
             trailing: Icon(Icons.arrow_right,  color: produto.getIconCor), 
             onTap: () => exit(0),
           ),
 

        ],
        shrinkWrap: true,
       )
     ),
    ),
     
     // implementação dos serviços da linha de produto utilizando cards
body:  StreamBuilder(
       
       stream: Firestore.instance.collection(produto.getUrlIdAgendamentoCliente+'/'+this.uid+'/Agendamento').orderBy("Data").snapshots(),
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
          
           return InkWell(
                  onLongPress:(){
                  // print("Parabens Você Descobriu uma Feature!");
                  produto.ConfirmarAgendamento(context, item);
                  
                  },
                  child: new Ink(
                     color: produto.getFundoCor,
                     child:Container(
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
                     decoration: BoxDecoration(
                        image: DecorationImage(
                        image: produto.getAppThumbnailService(item["Servico"]),
                               fit: BoxFit.fitHeight,
                               alignment: AlignmentDirectional.centerEnd,
                              ),
                              borderRadius: BorderRadius.circular(10),
                     ),
                     child: Column(  
                      crossAxisAlignment: CrossAxisAlignment.start, // responsavel por alinhar a esquerda o icone do estabelecimento
                      children: [
                        Row(
                           children: [
                           Icon(Icons.school, color: produto.getIconCor),
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
                           Text(item["Horario"]+"h",style: TextStyle(color: produto.getTextCor, fontSize: 18)),
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
                           // alignment: AlignmentDirectional.topStart,
                           
                          ),   
                       ),
                      ],
                     ),
                   ),
                   //  onLongPress: () => model_options_cliente(context,Text(item['Nome']), item),
                 ),
                ),
                ); 
                },
              );
             },
           ),
        backgroundColor: produto.getFundoCor,
    );
    
  }

}





