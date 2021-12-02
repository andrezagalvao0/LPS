import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lps_ufs_tcc/models/feature.dart';
import 'package:lps_ufs_tcc/models/produto.dart';
import 'package:lps_ufs_tcc/views/login.dart';
import 'package:shared_preferences/shared_preferences.dart';




void main(){
//
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false, // Remover o Banner de Debug
    title: 'Personalizar',
    home: LPS_Select_App(),
)); // Executa a Tela Principal do Aplicativo
}

class LPS_Select_App extends StatefulWidget {
  
  @override
  _LPS_Select_App createState() => _LPS_Select_App();
  
}


class _LPS_Select_App extends State<LPS_Select_App>{
  bool isSwitched = false;
  Produto produto = new Produto();
  String produto_selecionado;
  String idProdutoSelecionado;
  String estabelecimento_selecionado;
  String id;
  String novoValor;
  String value;
  var selectedCurrency;

  final GlobalKey<FormState> _formKeyValue = new GlobalKey<FormState>();
    List<String> _TipoProduto = <String>[
    'Advocacia',
    'Barbearia',
    'Estetica e Design',
    'Fisioterapia',
    'Terapeuta Corporal'
  ];
  


 // classe responsavel por apresentar os produtos da linha de produto de software 
 // para o dominio do Setor Terciario 
 
 @override
 Widget build(BuildContext context){  

  // @override
  //LPS_Select_App createState() => LPS_Select_App();

   return Scaffold(

     appBar: AppBar(
       leading: IconButton(
                icon: Icon(Icons.exit_to_app_outlined, color: Colors.black),
              onPressed: () => exit(0),
         ), 
       title: Text('Configurar Produto', style: TextStyle(color: Colors.black)),
       backgroundColor: Colors.white, 
     ),
     
     backgroundColor: Colors.white,
     // exibir o nome dos produtos
     body: Container(
       child: Form(
           
           child: new ListView(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            children: <Widget>[
             
              SizedBox(height: 10.0),            
              SizedBox(height: 10.0),
            

            // escolha do produto que será utilizado
            
                

            Center(
            child:DropdownButton<String>(
            hint: Text("Escolha um Produto", style: TextStyle(color: Colors.black)),
            items: <String>['Advocacia', 'Barbearia' ,'Estetica e Design', 'Fisioterapia', 'Terapeuta Corporal'].map((value) {
                   return DropdownMenuItem<String>(
                   value: value,
                   child: Text(value),
                   );
                 }).toList(),
                onChanged: (novoValor) {
                  setState((){
                   produto.setProduto(novoValor);
                  //produto.criarProduto(novoValor);
                  });  
                },
            ),
          ),
          Container(
                child: Column(
                children: <Widget>[
                new Text("Produto : "+produto.getProdutoSelecionado, style: TextStyle(color: Colors.black)),
                ]
              ),
          ),
          
            
        SizedBox(height: 10.0),     
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

         return Container(
                child: Column(
                children: <Widget>[
                new Text("Funcionalidades", style: TextStyle(color: Colors.black)),

              ListView.builder(
              itemCount:snapshot.data.documents.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int i){

                var item = snapshot.data.documents[i].data;
                
              
              return  Container(

               // exibe a tela de escolha das features que estarão no produto
               child:produto.EscolherFeaturesproduto(context, item['nome'], item['enabled']), 
                  
                    );
                   },
                  ),
                  ]
                ),
               );   
              }),       
                  // toogle button com as features
                Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[

                  RaisedButton(
                      color: Colors.white,
                      textColor: Colors.black,
                      child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text("Criar Produto", style: TextStyle(fontSize: 18.0, color: Colors.black)),
                            ],
                          )),
                      onPressed: () {
                        
                         idProdutoSelecionado = produto.getProdutoSelecionado;
                         produto.setProduto(novoValor);
                         Navigator.pop(context);
                         Navigator.push(context,MaterialPageRoute(builder: (context) => LPS_Login(idProdutoSelecionado: idProdutoSelecionado)));
                      },
                      
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(50.0))),
                ],
              ),

            ],
          ),

       ),
      ),
    );         
  }

  Future<void> atualizaStatusProduto(String itemNome, itemEnabled) async{
    if(itemEnabled == false){
      setState((){
      Firestore.instance.collection(produto.getUrlConfigFeatures).document(itemNome).updateData({
                                    'enabled':true,
                                  });
    });

   if(itemEnabled == true){
      setState((){
      Firestore.instance.collection(produto.getUrlConfigFeatures).document(itemNome).updateData({
                                    'enabled':false,
                                  });
    });
   }
    }
  }  
}


