import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lps_ufs_tcc/models/feature.dart';
import 'package:lps_ufs_tcc/models/produto.dart';
import 'cliente.dart';
import 'funcionario.dart';




void main(){
//
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false, // Remover o Banner de Debug
    title: 'Cadastro',
    home: LPS_Cadastro(),
)); // Executa a Tela Principal do Aplicativo
}

// criar estado
class LPS_Cadastro extends StatefulWidget {

  String idProdutoSelecionado;

  LPS_Cadastro({this.idProdutoSelecionado}); // recebe o id do produto selecionado vindo do estado anterior
  
  @override
  _LPS_Cadastro createState() => _LPS_Cadastro();
  
}


// ignore: camel_case_types
class _LPS_Cadastro extends State<LPS_Cadastro>{
  
  Produto produto;

    @override
     void initState() {
      super.initState();
      produto = new Produto.CriarProduto(widget.idProdutoSelecionado);
      produto.setProduto(widget.idProdutoSelecionado);
     }

 
 @override
 Widget build(BuildContext context){  

  //produto.CriarProduto(widget.idProdutoSelecionado);
  produto = Produto.CriarProduto(widget.idProdutoSelecionado);

   return Scaffold(

     appBar: AppBar(
       leading: IconButton(
                icon: Icon(Icons.home, color: produto.getIconCor),
              onPressed: () => Navigator.of(context).pop(),
         ), 
       title: Text('Menu de Cadastro', style: TextStyle(color: produto.getTextCor)),
       backgroundColor: produto.getSecondaryCor,  
     ),

     body: StreamBuilder(
       stream: Firestore.instance.collection(produto.getUrlConfigFeatureCadastro).snapshots(),
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
             return Center(child: Text('Sem Novas Features Adicionadas no Momento'));
         }
         
         return ListView.builder(
           itemCount: snapshot.data.documents.length,
           itemBuilder: (BuildContext context, int i) {

           var item = snapshot.data.documents[i].data;
           
           
           return Container(
                  // retorna um objeto do tipo feature com os seus atributos em forma de botão
                  // status, nome
                  
                 child: produto.CarregarFeaturesCadastro(context, item['nome'], item['enabled'],widget.idProdutoSelecionado),
                  
                 );
                },
              );
             },
           ),

    backgroundColor: produto.getFundoCor,
   );
  }
  
}




