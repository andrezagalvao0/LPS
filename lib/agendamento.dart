import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_localizations/flutter_localizations.dart';



class LPS_Agendamento extends StatefulWidget {
  @override
  _LPS_Agendamento createState() => _LPS_Agendamento();
}

class _LPS_Agendamento extends State<LPS_Agendamento> {
  var selectedCurrency, selectedType;
  String horario_selecionado = "8:00 AM";

  final GlobalKey<FormState> _formKeyValue = new GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
   
    Future<void> abrir_opcao_horario(BuildContext context) async{
      final TimeOfDay t  = await showTimePicker(context: context, 
                                               initialTime: TimeOfDay.now());
      if(t != null){
        setState(() {
             horario_selecionado = t.format(context);     
         });
        }
      }


    return Scaffold(
        appBar: AppBar(
                    leading: IconButton(
                    icon: Icon(Icons.home, color: Colors.black),
                    onPressed: () => Navigator.of(context).pop(),
                  ), 
             title: Text('Agendamento', style: TextStyle(color: Colors.black)),
             backgroundColor: Colors.amberAccent,
            ),

        backgroundColor: Colors.amber[100],
        body:Container(
          

          
          child:Form(
          key: _formKeyValue,
          autovalidate: true,
          child: new ListView(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            children: <Widget>[
              SizedBox(height: 10.0),            
              SizedBox(height: 10.0),
              StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance.collection("Profissionais").snapshots(),
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
                              style: TextStyle(color: Colors.black),
                            ),
                            value: "${snap.documentID}",
                          ),
                        );
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.person,
                              size: 40.0, color: Colors.black),
                          SizedBox(width: 50.0),
                          DropdownButton(
                            items: currencyItems,
                            onChanged: (currencyValue) {
                                final snackBar = SnackBar(
                                content: Text(
                                  'O Item Selecionado Foi $currencyValue',
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                              Scaffold.of(context).showSnackBar(snackBar);
                              setState(() {
                                selectedCurrency = currencyValue;
                              });
                            },
                            value: selectedCurrency,
                            isExpanded: false,
                            hint: new Text(
                              "Selecione o Profissional",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      );
                    }
                    
                  }),

                    SizedBox(height: 20.0),
              StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance.collection("Servicos").snapshots(),
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
                              style: TextStyle(color: Colors.black),
                            ),
                            value: "${snap.documentID}",
                          ),
                        );
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.room_service,
                              size: 40.0, color: Colors.black),
                          SizedBox(width: 50.0),
                          DropdownButton(
                            items: currencyItems,
                            onChanged: (currencyValue) {
                                   final snackBar = SnackBar(
                                    content: Text(
                                  'O Item Selecionado Foi $currencyValue',
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                              Scaffold.of(context).showSnackBar(snackBar);
                              setState(() {
                                selectedCurrency = currencyValue;
                              });
                            },
                            value: selectedCurrency,
                            isExpanded: false,
                            hint: new Text(
                              "Selecione o Serviço",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      );
                    }
        //
                  }),
                  const Divider(
                         color: Colors.black,
                         height: 30,
                         thickness: 5,
                         indent: 20,
                         endIndent: 20,
                       ), 

                 
                new Container(
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[

                      SizedBox(height: 30),
                    new Text("Selecione a data do agendamento", style: TextStyle(fontSize: 18)),
                    
                    new IconButton(
                    icon: Icon(Icons.date_range, size: 40.0),
                    onPressed: () async {

                      final data = await showDatePicker(
                        context: context, 
                        initialDate: DateTime.now(), 
                        firstDate: DateTime(2021), 
                        lastDate: DateTime(2022),
                        locale: Locale("pt","BR"),
                      );
                     
                    }),

                    SizedBox(height: 30),
                    new Text("Selecione o horario do agendamento", style: TextStyle(fontSize: 18)),
                    
                    new IconButton(
                    icon: Icon(Icons.alarm, size: 40.0),
                    onPressed: (){

                      abrir_opcao_horario(context);
                     
                    }),

                    // o widget de horario ficara aqui


                    
                   ],
                   
                  ),
                ),  

              SizedBox(
                height: 180.0,
              ),

            
                    
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[

                

                  RaisedButton(
                      color: Colors.amberAccent,
                      textColor: Colors.black,
                      child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text("Concluir Agendamento", style: TextStyle(fontSize: 18.0)),
                            ],
                          )),
                      onPressed: () {},
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0))),
                ],
              ),
            ],
          ),
        )
      ),
      
    );  
  }
  
}