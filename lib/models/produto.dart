// classe responsavel pelo gerenciamento de produtos da linha de produto

import 'dart:core';
import 'dart:core';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Produto{

int idProduto = 2;

String tokenUser;

Color appBarCor;
Color appCor;
Color iconCor;
Color textCor;
Color componentCor;
Color fundoCor;
Color decorationPrimaryColor;
Color decorationSecondaryColor;
Color decorationDateColor;

Color drawerdecorationSecondaryColor;
Color drawerdecorationPrimaryColor;
Color drawerheaderdecorationSecondaryColor;
Color drawerheaderdecorationPrimaryColor;


AssetImage appImage;
AssetImage appImageService;
// configurações dos caminhos do firebase
String url_produto;
String url_agendamento;
String url_servicos;
String url_funcionarios;
String url_clientes;
String url_empresas;
String url_notificacoes;
String url_config_features_cadastro; // possui a url responsavel pelo gerenciamento das features da lps como ativação e desativação 
static Color popup_color;
String profissional;
String servicoSelecionado;
String horarioSelecionado;
String dataSelecionada;
String url_data_agendamento;
String url_horario_agendamento;
//
String url_id_agendamento_cliente;

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

     this.drawerdecorationSecondaryColor = Colors.blue[100];
     this.drawerdecorationPrimaryColor = Colors.blue[50];
     this.drawerheaderdecorationSecondaryColor = Colors.blue[100];
     this.drawerheaderdecorationPrimaryColor = Colors.blue[50];



     this.decorationDateColor = Colors.blue;
     this.appImage = AssetImage("assets/images/header_advocacia.png");
     this.appImageService = AssetImage("assets/images/header_advocacia.png");
     //
     this.url_agendamento = "/Produtos/Advocacia/Lorem_IPSUM_Advocacia/cMj5CPKqvXibRbELeHwc/Agendamento";
     this.url_funcionarios = "/Produtos/Advocacia/Lorem_IPSUM_Advocacia/cMj5CPKqvXibRbELeHwc/Funcionarios";
     this.url_servicos = "/Produtos/Advocacia/Lorem_IPSUM_Advocacia/cMj5CPKqvXibRbELeHwc/Servicos";
     this.url_clientes = "/Produtos/Advocacia/Lorem_IPSUM_Advocacia/cMj5CPKqvXibRbELeHwc/Clientes";
     this.url_empresas = "/Produtos/Advocacia/Lorem_IPSUM_Advocacia/cMj5CPKqvXibRbELeHwc/Empresas";
     this.url_notificacoes = "/Produtos/Advocacia/Lorem_IPSUM_Advocacia/cMj5CPKqvXibRbELeHwc/Notificacoes";
     this.url_config_features_cadastro = "/Produtos/Advocacia/Lorem_IPSUM_Advocacia/Config/Features"; 
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

     this.drawerdecorationSecondaryColor = Colors.amber[400];
     this.drawerdecorationPrimaryColor = Colors.amber[100];
     this.drawerheaderdecorationSecondaryColor = Colors.amber[400];
     this.drawerheaderdecorationPrimaryColor = Colors.amber[100];



     this.decorationDateColor = Colors.amber;
     this.appImage = AssetImage('assets/images/header_estetica.png');
     this.appImageService = AssetImage('assets/images/service_header.png');
     //
     this.url_agendamento = "/Produtos/Estetica/Francielly_Estetica_Design/f4qVyClZ6etPxvpFwfmC/Agendamento_Sem_Cadastro";
     this.url_funcionarios = "/Produtos/Estetica/Francielly_Estetica_Design/f4qVyClZ6etPxvpFwfmC/Funcionarios";
     this.url_clientes = "/Produtos/Estetica/Francielly_Estetica_Design/f4qVyClZ6etPxvpFwfmC/Clientes";
     this.url_empresas = "/Produtos/Estetica/Francielly_Estetica_Design/f4qVyClZ6etPxvpFwfmC/Empresas";
     this.url_notificacoes = "/Produtos/Estetica/Francielly_Estetica_Design/f4qVyClZ6etPxvpFwfmC/Notificacoes";
     this.url_config_features_cadastro = "/Produtos/Estetica/Francielly_Estetica_Design/Config/Features";
     this.profissional = null;
     this.url_servicos = "/Produtos/Estetica";
     this.url_data_agendamento = "/Produtos/Estetica";
     this.url_horario_agendamento = "/Produtos/Estetica";

     this.url_id_agendamento_cliente = "/Produtos/Estetica/Francielly_Estetica_Design/f4qVyClZ6etPxvpFwfmC/Clientes/$tokenUser";
 
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

     this.drawerdecorationSecondaryColor = Colors.green[100];
     this.drawerdecorationPrimaryColor = Colors.white;
     this.drawerheaderdecorationSecondaryColor = Colors.green[100];
     this.drawerheaderdecorationPrimaryColor = Colors.white;




     this.decorationDateColor = Colors.green;
     this.appImage = AssetImage('assets/images/header_fisioterapia.png');
     this.appImageService = AssetImage('assets/images/header_fisioterapia.png');
     //
     this.url_agendamento = "/Produtos/Fisioterapia/Brisa_Melo_Fisioterapia/blMuzcfY4LfAO42j0OPD/Agendamento";
     this.url_funcionarios = "/Produtos/Fisioterapia/Brisa_Melo_Fisioterapia/blMuzcfY4LfAO42j0OPD/Funcionarios";
     this.url_servicos = "/Produtos/Fisioterapia/Brisa_Melo_Fisioterapia/blMuzcfY4LfAO42j0OPD/Servicos";
     this.url_clientes = "/Produtos/Fisioterapia/Brisa_Melo_Fisioterapia/blMuzcfY4LfAO42j0OPD/Clientes";
     this.url_empresas = "/Produtos/Fisioterapia/Brisa_Melo_Fisioterapia/blMuzcfY4LfAO42j0OPD/Empresas"; 
     this.url_notificacoes = "/Produtos/Fisioterapia/Brisa_Melo_Fisioterapia/blMuzcfY4LfAO42j0OPD/Notificacoes";
     this.url_config_features_cadastro = "/Produtos/Fisioterapia/Brisa_Melo_Fisioterapia/Config/Features";
     
  }


    if(idProduto == 4){
     popup_color = Colors.white;
     this.componentCor =  Colors.white;
     this.iconCor = Color.fromRGBO(215,143,111,5);
     this.textCor = Color.fromRGBO(215,143,111,5);

     this.appBarCor  = Colors.white;
     this.appCor   = Colors.white;
     this.fundoCor = Colors.white;
     this.decorationPrimaryColor   = Colors.green;
     this.decorationSecondaryColor = Colors.white;

     this.drawerdecorationSecondaryColor = Colors.white;
     this.drawerdecorationPrimaryColor = Colors.white;
     this.drawerheaderdecorationSecondaryColor = Color.fromRGBO(225,132,124,5);
     this.drawerheaderdecorationPrimaryColor = Colors.green;



     this.decorationDateColor = Color.fromRGBO(225,132,124,5);
     this.appImage = AssetImage('assets/images/header_terapeuta_corp.png');
     this.appImageService = AssetImage('assets/images/header_terapeuta_corp.png');
     //
     this.url_agendamento = "/Produtos/Estetica/Elenilza_Correia_Terapeuta_Corporal/Bmr1jVxZI5sMzcHdZRT3/Agendamento";
     this.url_funcionarios = "/Produtos/Estetica/Elenilza_Correia_Terapeuta_Corporal/Bmr1jVxZI5sMzcHdZRT3/Funcionarios";
     this.url_servicos = "/Produtos/Estetica/Elenilza_Correia_Terapeuta_Corporal/Bmr1jVxZI5sMzcHdZRT3/Servicos";
     this.url_config_features_cadastro = "/Produtos/Estetica/Elenilza_Correia_Terapeuta_Corporal/Config/Features";
  }


}
  // recebe o id do produto 
  Future<void> setProduto(int id ) async {
    this.idProduto = id;
  }

  Color get getDrawerDecorationSecondaryColor{
    return this.drawerdecorationSecondaryColor;
  }
  Color get getDrawerDecorationPrimaryColor{
    return this.drawerdecorationPrimaryColor;
  }
  Color get getDrawerHeaderPrimaryColor{
    return this.drawerheaderdecorationPrimaryColor;
  }
  Color get getDrawerHeaderSecondaryColor{
    return this.drawerheaderdecorationSecondaryColor;
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

  String get getUrlEmpresas{
    return this.url_empresas;
  }

  String get getUrlConfigFeatureCadastro{
    return this.url_config_features_cadastro;
  }

  String get getUrlIdAgendamentoCliente{
    return this.url_id_agendamento_cliente;
  }

  String get getUrlDataAgendamento{
    return this.url_data_agendamento;
  }

  // metodos responsaveis pelo gerenciamento de serviços, datas de agendamento
  String get getProfissionalSelecionado{
    return this.profissional;
  }

  String get getServicoSelecionado{
    return this.servicoSelecionado;
  }
  
  String get getDataSelecionada{
    return this.dataSelecionada;
  }

  String get getUrlHorarioAgendamento{
    return this.url_horario_agendamento;
  }

  void setProfissionalServicoUrl(String p) {
    if(this.idProduto == 2) { // estetica
      this.profissional = p;
      this.url_servicos = "/Produtos/Estetica/Francielly_Estetica_Design/f4qVyClZ6etPxvpFwfmC/Funcionarios/$profissional/Servicos"; 
      this.url_data_agendamento = "/Produtos/Estetica/Francielly_Estetica_Design/f4qVyClZ6etPxvpFwfmC/Funcionarios/$profissional/Data";  
      this.url_horario_agendamento = "/Produtos/Estetica/Francielly_Estetica_Design/f4qVyClZ6etPxvpFwfmC/Funcionarios/$profissional/Horario";
    }
  }


 void setAgendamentoCliente(String token) {
    if(this.idProduto == 2) { // estetica
      this.url_id_agendamento_cliente = "/Produtos/Estetica/Francielly_Estetica_Design/f4qVyClZ6etPxvpFwfmC/Clientes"; 
    }
  }

  Future<void> setServico(String s)async {
    this.servicoSelecionado = s;
  }

  Future<void> setDataSelecionada(String d)async {
    this.dataSelecionada = d;
  }

  Future<void> setHorarioSelecionado(String h)async {
    this.horarioSelecionado = h;
  }

}

// classe responsavel por apresentar as features disponiveis de acordo com o firebase

  