import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:intl/intl.dart';

import 'package:lps_ufs_tcc/models/produto.dart';
import 'package:shared_preferences/shared_preferences.dart';





class LPS_Agendamento extends StatefulWidget {
  
  String uid;
  String idProdutoSelecionado;
  
  LPS_Agendamento({this.uid, this.idProdutoSelecionado});
  

  @override
  _LPS_Agendamento createState() => _LPS_Agendamento();
  
}

class _LPS_Agendamento extends State<LPS_Agendamento> {


  String uid;
  String nome;
  String idAgendamento;
  String idProdutoSelecionado;
  
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
  
  Produto produto; // produto 2 da LPS
 
     @override
      void initState() {
      super.initState();
      produto = new Produto.CriarProduto(widget.idProdutoSelecionado);
      produto.setProduto(widget.idProdutoSelecionado);
     }


 
  @override
  Widget build(BuildContext context) {
   
    //produto.CriarProduto(widget.idProdutoSelecionado);
   // produto = Produto.CriarProduto(widget.idProdutoSelecionado);

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
                          Icon(Icons.school,
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

                       // adiciona o agendamento ao respectivo cliente
                       adicionar_agendamento(context,
                                            profissional_selecionado,
                                            servico_selecionado,
                                            data_selecionada,
                                            horario_selecionado);

                       // adiciona o agendamento ao respectivo Empreendedor Administrador

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

// criar um campo token para identificar
// metodo responsavel pelo armazenamento do agendamento junto ao empreendedor
 // ignore: non_constant_identifier_names
 void adicionar_agendamento_empreendedor(BuildContext context, 
                             String profissional, 
                             String servico, 
                             String data, 
                             String horario,
                             String idAgendamento) async{
    
        // captura dos dados do utilizador pelo sharedpreferences
        SharedPreferences dadosUtilizador = await SharedPreferences.getInstance();
        this.uid = dadosUtilizador.getString("uid");
        DocumentSnapshot dataUser = await Firestore.instance.collection(produto.getUrlClientes).document(this.uid).get();
        this.nome = dataUser['nome'];
       
        

        // gravação dos dados no diretorio agendamento
        
        await Firestore.instance.collection(produto.getUrlEmpreendedor).add({
                                  'ID':this.uid,
                                  'IDAgendamento':idAgendamento,
                                  'Nome':this.nome,
                                  'Profissional': profissional.toString(),
                                  'Servico': servico.toString(),
                                  'Data': data.toString(),
                                  'Horario': horario.toString(),
                                  'Status': "Aguardando",
                               });
  }

 // metodo utilizado para adicionar um agendamento do cliente ao firebase
  void adicionar_agendamento(BuildContext context, 
                             String profissional, 
                             String servico, 
                             String data, 
                             String horario) async{
    
        
        // captura dos dados do utilizador pelo sharedpreferences
        
        SharedPreferences dadosUtilizador = await SharedPreferences.getInstance();
        this.uid = dadosUtilizador.getString("uid");
        DocumentSnapshot dataUser = await Firestore.instance.collection(produto.getUrlClientes).document(this.uid).get();
        this.nome = dataUser['nome'];

        // criação do diretorio dos agendamentos
        String urlTemp =  produto.getUrlIdAgendamentoCliente+"/"+this.uid;
        criarDiretorios(context, urlTemp);


        // gravação dos dados no diretorio agendamento
        String urlCompleta = urlTemp+"/Agendamento";
        await Firestore.instance.collection(urlCompleta).add({
                                  'ID':this.uid,
                                  'Nome':this.nome,
                                  'Profissional': profissional.toString(),
                                  'Servico': servico.toString(),
                                  'Data': data.toString(),
                                  'Horario': horario.toString(),
                                  'Status': "Aguardando",
                               }).then((value) => {

                               this.idAgendamento = value.documentID,
                               adicionar_agendamento_empreendedor(context,
                                            profissional_selecionado,
                                            servico_selecionado,
                                            data_selecionada,
                                            horario_selecionado,
                                            this.idAgendamento),



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

      Future<void> criarDiretorios(BuildContext context, String url) async{
        await Firestore.instance.collection(url).document("Agendamento").setData({
          'Ativo':true,
        });
      }
      

  
}