import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lps_ufs_tcc/views/cadastro_profissional.dart';
import 'package:lps_ufs_tcc/models/produto.dart';
import 'package:lps_ufs_tcc/models/select_product.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


class LPS_Agendamento_sem_Cadastro_Lista extends StatelessWidget{
  
  Produto produto = new Produto(); // produto 2 da LPS
  String id_documento;
  

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
       title: Text('Agendados sem Cadastro', style: TextStyle(color: produto.getTextCor)),
       backgroundColor: produto.getSecondaryCor,
     ),
      
     // implementação dos serviços da linha de produto utilizando cards
     body:  StreamBuilder(
       stream: Firestore.instance.collection(produto.getUrlAgendamento).snapshots(),
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
           this.id_documento  = snapshot.data.documents[i].documentID;

           
           produto.StatusAgendamento(item["Status_Agendamento"]); // verifica o status do agendamento sem cadastro no firebase

           return InkWell(
                  onLongPress:(){
                  // print("Parabens Você Descobriu uma Feature!");
                  ConfirmarNotificacaoAgendamento(context, item, this.id_documento);
                //  print("O ID desse Documento é : "+this.id_documento);

                  },
                  child: new Ink(
                     color: produto.getFundoCor,
                     child:Container(
                  height: 150,
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
                           Icon(Icons.person, color: produto.getIconCor),
                           Text(item["Nome"],style: TextStyle(color: produto.getTextCor, fontSize: 18)),
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
                           Text(item["Horario"]+"h",style: TextStyle(color: produto.getTextCor, fontSize: 18)),
                        ],
                      ),
                        Row(
                           children: [
                           Icon(Icons.home_repair_service, color: produto.getIconCor),
                           Text(item["Servico"],style: TextStyle(color: produto.getTextCor, fontSize: 18)),
                        ],
                      ),
                        Row(
                           children: [
                           Icon(Icons.notifications, color: produto.getIconCor),
                           Text(item["Status_Agendamento"],style: TextStyle(color: produto.getTextCor, fontSize: 18)),
                        ],
                      ),
         //                Expanded(
         //                 flex: 3,
         //                 child: Image(
         //                   image: produto.getAppImageService,
         //                 ),
         //              ),
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
   void ConfirmarNotificacaoAgendamento(BuildContext context, var item, String id) {
  // configura os botões
  
  Widget btn_cancelar = Container(
    child:Column(
      children: [
       IconButton(
         icon: Icon(Icons.arrow_back, color: produto.getIconCor),
         onPressed: (){
           Navigator.pop(context);
         },
       ),
       Text("Voltar", style: TextStyle(color: produto.getTextCor)),
      ],

    ),
  );

  Widget btn_confirmar = Container(
    child:Column(
      children: [
       IconButton(
         icon: Icon(Icons.check, color: produto.getIconCor),
         onPressed: (){
           Navigator.pop(context);
         },
       ),
       Text("Confirmar", style: TextStyle(color: produto.getTextCor)),
      ],

    ),
  );
  Widget btnExcluir = Container(
    child:Column(
      children: [
       IconButton(
         icon: Icon(Icons.delete, color: produto.getIconCor),
         onPressed: (){
           ExcluirAgendamento(produto.getUrlAgendamento, id);
           Navigator.pop(context);
         },
       ),
       Text("Excluir", style: TextStyle(color: produto.getTextCor)),
      ],

    ),
  );
  // configura o  AlertDialog
  AlertDialog alert = AlertDialog(
    
    backgroundColor: produto.getPrimaryCor,
    title: Text("Detalhes"),

    content: Text("Cliente: "+item["Nome"]+"\n"+
                  "Profisional: "+item["Profissional"]+"\n"+
                  "Serviço: "+item["Servico"]+"\n"+
                  "Data: "+item["Data"]+"\n"+
                  "Horario: "+item["Horario"]+"h\n"+
                  "Situação: "+item["Status_Agendamento"]),
    actions: [
      btn_cancelar,
      btn_confirmar, // MUITO IMPORTANTE ao confirmar o agendamento será enviada ao dispositivo do cliente ma notificação confirmando o agendamento
      btnExcluir, 
    ],
  );
  // exibe o dialogo
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

// metodo de remoção de um agendamento
   void ExcluirAgendamento(String url, String id_documento){
     Firestore.instance.collection(url).document(id_documento).delete();
     //print("O documento : "+id_documento+" foi excluido");
    }
}





