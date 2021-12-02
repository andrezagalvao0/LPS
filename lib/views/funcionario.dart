import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lps_ufs_tcc/models/produto.dart';
import 'package:lps_ufs_tcc/views/agendamento_sem_cadastro.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false, // Remover o Banner de Debug
    title: 'Funcionario',
    home: LPS_Cadastro_Funcionario(),
)); // Executa a Tela de Cadastro de Funcionario
}

class LPS_Cadastro_Funcionario extends StatefulWidget {
  final String idProdutoSelecionado;

  LPS_Cadastro_Funcionario({this.idProdutoSelecionado}); // recebe o id do produto selecionado vindo do estado anterior
  
  
  @override
  _LPS_Cadastro_Funcionario createState() => _LPS_Cadastro_Funcionario();
}


class _LPS_Cadastro_Funcionario extends State<LPS_Cadastro_Funcionario>{


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
       title: Text('Cadastro de Funcionario'),
       backgroundColor: produto.getFundoCor,
     ),
     body: Center(
       child: Text('Cadastro de Funcionario da Nossa LPS'),
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