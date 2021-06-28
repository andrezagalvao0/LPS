// classe responsavel pelo gerenciamento de produtos da linha de produto

import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Produto{

Color itemcor;   // atributo resposanvel pela cor dos itens dos menus como labels e icones
Color appcor;    // atributo responsavel pela cor principal dos produtos da linha 
Color fundocor;  // atributo responsavel pela cor de fundo dos produtos da linha
AssetImage applogo;   // atributo responsavel pelo logotipo dos produtos da linha 

// recebe uma identificação sobre qual esquema de aparencia sera exibida de acordo com o resultado enviado pelo firebase
// Estetica, Fisioterapia, Advocacia
Produto(String refProduto){
  
  if(refProduto == 'Estetica'){
     this.itemcor  = Colors.black;
     this.appcor   = Colors.amber[100];
     this.fundocor = Colors.white;
     this.applogo  = AssetImage('images/header_estetica.png');
  }

  if(refProduto == 'Fisioterapia'){
     this.itemcor  = Colors.green[900];
     this.appcor   = Colors.lightGreen[100];
     this.fundocor = Colors.white;
     this.applogo  = AssetImage('images/header_fisioterapia.png');
  }

  if(refProduto == 'Advocacia'){
     this.itemcor  = Colors.black;
     this.appcor   = Colors.amber[100];
     this.fundocor = Colors.white;
     this.applogo  = AssetImage('images/header_advocacia.png');
  }

}

  Color get getitemCor{
    return this.itemcor;
  }

  Color get getappCor{
    return this.appcor;
  }

  Color get getfundoCor{
    return this.fundocor;
  }

  AssetImage get getapplogotipo{
    return this.applogo;
  }
  
}

// classe responsavel por apresentar as features disponiveis de acordo com o firebase
class Tile{

  Tile(){

  }

}