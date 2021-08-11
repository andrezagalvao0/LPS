// classe responsavel pelo gerenciamento de produtos da linha de produto

import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Produto{

int idProduto = 2;
Color appBarCor;
Color appCor;
Color iconCor;
Color textCor;
Color componentCor;
Color fundoCor;
Color decorationPrimaryColor;
Color decorationSecondaryColor;
Color decorationDateColor;
AssetImage appImage;
AssetImage appImageService;
// configurações dos caminhos do firebase
String url_produto;
String url_agendamento;
String url_servicos;
String url_funcionarios;
String url_clientes;
static Color popup_color;


//

// recebe uma identificação sobre qual esquema de aparencia sera exibida de acordo com o resultado enviado pelo firebase

// 1 - Advocacia
// 2 - Estetica
// 3 - Fisioterapia

Produto(){

    if(idProduto == 1){
     
     popup_color = Colors.blue;
     this.componentCor =  Colors.blue[50];
     this.iconCor = Colors.blue[800]; 
     this.textCor = Colors.blue[800];
     this.appBarCor  = Colors.blue[800];
     this.appCor   = Colors.blue[800];
     this.fundoCor = Colors.white;
     this.decorationPrimaryColor   = Colors.blue[50];
     this.decorationSecondaryColor = Colors.blue[100];
     this.decorationDateColor = Colors.blue;
     this.appImage = AssetImage("assets/images/header_advocacia.png");
     this.appImageService = AssetImage("assets/images/header_advocacia.png");
     //
     this.url_agendamento = "/Produtos/Advocacia/Lorem_IPSUM_Advocacia/cMj5CPKqvXibRbELeHwc/Agendamento";
     this.url_funcionarios = "/Produtos/Advocacia/Lorem_IPSUM_Advocacia/cMj5CPKqvXibRbELeHwc/Funcionarios";
     this.url_servicos = "/Produtos/Advocacia/Lorem_IPSUM_Advocacia/cMj5CPKqvXibRbELeHwc/Servicos";
     this.url_clientes = "/Produtos/Advocacia/Lorem_IPSUM_Advocacia/cMj5CPKqvXibRbELeHwc/Clientes";
  }

  if(idProduto == 2){
     popup_color = Colors.amber;
     this.componentCor =  Colors.amberAccent;
     this.iconCor = Colors.black; 
     this.textCor = Colors.black;
     this.appBarCor  = Colors.amberAccent;
     this.appCor   = Colors.amberAccent;
     this.fundoCor = Colors.white;
     this.decorationPrimaryColor   = Colors.amber[100];
     this.decorationSecondaryColor = Colors.amber[400];
     this.decorationDateColor = Colors.amber;
     this.appImage = AssetImage('assets/images/header_estetica.png');
     this.appImageService = AssetImage('assets/images/service_header.png');
     //
     this.url_agendamento = "/Produtos/Estetica/Francielly_Estetica_Design/f4qVyClZ6etPxvpFwfmC/Agendamento";
     this.url_funcionarios = "/Produtos/Estetica/Francielly_Estetica_Design/f4qVyClZ6etPxvpFwfmC/Funcionarios";
     this.url_servicos = "/Produtos/Estetica/Francielly_Estetica_Design/f4qVyClZ6etPxvpFwfmC/Servicos";

  }

    if(idProduto == 3){
     popup_color = Colors.green;
     this.componentCor =  Colors.white;
     this.iconCor = Colors.green[800]; 
     this.textCor = Colors.green[800];
     this.appBarCor  = Colors.green[800];
     this.appCor   = Colors.green;
     this.fundoCor = Colors.white;
     this.decorationPrimaryColor   = Colors.white;
     this.decorationSecondaryColor = Colors.green[100];
     this.decorationDateColor = Colors.green;
     this.appImage = AssetImage('assets/images/header_fisioterapia.png');
     this.appImageService = AssetImage('assets/images/header_fisioterapia.png');
     //
     this.url_agendamento = "/Produtos/Fisioterapia/Brisa_Melo_Fisioterapia/blMuzcfY4LfAO42j0OPD/Agendamento";
     this.url_funcionarios = "/Produtos/Fisioterapia/Brisa_Melo_Fisioterapia/blMuzcfY4LfAO42j0OPD/Funcionarios";
     this.url_servicos = "/Produtos/Fisioterapia/Brisa_Melo_Fisioterapia/blMuzcfY4LfAO42j0OPD/Servicos";
  }


}
  // recebe o id do produto 
  Future<void> setProduto(int id ) async {
    this.idProduto = id;
  }

 
  Color get getPrimaryCor{
    return this.decorationPrimaryColor;
  }

  Color get getPopUpCor{
    return popup_color;
  }

  Color get getSecondaryCor{
    return this.decorationSecondaryColor;
  }

  Color get getComponentCor{
    return this.componentCor;
  }

  Color get getAppCor{
    return this.appCor;
  }

  Color get getFundoCor{
    return this.fundoCor;
  }

  Color get getIconCor{
    return this.iconCor;
  }

  Color get getTextCor{
    return this.textCor;
  }

  Color get getAppBarCor{
    return this.appBarCor;
  }
  
  Color get getAppDateColor{
    this.decorationDateColor;
  }

  AssetImage get getAppImage{
    return this.appImage;
  }

  AssetImage get getAppImageService{
    return this.appImageService;
  }

  String get getUrlAgendamento{
    return this.url_agendamento;
  }

  String get getUrlServicos{
    return this.url_servicos;
  }

  String get getUrlFuncionarios{
    return this.url_funcionarios;
  }
  
  String get getUrlClientes{
    return this.url_clientes;
  }
  
}

// classe responsavel por apresentar as features disponiveis de acordo com o firebase

  