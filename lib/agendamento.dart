import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:intl/intl.dart';

import 'models/produto.dart';





class LPS_Agendamento extends StatefulWidget {
  @override
  _LPS_Agendamento createState() => _LPS_Agendamento();
}

class _LPS_Agendamento extends State<LPS_Agendamento> {
  var selectedCurrency, selectedType;
  
  String horario_selecionado;
  String profissional_selecionado;
  String servico_selecionado;
  String data_selecionada;
  String data_formatada;
  //

  String servicoProfissional;
  String dataAgendamentoProfissional;
  String horaarioProfissional;

  final GlobalKey<FormState> _formKeyValue = new GlobalKey<FormState>();
  
  Produto produto = new Produto(); // produto 2 da LPS
 

 
  @override
  Widget build(BuildContext context) {
   

    return Scaffold(
        appBar: AppBar(
                    leading: IconButton(
                    icon: Icon(Icons.home, color: produto.getIconCor),
                    onPressed: () => Navigator.of(context).pop(),
                  ), 
             title: Text('Agendamento', style: TextStyle(color: produto.getTextCor)),
             backgroundColor: produto.getSecondaryCor,
            ),

        backgroundColor: produto.getFundoCor,
        body:Container(
          
          
          child:Form(
          key: _formKeyValue,

          child: new ListView(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            children: <Widget>[
              SizedBox(height: 10.0),            
              SizedBox(height: 10.0),

              new Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: <Color>[
                     produto.getPrimaryCor,
                     produto.getSecondaryCor,
                    ]),
                    borderRadius: BorderRadius.circular(10),  
                  ),

              child:StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance.collection(produto.getUrlFuncionarios).snapshots(),
                  builder: (context, snapshot){
                    if (!snapshot.hasData)
                      const Text("Aguarde");
                    else {
                      List<DropdownMenuItem> currencyItems = [];
                      for (int i = 0; i < snapshot.data.documents.length; i++) {
                        DocumentSnapshot snap = snapshot.data.documents[i];
                        currencyItems.add(
                          DropdownMenuItem(
                            child: Text(
                              snap.documentID,
                              style: TextStyle(color: produto.getTextCor),
                            ),
                            value: "${snap.documentID}",
                          ),
                        );
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.person,
                              size: 40.0, color: produto.getIconCor),
                          SizedBox(width: 50.0),
                          DropdownButton(
                            items: currencyItems,
                            onChanged: (currencyValue) {
                              setState(() {
                                selectedCurrency = currencyValue;
                                profissional_selecionado = selectedCurrency;
                              
                               //
                                produto.setProfissionalServicoUrl(profissional_selecionado);
                              });
                            },
                            value: produto.getProfissionalSelecionado,
                            // provavelmente teremos um text form field
                            isExpanded: false,
                            hint: new Text(
                              "Selecione o Profissional",
                              style: TextStyle(color: produto.getTextCor),
                            ),
                          ),
                        ],
                      );
                    }
                   return Container();
                  }
                )),

                  SizedBox(height: 20.0),
                      new Container(
             
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: <Color>[
                     produto.getPrimaryCor,
                     produto.getSecondaryCor,
                    ]),
                    borderRadius: BorderRadius.circular(10),  
                  ),

              child:StreamBuilder<QuerySnapshot>(    
                 // exibir os serviços                    
                  stream: Firestore.instance.collection(produto.getUrlServicos).snapshots(),
                  builder: (context, snapshot){
                    if (!snapshot.hasData)
                      const Text("Aguarde");
                    else {
                      List<DropdownMenuItem> currencyItems = [];
                      for (int i = 0; i < snapshot.data.documents.length; i++) {
                        DocumentSnapshot snap = snapshot.data.documents[i];
                        currencyItems.add(
                          DropdownMenuItem(
                            child: Text(
                              snap.data['Servico'],
                              style: TextStyle(color: produto.getTextCor),
                            ),
                            value: "${snap.data['Servico']}",
                          ),
                        );
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.home_repair_service,
                              size: 40.0, color: produto.getIconCor),
                          SizedBox(width: 50.0),
                          DropdownButton(
                            items: currencyItems,
                            onChanged: (currencyValue) {
                              setState(() {
                                selectedCurrency = currencyValue;
                                servico_selecionado = selectedCurrency;
                              });
                            },
                            value: servico_selecionado,

                            isExpanded: false,
                            hint: new Text(
                              "Selecione o Serviço",
                              style: TextStyle(color: produto.getTextCor ),
                            ),
                          ),
                        ],
                      );
                    }
                  return Container();

                  })),
                  
                  // Data Disponivel de Agendamento
                  SizedBox(height: 20.0),
                  new Container(
             
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: <Color>[
                     produto.getPrimaryCor,
                     produto.getSecondaryCor,
                    ]),
                    borderRadius: BorderRadius.circular(10),  
                  ),

              child:StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance.collection(produto.getUrlDataAgendamento).snapshots(),
                  builder: (context, snapshot){
                    if (!snapshot.hasData)
                      const Text("Aguarde");
                    else {
                      List<DropdownMenuItem> currencyItems = [];
                      for (int i = 0; i < snapshot.data.documents.length; i++) {
                        DocumentSnapshot snap = snapshot.data.documents[i];
                        currencyItems.add(
                          DropdownMenuItem(
                            child: Text(
                              snap.data['Data'],
                              style: TextStyle(color: produto.getTextCor),
                            ),
                            value: "${snap.data['Data']}",
                          ),
                        );
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.date_range,
                              size: 40.0, color: produto.getIconCor),
                          SizedBox(width: 50.0),
                          DropdownButton(
                            items: currencyItems,
                            onChanged: (currencyValue) {
                              setState(() {
                                selectedCurrency = currencyValue;
                                data_selecionada = selectedCurrency;

                              });
                            },
                            value: data_selecionada,

                            isExpanded: false,
                            hint: new Text(
                              "Selecione a Data",
                              style: TextStyle(color: produto.getTextCor ),
                            ),
                          ),
                        ],
                      );
                    }
                  return Container();

                  })),

                   // Horario disponivel de Agendamento
                  SizedBox(height: 20.0),
                      new Container(
             
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: <Color>[
                     produto.getPrimaryCor,
                     produto.getSecondaryCor,
                    ]),
                    borderRadius: BorderRadius.circular(10),  
                  ),

              child:StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance.collection(produto.getUrlHorarioAgendamento).snapshots(),
                  builder: (context, snapshot){
                    if (!snapshot.hasData)
                      const Text("Aguarde");
                    else {
                      List<DropdownMenuItem> currencyItems = [];
                      for (int i = 0; i < snapshot.data.documents.length; i++) {
                        DocumentSnapshot snap = snapshot.data.documents[i];
                        currencyItems.add(
                          DropdownMenuItem(
                            child: Text(
                              snap.data['Horario'],
                              style: TextStyle(color: produto.getTextCor),
                            ),
                            value: "${snap.data['Horario']}",
                          ),
                        );
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.alarm,
                              size: 40.0, color: produto.getIconCor),
                          SizedBox(width: 50.0),
                          DropdownButton(
                            items: currencyItems,
                            onChanged: (currencyValue) {
                              setState(() {
                                selectedCurrency = currencyValue;
                                horario_selecionado = selectedCurrency;
                              });
                            },
                            value: horario_selecionado,

                            isExpanded: false,
                            hint: new Text(
                              "Selecione o Horario",
                              style: TextStyle(color: produto.getTextCor ),
                            ),
                          ),
                        ],
                      );
                    }
                  return Container();

                  })),
                     
                new Container(
                   /// colocar a logica do agendamento aqui do rascunho
                ),  

              SizedBox(
                height: 250.0,
              ),
                    
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[

                  RaisedButton(
                      color: produto.getComponentCor,
                      textColor: produto.getTextCor,
                      child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text("Concluir Agendamento", style: TextStyle(fontSize: 18.0, color: produto.getTextCor)),
                            ],
                          )),
                      onPressed: (){

                       adicionar_agendamento(context,
                                            profissional_selecionado,
                                            servico_selecionado,
                                            data_selecionada,
                                            horario_selecionado);

                        alerta_agendamento(context);


                      },
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(50.0))),
                ],
              ),
            ],
          ),
        )
      ),
      
    );  
  }

 // metodo utilizado para adicionar um agendamento do cliente ao firebase
  void adicionar_agendamento(BuildContext context, 
                             String profissional, 
                             String servico, 
                             String data, 
                             String horario) async{
    

       String temp = produto.getUrlIdAgendamentoCliente;
       String t = "XAKLCxtkAAcYyd4Qy5XEO0Z0Oq33";
       produto.setAgendamentoCliente(t);
       Firestore.instance.collection(temp+t+"/Agendamento").add({
      
                                  'Profissional': profissional.toString(),
                                  'Servico': servico.toString(),
                                  'Data': data.toString(),
                                  'Horario': horario.toString(),
                               });
  }

  void alerta_agendamento(BuildContext contex){

      showDialog(context: context, 
                 builder: (BuildContext context){
                   return AlertDialog(
                     backgroundColor: produto.getPrimaryCor,
                     
                     title: Text("Agendamento Concluido", style: TextStyle(fontSize: 18, color: produto.getTextCor)),
                     actions: <Widget>[

                          FlatButton(
                            onPressed: ()=> Navigator.of(context).pop(),
                           
                            child: Text('Concluido', style: TextStyle(color: produto.getTextCor)),
                          ),
                            
          ],
         );
        });
      }

    Future<String> abrir_opcao_horario(BuildContext context) async{
      final TimeOfDay t  = await showRoundedTimePicker(context: context, 
                                                       initialTime: TimeOfDay.now(),
                                                       theme: ThemeData(primarySwatch:Colors.amber),
                                               );
      if(t != null){
        setState(() {
             horario_selecionado = t.format(context);     
         });
        }
      }
  
}