import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lps_ufs_tcc/models/produto.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false, // Remover o Banner de Debug
    title: 'Empresa',
    home: LPS_Cadastro_Empresa(),
)); // Executa a Tela de Cadastro de Empresas
}

class LPS_Cadastro_Empresa extends StatefulWidget {
  final String idProdutoSelecionado;

  LPS_Cadastro_Empresa({this.idProdutoSelecionado}); // recebe o id do produto selecionado vindo do estado anterior
  
  
  @override
  _LPS_Cadastro_Empresa createState() => _LPS_Cadastro_Empresa();
}

class _LPS_Cadastro_Empresa extends State<LPS_Cadastro_Empresa>{
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
       title: Text('Cadastro de Empresa'),
       backgroundColor: produto.getFundoCor,
     ),
     body: Center(
       child: Text('Cadastro de Empresa da Nossa LPS'),
     ),

     floatingActionButton: FloatingActionButton(
       child: Icon(Icons.work),
       backgroundColor: Colors.amberAccent,
       onPressed: (){},
     ), 
     
     backgroundColor: Colors.amber[100],
   );
  }

}
 
