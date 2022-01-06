import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lps_ufs_tcc/models/produto.dart';
import 'package:lps_ufs_tcc/views/agendamento_sem_cadastro.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false, // Remover o Banner de Debug
    title: 'Cliente',
    home: LPS_Cadastro_Cliente(),
)); // Executa a Tela de Cadastro de Cliente
}

class LPS_Cadastro_Cliente extends StatefulWidget { 
  final String idProdutoSelecionado;

  LPS_Cadastro_Cliente({this.idProdutoSelecionado}); // recebe o id do produto selecionado vindo do estado anterior
  
 @override
 _LPS_Cadastro_Cliente createState() => _LPS_Cadastro_Cliente();
}

class _LPS_Cadastro_Cliente extends State<LPS_Cadastro_Cliente>{

  Produto produto;

      @override
      void initState() {
      super.initState();
      produto = new Produto.CriarProduto(widget.idProdutoSelecionado);
      produto.setProduto(widget.idProdutoSelecionado);
     }

     @override
 Widget build(BuildContext context){
   return Scaffold(
     appBar: AppBar(
       title: Text('Cadastro de Cliente'),
       backgroundColor: produto.getFundoCor,
     ),
     body: Center(
       child: Text('Cadastro de Cliente da Nossa LPS'),
     ),

     floatingActionButton: FloatingActionButton(
       child: Icon(Icons.person),
       backgroundColor: Colors.amberAccent,
       onPressed: (){},
     ),

     backgroundColor: Colors.amber[100],
   );

  }
}
