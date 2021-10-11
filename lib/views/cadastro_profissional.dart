import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:lps_ufs_tcc/models/produto.dart';




class LPS_Cadastro_Profissional extends StatefulWidget {
  @override
  LPS_Cadastro_P createState() => LPS_Cadastro_P();
}

class LPS_Cadastro_P extends State<LPS_Cadastro_Profissional> {
  var selectedCurrency, selectedType;
  
  String horario_selecionado;
  String profissional_selecionado;
  String servico_selecionado;
  DateTime data_selecionada;
  String data_formatada;
  
  @required var ct_nome_profissional = TextEditingController();
  @required var ct_servico_profissional = TextEditingController();
  @required var ct_data_disponibilidade = TextEditingController();
  @required var ct_horario_disponibilidade = TextEditingController();

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
             title: Text('Cadastro de Profissional', style: TextStyle(color: produto.getTextCor)),
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
            
            // cadastro de profissionais dos produtos da LPS
              new TextFormField(
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.person,
                    color: produto.getIconCor,
                  ),
                  hintText: 'Informe o nome',
                  labelText: 'Nome',
                ),
                 controller: ct_nome_profissional,
              ),

              new TextFormField(
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.home_repair_service,
                    color: produto.getIconCor,
                  ),
                  hintText: 'Informe o Serviço',
                  labelText: 'Serviço',
                ),
                 controller: ct_servico_profissional,
              ),
              
              new TextFormField(
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.date_range,
                    color: produto.getIconCor,
                  ),
                  hintText: 'Informe a Data de Atendimento',
                  labelText: 'Data de Atendimento',
                    ), 
                     controller: ct_data_disponibilidade, 
                   ),            
                
                new Container(
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      

                      new Container(
                        width: 100,
                        height: 60,
                        
                       margin: const EdgeInsets.all(10),
                       decoration: BoxDecoration(
                       gradient: LinearGradient(colors: <Color>[
                       produto.getPrimaryCor,
                       produto.getSecondaryCor,
                    ]),
                    borderRadius: BorderRadius.circular(20),  
                  ),
                  child: Padding(
                      
                          padding: EdgeInsets.all(5.0),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            
                            children: <Widget>[ 

                            new IconButton(
                            icon: Icon(Icons.date_range, size: 40.0, color: produto.getIconCor),
                    onPressed: () async {

                      DateTime data = await showRoundedDatePicker(
                       context: context,
                       initialDate: DateTime.now(),
                       firstDate: DateTime(2021),
                       lastDate: DateTime(2022),
                       borderRadius: 10,
                       theme: ThemeData(primarySwatch:produto.getPopUpCor),
                       );

                       data_selecionada = data;  
                       data_formatada = DateFormat("dd/MM/yyyy").format(data_selecionada).toString();

                       ct_data_disponibilidade.text = data_formatada; 
                     
                    }),
                    ],
                      ),
                    ),
                  ),

                 
                       new TextFormField(
                         decoration: InputDecoration(
                         icon: Icon(
                         Icons.alarm,
                         color: produto.getIconCor,
                       ),
                       hintText: 'Horario de Atendimento',
                       labelText: 'Horario de Atendimento',
                      ), 
                       controller: ct_horario_disponibilidade, 
                    ),  
                  

                    new Container(
                       width: 100,
                       height: 60,

                       margin: const EdgeInsets.all(10),
                       decoration: BoxDecoration(
                       gradient: LinearGradient(colors: <Color>[
                       produto.getPrimaryCor,
                       produto.getSecondaryCor,
                    ]),
                    borderRadius: BorderRadius.circular(20),  

                  ),
                    
                    child: Padding(
                      
                          padding: EdgeInsets.all(5.0),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            
                            children: <Widget>[ 
                             
                              IconButton(
                              icon: Icon(Icons.alarm, size: 40.0, color: produto.getIconCor),
                    onPressed: (){

                     horario_selecionado =  abrir_opcao_horario(context, produto.getPopUpCor) as String;
                     
                     ct_horario_disponibilidade.text = horario_selecionado;
                     
                    }),
                            ],
                          ),
                    ),

                    ),
                   ],
                   
                  ),
                ),  

              SizedBox(
                height: 100.0,
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
                              Text("Concluir Cadastro", style: TextStyle(fontSize: 18.0, color: produto.getTextCor)),
                            ],
                          )),
                      onPressed: (){

                       adicionar_funcionario(context,
                                            ct_nome_profissional.text,
                                            ct_servico_profissional.text,
                                            ct_data_disponibilidade.text,
                                            ct_horario_disponibilidade.text);

                        alerta(context);


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
  void adicionar_funcionario(BuildContext context, 
                             String profissional, 
                             String servico, 
                             String data, 
                             String horario) async{
    
    // criação de um profissional no firestore
    await Firestore.instance.collection(produto.getUrlFuncionarios).document(profissional)
                                   .setData({});
                                   
    var temp = produto.getUrlFuncionarios;
    await Firestore.instance.collection(temp+"/"+profissional+"/Servicos").add({
      "Servico":servico,
      "Disponivel":true,
    });

    await Firestore.instance.collection(temp+"/"+profissional+"/Data").add({
      "Data":data,
      "Disponivel":true,
    });

    await Firestore.instance.collection(temp+"/"+profissional+"/Horario").add({
      "Horario":horario,
      "Disponivel":true,
    });



                        



 //   var cl_profissional = Firestore.instance.collection(produto.getUrlFuncionarios);
 //       cl_profissional.document(profissional).setData(
//        {
 //                                 'Profissional': profissional.toString(),
 //                                 'Servico': servico.toString(),
 //                                 'Data': data.toString(),
 //                                 'Horario': horario.toString(),
 //         }
 //       );
  }

  void alerta(BuildContext contex){

      showDialog(context: context, 
                 builder: (BuildContext context){
                   return AlertDialog(
                     backgroundColor: produto.getPrimaryCor,
                     
                     title: Text("Cadastro Realizado com Sucesso!", style: TextStyle(fontSize: 18, color: produto.getTextCor)),
                     actions: <Widget>[

                          FlatButton(
                            onPressed: ()=> Navigator.of(context).pop(),
                           
                            child: Text('Concluido', style: TextStyle(color: produto.getTextCor)),
                          ),
                            
          ],
         );
        });
      }

    Future<String> abrir_opcao_horario(BuildContext context, Color popupColor) async{
      final TimeOfDay t  = await showRoundedTimePicker(context: context, 
                                                       initialTime: TimeOfDay.now(),
                                                       theme: ThemeData(primarySwatch:produto.getPopUpCor),
                                               );
      if(t != null){
        setState(() {
             ct_horario_disponibilidade.text = t.format(context);     
         });
        }
      }
  
}