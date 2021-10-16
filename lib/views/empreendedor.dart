import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lps_ufs_tcc/views/cadastro_profissional.dart';
import 'package:lps_ufs_tcc/models/produto.dart';
import 'package:lps_ufs_tcc/models/select_product.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


class LPS_Empreendedor_Suite extends StatelessWidget{
  
  Produto produto = new Produto(); // produto 2 da LPS
  

 @override
 Widget build(BuildContext context){

   return Scaffold(

     appBar: AppBar(
       leading: IconButton(
                    icon: Icon(Icons.arrow_back, color: produto.getIconCor),
                    onPressed: () => Navigator.of(context).pop(),
       ),
       iconTheme: IconThemeData(
       color: produto.getIconCor),
       title: Text('Clientes Agendados', style: TextStyle(color: produto.getTextCor)),
       backgroundColor: produto.getSecondaryCor,
     ),
      
     // implementação dos serviços da linha de produto utilizando cards
     body:  StreamBuilder(
       stream: Firestore.instance.collection(produto.getUrlEmpreendedor).orderBy("Data").snapshots(),
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
                     decoration: BoxDecoration(
                        image: DecorationImage(
                        image: produto.getAppThumbnailService(item["Servico"]),
                               fit: BoxFit.fitHeight,
                               alignment: AlignmentDirectional.centerEnd,
                              ),
                              borderRadius: BorderRadius.circular(10),
                     ),
                     child: Column(  
                       crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                           children: [
                           Icon(Icons.person, color: produto.getIconCor),
            //               Text(item["ID"],style: TextStyle(color: produto.getTextCor, fontSize: 18)),
                        ],
                      ),
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





