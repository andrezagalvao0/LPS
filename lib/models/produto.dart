// classe responsavel pelo gerenciamento de produtos da linha de produto

import 'dart:core';
import 'dart:core';
import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:lps_ufs_tcc/controller/notifiConfig.dart';
import 'package:lps_ufs_tcc/views/agendamento.dart';
import 'package:lps_ufs_tcc/views/cadastro.dart';
import 'package:lps_ufs_tcc/views/cadastro_cliente.dart';
import 'package:lps_ufs_tcc/views/cadastro_empresa.dart';
import 'package:lps_ufs_tcc/views/cadastro_profissional.dart';
import 'package:lps_ufs_tcc/views/empreendedor_menu.dart';
import 'package:lps_ufs_tcc/views/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'notificacoes.dart';

class Produto{

String produto_selecionado;
int idProduto = 2;
String tokenUser;
SharedPreferences dadosUtilizador;
AssetImage thumbnail_servico;
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

String status_agendamento;
String id_dispositivo;

//
String url_id_cliente;
String url_id_agendamento_cliente;
String url_usuarios;
String url_config_features; // fornece o endereco das features utilizadas no produto podendo desabilita-los e habilita-los
// recebe uma identificação sobre qual esquema de aparencia sera exibida de acordo com o resultado enviado pelo firebase
String url_empreendedor_agendamentos_clientes; // url responsavel por armazenar todos os agendamentos realizados pelos clientes 
                         // podendo somente ser utilizado pelo empreendedor ADM 


// 1 - Advocacia
// 2 - Estetica
// 3 - Fisioterapia


NotificationService nsm;
ConfigNotification cfgNotifi;

   //  nsm.showNotifications(ConfigNotification(
   //    id: item["ID"],
   //    titulo: "Confirmação de Agendamento",
   //    body: "Ola! "+item["Nome"]+" Seu agendamento foi confirmado com Sucesso, compareça ao local agendado",
   //    payload: null,
   //  ));



// ignore: non_constant_identifier_names
Produto.CriarProduto(String nomeProduto){ // construtor nomeado
    this.nsm = new NotificationService();
    

     // identificação do produto com suas caracteristicas individuais de UX     
    if(nomeProduto == "Advocacia"){
     this.idProduto = 1;
     this.produto_selecionado = "Advocacia";
     popup_color = Colors.blue;
     this.status_agendamento = "Aguardando";
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
     this.url_agendamento = "/Produtos/Advocacia/Lorem_IPSUM_Advocacia/cMj5CPKqvXibRbELeHwc/Empreendedor/Todos_os_Agendamentos/Agendados_sem_Cadastro";
     this.url_funcionarios = "/Produtos/Advocacia/Lorem_IPSUM_Advocacia/cMj5CPKqvXibRbELeHwc/Funcionarios";
     this.url_servicos = "/Produtos/Advocacia/Lorem_IPSUM_Advocacia/cMj5CPKqvXibRbELeHwc/Servicos";
     this.url_clientes = "/Produtos/Advocacia/Lorem_IPSUM_Advocacia/cMj5CPKqvXibRbELeHwc/Clientes";
     this.url_empresas = "/Produtos/Advocacia/Lorem_IPSUM_Advocacia/cMj5CPKqvXibRbELeHwc/Empresas";
     this.url_notificacoes = "/Produtos/Advocacia/Lorem_IPSUM_Advocacia/cMj5CPKqvXibRbELeHwc/Notificacoes";
     this.url_config_features_cadastro = "/Produtos/Advocacia/Lorem_IPSUM_Advocacia/Config/Features";
     //
     this.profissional = null;
     this.url_servicos = "/Produtos/Advocacia";
     this.url_data_agendamento = "/Produtos/Advocacia";
     this.url_horario_agendamento = "/Produtos/Advocacia";
     this.url_id_agendamento_cliente = "/Produtos/Advocacia/Lorem_IPSUM_Advocacia/cMj5CPKqvXibRbELeHwc/Clientes";
     this.url_config_features = "/Produtos/Advocacia/Lorem_IPSUM_Advocacia/Config/Features";
     this.url_empreendedor_agendamentos_clientes = "/Produtos/Advocacia/Lorem_IPSUM_Advocacia/cMj5CPKqvXibRbELeHwc/Empreendedor/Todos_os_Agendamentos/Agendados_por_Clientes";
     }

    if(nomeProduto == "Estetica e Design"){
     this.idProduto = 2;
     this.produto_selecionado = "Estetica e Design";
     popup_color = Colors.amber;
     this.status_agendamento = "Aguardando";
     this.id_dispositivo = "";
     this.componentCor =  Colors.amberAccent;
     this.iconCor = Colors.black; 
     this.textCor = Colors.black;
     this.appBarCor  = Colors.amberAccent;
     this.appCor   = Colors.amberAccent;
     this.fundoCor = Colors.white;
     this.decorationPrimaryColor   = Colors.amber[100];
     this.decorationSecondaryColor = Colors.amber[400];
     this.drawerdecorationSecondaryColor = Color(0xFFf48f0e);
     this.drawerdecorationPrimaryColor = Colors.amber[100];
     this.drawerheaderdecorationSecondaryColor = Color(0xFFf48f0e); //fd5304
     this.drawerheaderdecorationPrimaryColor = Colors.amber[100];

     this.decorationDateColor = Colors.amber;
     this.appImage = AssetImage('assets/images/header_estetica.png');
     this.appImageService = AssetImage('assets/images/header_estetica.png');
     //
     this.url_agendamento = "/Produtos/Estetica/Francielly_Estetica_Design/f4qVyClZ6etPxvpFwfmC/Empreendedor/Todos_os_Agendamentos/Agendamento_sem_Cadastro";
     this.url_funcionarios = "/Produtos/Estetica/Francielly_Estetica_Design/f4qVyClZ6etPxvpFwfmC/Funcionarios";
     this.url_clientes = "/Produtos/Estetica/Francielly_Estetica_Design/f4qVyClZ6etPxvpFwfmC/Clientes";
     this.url_empresas = "/Produtos/Estetica/Francielly_Estetica_Design/f4qVyClZ6etPxvpFwfmC/Empresas";
     this.url_notificacoes = "/Produtos/Estetica/Francielly_Estetica_Design/f4qVyClZ6etPxvpFwfmC/Notificacoes";
     this.url_config_features_cadastro = "/Produtos/Estetica/Francielly_Estetica_Design/Config/Features";
     this.profissional = null;
     this.url_servicos = "/Produtos/Estetica";
     this.url_data_agendamento = "/Produtos/Estetica";
     this.url_horario_agendamento = "/Produtos/Estetica";
     this.url_id_agendamento_cliente = "/Produtos/Estetica/Francielly_Estetica_Design/f4qVyClZ6etPxvpFwfmC/Clientes";
     this.url_config_features = "/Produtos/Estetica/Francielly_Estetica_Design/Config/Features";
     this.url_empreendedor_agendamentos_clientes = "/Produtos/Estetica/Francielly_Estetica_Design/f4qVyClZ6etPxvpFwfmC/Empreendedor/Todos_os_Agendamentos/Agendados_por_Clientes";
     }

    if(nomeProduto == "Fisioterapia"){
     this.idProduto = 3;
     this.produto_selecionado = "Fisioterapia";
     popup_color = Colors.green;
     this.status_agendamento = "Aguardando";
     this.id_dispositivo = "";
     this.componentCor =  Colors.white;
     this.iconCor = Color(0xFF575b48);
     this.textCor = Color(0xFF575b48);
     this.appBarCor  = Colors.green[800];
     this.appCor   = Colors.green;
     this.fundoCor = Colors.white;
     this.decorationPrimaryColor   = Colors.white;
     this.decorationSecondaryColor = Color(0xFFcdf266);
     this.drawerdecorationSecondaryColor = Colors.green[100];
     this.drawerdecorationPrimaryColor = Colors.white;
     this.drawerheaderdecorationSecondaryColor = Colors.green[100];
     this.drawerheaderdecorationPrimaryColor = Colors.white;
     this.decorationDateColor = Colors.green;
     this.appImage = AssetImage('assets/images/header_fisioterapia.png');
     this.appImageService = AssetImage('assets/images/header_fisioterapia.png');
     //
     this.url_agendamento = "/Produtos/Fisioterapia/Brisa_Melo_Fisioterapia/blMuzcfY4LfAO42j0OPD/Empreendedor/Todos_os_Agendamentos/Agendados_sem_Cadastro";
     this.url_funcionarios = "/Produtos/Fisioterapia/Brisa_Melo_Fisioterapia/blMuzcfY4LfAO42j0OPD/Funcionarios";
     this.url_servicos = "/Produtos/Fisioterapia/Brisa_Melo_Fisioterapia/blMuzcfY4LfAO42j0OPD/Servicos";
     this.url_clientes = "/Produtos/Fisioterapia/Brisa_Melo_Fisioterapia/blMuzcfY4LfAO42j0OPD/Clientes";
     this.url_empresas = "/Produtos/Fisioterapia/Brisa_Melo_Fisioterapia/blMuzcfY4LfAO42j0OPD/Empresas"; 
     this.url_notificacoes = "/Produtos/Fisioterapia/Brisa_Melo_Fisioterapia/blMuzcfY4LfAO42j0OPD/Notificacoes";
     this.url_config_features_cadastro = "/Produtos/Fisioterapia/Brisa_Melo_Fisioterapia/Config/Features";
     this.profissional = null;
     this.url_servicos = "/Produtos/Fisioterapia";
     this.url_data_agendamento = "/Produtos/Fisioterapia";
     this.url_horario_agendamento = "/Produtos/Fisioterapia";
     this.url_id_agendamento_cliente = "/Produtos/Fisioterapia/Brisa_Melo_Fisioterapia/blMuzcfY4LfAO42j0OPD/Clientes";
     this.url_config_features = "/Produtos/Fisioterapia/Brisa_Melo_Fisioterapia/Config/Features";
     this.url_empreendedor_agendamentos_clientes = "/Produtos/Fisioterapia/Brisa_Melo_Fisioterapia/blMuzcfY4LfAO42j0OPD/Empreendedor/Todos_os_Agendamentos/Agendados_por_Clientes";
     }

    if(nomeProduto == "Terapeuta Corporal"){
     this.idProduto = 4;
     this.produto_selecionado = "Terapeuta Corporal";
     popup_color = Colors.pink;
     this.status_agendamento = "Aguardando";
     this.id_dispositivo = "";
     this.componentCor =  Color(0xFFe2827c);
     this.iconCor = Color(0xFF2c63a0);
     this.textCor = Color(0xFF2c63a0);
     this.appBarCor  = Color(0xFFf9bbd0);
     this.appCor   = Color(0xFFf9bbd0);
     this.fundoCor = Colors.white;
     this.decorationPrimaryColor   = Color(0xFFe2827c);
     this.decorationSecondaryColor = Color(0xFFe2827c);
     this.drawerdecorationSecondaryColor = Color(0xFFf9bbd0);
     this.drawerdecorationPrimaryColor = Color(0xFFe2827c);
     this.drawerheaderdecorationSecondaryColor = Color(0xFFf9bbd0);//Colors.pink;
     this.drawerheaderdecorationPrimaryColor =  Color(0xFFe2827c);
     this.decorationDateColor = Colors.white;
     this.appImage = AssetImage('assets/images/header_terapeuta_corp.png');
     this.appImageService = AssetImage('assets/images/header_terapeuta_corp.png');
     //
     this.url_agendamento = "/Produtos/Estetica/Elenilza_Correia_Terapeuta_Corporal/Bmr1jVxZI5sMzcHdZRT3/Empreendedor/Todos_os_Agendamentos/Agendados_sem_Cadastro";
     this.url_funcionarios = "/Produtos/Estetica/Elenilza_Correia_Terapeuta_Corporal/Bmr1jVxZI5sMzcHdZRT3/Funcionarios";
     this.url_clientes = "/Produtos/Estetica/Elenilza_Correia_Terapeuta_Corporal/Bmr1jVxZI5sMzcHdZRT3/Clientes";
     this.url_empresas = "/Produtos/Estetica/Elenilza_Correia_Terapeuta_Corporal/Bmr1jVxZI5sMzcHdZRT3/Empresas";
     this.url_notificacoes = "/Produtos/Estetica/Elenilza_Correia_Terapeuta_Corporal/Bmr1jVxZI5sMzcHdZRT3/Notificacoes";
     this.url_config_features_cadastro = "/Produtos/Estetica/Elenilza_Correia_Terapeuta_Corporal/Config/Features";
     this.profissional = null;
     this.url_servicos = "/Produtos/Estetica";
     this.url_data_agendamento = "/Produtos/Estetica";
     this.url_horario_agendamento = "/Produtos/Estetica";
     this.url_id_agendamento_cliente = "/Produtos/Estetica/Elenilza_Correia_Terapeuta_Corporal/Bmr1jVxZI5sMzcHdZRT3/Clientes";
     this.url_config_features = "/Produtos/Estetica/Elenilza_Correia_Terapeuta_Corporal/Config/Features";
     this.url_empreendedor_agendamentos_clientes = "/Produtos/Estetica/Elenilza_Correia_Terapeuta_Corporal/Bmr1jVxZI5sMzcHdZRT3/Empreendedor/Todos_os_Agendamentos/Agendados_por_Clientes";
    }

    if(nomeProduto == "Barbearia"){
     this.produto_selecionado = "Barbearia";
     this.idProduto = 5;
     popup_color = Colors.amber;
     this.status_agendamento = "Aguardando";
     this.id_dispositivo = "";
     this.componentCor =  Colors.black;
     this.iconCor = Color(0xFFf5c139);
     this.textCor = Color(0xFFf5c139);
     this.appBarCor  = Colors.black;
     this.appCor   = Colors.black;
     this.fundoCor = Colors.white;
     this.decorationPrimaryColor   = Colors.black;
     this.decorationSecondaryColor = Colors.black;
     this.drawerdecorationSecondaryColor = Colors.black;
     this.drawerdecorationPrimaryColor = Colors.black;
     this.drawerheaderdecorationSecondaryColor = Colors.black;//Colors.pink;
     this.drawerheaderdecorationPrimaryColor =  Colors.black;
     this.decorationDateColor = Colors.black;
     this.appImage = AssetImage('assets/images/header_barbearia.png');
     this.appImageService = AssetImage('assets/images/header_barbearia.png');
     //
     this.url_agendamento = "/Produtos/Barbearia/Legiao_Barber/oRWbtoONmi1XjUVgHiJC/Empreendedor/Todos_os_Agendamentos/Agendados_sem_Cadastro";
     this.url_funcionarios = "/Produtos/Barbearia/Legiao_Barber/oRWbtoONmi1XjUVgHiJC/Funcionarios";
     this.url_clientes = "/Produtos/Barbearia/Legiao_Barber/oRWbtoONmi1XjUVgHiJC/Clientes";
     this.url_empresas = "/Produtos/Barbearia/Legiao_Barber/oRWbtoONmi1XjUVgHiJC/Empresas";
     this.url_notificacoes = "/Produtos/Barbearia/Legiao_Barber/oRWbtoONmi1XjUVgHiJC/Notificacoes";
     this.url_config_features_cadastro = "/Produtos/Barbearia/Legiao_Barber/Config/Features";
     this.profissional = null;
     this.url_servicos = "/Produtos/Barbearia";
     this.url_data_agendamento = "/Produtos/Barbearia";
     this.url_horario_agendamento = "/Produtos/Barbearia";
     this.url_id_agendamento_cliente = "/Produtos/Barbearia/Legiao_Barber/oRWbtoONmi1XjUVgHiJC/Clientes";
     this.url_config_features = "/Produtos/Barbearia/Legiao_Barber/Config/Features";
     this.url_empreendedor_agendamentos_clientes = "/Produtos/Barbearia/Legiao_Barber/oRWbtoONmi1XjUVgHiJC/Empreendedor/Todos_os_Agendamentos/Agendados_por_Clientes";
    }

}

Produto(){
     
     this.nsm = new NotificationService();

  
     if(this.idProduto == 1){
     this.produto_selecionado = "Advocacia";
     popup_color = Colors.blue;
     this.status_agendamento = "Aguardando";
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
     this.url_agendamento = "/Produtos/Advocacia/Lorem_IPSUM_Advocacia/cMj5CPKqvXibRbELeHwc/Empreendedor/Todos_os_Agendamentos/Agendados_sem_Cadastro";
     this.url_funcionarios = "/Produtos/Advocacia/Lorem_IPSUM_Advocacia/cMj5CPKqvXibRbELeHwc/Funcionarios";
     this.url_servicos = "/Produtos/Advocacia/Lorem_IPSUM_Advocacia/cMj5CPKqvXibRbELeHwc/Servicos";
     this.url_clientes = "/Produtos/Advocacia/Lorem_IPSUM_Advocacia/cMj5CPKqvXibRbELeHwc/Clientes";
     this.url_empresas = "/Produtos/Advocacia/Lorem_IPSUM_Advocacia/cMj5CPKqvXibRbELeHwc/Empresas";
     this.url_notificacoes = "/Produtos/Advocacia/Lorem_IPSUM_Advocacia/cMj5CPKqvXibRbELeHwc/Notificacoes";
     this.url_config_features_cadastro = "/Produtos/Advocacia/Lorem_IPSUM_Advocacia/Config/Features";
     //
     this.profissional = null;
     this.url_servicos = "/Produtos/Advocacia";
     this.url_data_agendamento = "/Produtos/Advocacia";
     this.url_horario_agendamento = "/Produtos/Advocacia";
     this.url_id_agendamento_cliente = "/Produtos/Advocacia/Lorem_IPSUM_Advocacia/cMj5CPKqvXibRbELeHwc/Clientes";
     this.url_config_features = "/Produtos/Advocacia/Lorem_IPSUM_Advocacia/Config/Features";
     this.url_empreendedor_agendamentos_clientes = "/Produtos/Advocacia/Lorem_IPSUM_Advocacia/cMj5CPKqvXibRbELeHwc/Empreendedor/Todos_os_Agendamentos/Agendados_por_Clientes";
     }
  

     if(this.idProduto == 2){
     this.produto_selecionado = "Estetica e Design";
     popup_color = Colors.amber;
     this.status_agendamento = "Aguardando";
     this.id_dispositivo = "";
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
     this.url_agendamento = "/Produtos/Estetica/Francielly_Estetica_Design/f4qVyClZ6etPxvpFwfmC/Empreendedor/Todos_os_Agendamentos/Agendamento_sem_Cadastro";
     this.url_funcionarios = "/Produtos/Estetica/Francielly_Estetica_Design/f4qVyClZ6etPxvpFwfmC/Funcionarios";
     this.url_clientes = "/Produtos/Estetica/Francielly_Estetica_Design/f4qVyClZ6etPxvpFwfmC/Clientes";
     this.url_empresas = "/Produtos/Estetica/Francielly_Estetica_Design/f4qVyClZ6etPxvpFwfmC/Empresas";
     this.url_notificacoes = "/Produtos/Estetica/Francielly_Estetica_Design/f4qVyClZ6etPxvpFwfmC/Notificacoes";
     this.url_config_features_cadastro = "/Produtos/Estetica/Francielly_Estetica_Design/Config/Features";
     this.profissional = null;
     this.url_servicos = "/Produtos/Estetica";
     this.url_data_agendamento = "/Produtos/Estetica";
     this.url_horario_agendamento = "/Produtos/Estetica";
     this.url_id_agendamento_cliente = "/Produtos/Estetica/Francielly_Estetica_Design/f4qVyClZ6etPxvpFwfmC/Clientes";
     this.url_config_features = "/Produtos/Estetica/Francielly_Estetica_Design/Config/Features";
     this.url_empreendedor_agendamentos_clientes = "/Produtos/Estetica/Francielly_Estetica_Design/f4qVyClZ6etPxvpFwfmC/Empreendedor/Todos_os_Agendamentos/Agendados_por_Clientes"; 
     }

         
     if(this.idProduto == 3){
     this.produto_selecionado = "Fisioterapia";
     popup_color = Colors.green;
     this.status_agendamento = "Aguardando";
     this.id_dispositivo = "";
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
     this.url_agendamento = "/Produtos/Fisioterapia/Brisa_Melo_Fisioterapia/blMuzcfY4LfAO42j0OPD/Empreendedor/Todos_os_Agendamentos/Agendados_sem_Cadastro";
     this.url_funcionarios = "/Produtos/Fisioterapia/Brisa_Melo_Fisioterapia/blMuzcfY4LfAO42j0OPD/Funcionarios";
     this.url_servicos = "/Produtos/Fisioterapia/Brisa_Melo_Fisioterapia/blMuzcfY4LfAO42j0OPD/Servicos";
     this.url_clientes = "/Produtos/Fisioterapia/Brisa_Melo_Fisioterapia/blMuzcfY4LfAO42j0OPD/Clientes";
     this.url_empresas = "/Produtos/Fisioterapia/Brisa_Melo_Fisioterapia/blMuzcfY4LfAO42j0OPD/Empresas"; 
     this.url_notificacoes = "/Produtos/Fisioterapia/Brisa_Melo_Fisioterapia/blMuzcfY4LfAO42j0OPD/Notificacoes";
     this.url_config_features_cadastro = "/Produtos/Fisioterapia/Brisa_Melo_Fisioterapia/Config/Features";
     this.profissional = null;
     this.url_servicos = "/Produtos/Fisioterapia";
     this.url_data_agendamento = "/Produtos/Fisioterapia";
     this.url_horario_agendamento = "/Produtos/Fisioterapia";
     this.url_id_agendamento_cliente = "/Produtos/Fisioterapia/Brisa_Melo_Fisioterapia/blMuzcfY4LfAO42j0OPD/Clientes";
     this.url_config_features = "/Produtos/Fisioterapia/Brisa_Melo_Fisioterapia/Config/Features";
     this.url_empreendedor_agendamentos_clientes = "/Produtos/Fisioterapia/Brisa_Melo_Fisioterapia/blMuzcfY4LfAO42j0OPD/Empreendedor/Todos_os_Agendamentos/Agendados_por_Clientes";
    }

     
     if(this.idProduto == 4){  
     this.produto_selecionado = "Terapeuta Corporal";
     popup_color = Colors.white;
     this.status_agendamento = "Aguardando";
     this.id_dispositivo = "";
     this.componentCor =  Color.fromRGBO(225,132,124,5);
     this.iconCor = Colors.white;
     this.textCor = Colors.white;
     this.appBarCor  = Color.fromRGBO(225,132,124,5);
     this.appCor   = Colors.white;
     this.fundoCor = Color.fromRGBO(225,132,124,5);
     this.decorationPrimaryColor   = Color.fromRGBO(225,132,124,5);
     this.decorationSecondaryColor = Color.fromRGBO(225,132,124,5);
     this.drawerdecorationSecondaryColor = Color.fromRGBO(225,132,124,5);
     this.drawerdecorationPrimaryColor = Color.fromRGBO(225,132,124,5);
     this.drawerheaderdecorationSecondaryColor = Color.fromRGBO(225,132,124,5);//Colors.pink;
     this.drawerheaderdecorationPrimaryColor =  Color.fromRGBO(225,132,124,5);
     this.decorationDateColor = Colors.white;
     this.appImage = AssetImage('assets/images/header_terapeuta_corp.png');
     this.appImageService = AssetImage('assets/images/header_terapeuta_corp.png');
     //
     this.url_agendamento = "/Produtos/Estetica/Elenilza_Correia_Terapeuta_Corporal/Bmr1jVxZI5sMzcHdZRT3/Empreendedor/Todos_os_Agendamentos/Agendados_sem_Cadastro";
     this.url_funcionarios = "/Produtos/Estetica/Elenilza_Correia_Terapeuta_Corporal/Bmr1jVxZI5sMzcHdZRT3/Funcionarios";
     this.url_clientes = "/Produtos/Estetica/Elenilza_Correia_Terapeuta_Corporal/Bmr1jVxZI5sMzcHdZRT3/Clientes";
     this.url_empresas = "/Produtos/Estetica/Elenilza_Correia_Terapeuta_Corporal/Bmr1jVxZI5sMzcHdZRT3/Empresas";
     this.url_notificacoes = "/Produtos/Estetica/Elenilza_Correia_Terapeuta_Corporal/Bmr1jVxZI5sMzcHdZRT3/Notificacoes";
     this.url_config_features_cadastro = "/Produtos/Estetica/Elenilza_Correia_Terapeuta_Corporal/Config/Features";
     this.profissional = null;
     this.url_servicos = "/Produtos/Estetica";
     this.url_data_agendamento = "/Produtos/Estetica";
     this.url_horario_agendamento = "/Produtos/Estetica";
     this.url_id_agendamento_cliente = "/Produtos/Estetica/Elenilza_Correia_Terapeuta_Corporal/Bmr1jVxZI5sMzcHdZRT3/Clientes";
     this.url_config_features = "/Produtos/Estetica/Elenilza_Correia_Terapeuta_Corporal/Config/Features";
     this.url_empreendedor_agendamentos_clientes = "/Produtos/Estetica/Elenilza_Correia_Terapeuta_Corporal/Bmr1jVxZI5sMzcHdZRT3/Empreendedor/Todos_os_Agendamentos/Agendados_por_Clientes";
  }

   
     if(this.idProduto == 5){
     this.produto_selecionado = "Barbearia";
     popup_color = Colors.white;
     this.status_agendamento = "Aguardando";
     this.id_dispositivo = "";
     this.componentCor =  Colors.black;
     this.iconCor = Colors.white;
     this.textCor = Colors.white;
     this.appBarCor  = Colors.black;
     this.appCor   = Colors.black;
     this.fundoCor = Colors.white;
     this.decorationPrimaryColor   = Colors.black;
     this.decorationSecondaryColor = Colors.black;
     this.drawerdecorationSecondaryColor = Colors.black;
     this.drawerdecorationPrimaryColor = Colors.black;
     this.drawerheaderdecorationSecondaryColor = Colors.black;//Colors.pink;
     this.drawerheaderdecorationPrimaryColor =  Colors.black;
     this.decorationDateColor = Colors.white;
     this.appImage = AssetImage('assets/images/header_barbearia.png');
     this.appImageService = AssetImage('assets/images/header_barbearia.png');
     //
     this.url_agendamento = "/Produtos/Barbearia/Legiao_Barber/oRWbtoONmi1XjUVgHiJC/Empreendedor/Todos_os_Agendamentos/Agendados_sem_Cadastro";
     this.url_funcionarios = "/Produtos/Barbearia/Legiao_Barber/oRWbtoONmi1XjUVgHiJC/Funcionarios";
     this.url_clientes = "/Produtos/Barbearia/Legiao_Barber/oRWbtoONmi1XjUVgHiJC/Clientes";
     this.url_empresas = "/Produtos/Barbearia/Legiao_Barber/oRWbtoONmi1XjUVgHiJC/Empresas";
     this.url_notificacoes = "/Produtos/Barbearia/Legiao_Barber/oRWbtoONmi1XjUVgHiJC/Notificacoes";
     this.url_config_features_cadastro = "/Produtos/Barbearia/Legiao_Barber/Config/Features";
     this.profissional = null;
     this.url_servicos = "/Produtos/Barbearia";
     this.url_data_agendamento = "/Produtos/Barbearia";
     this.url_horario_agendamento = "/Produtos/Barbearia";
     this.url_id_agendamento_cliente = "/Produtos/Barbearia/Legiao_Barber/oRWbtoONmi1XjUVgHiJC/Clientes";
     this.url_config_features = "/Produtos/Barbearia/Legiao_Barber/Config/Features";
     this.url_empreendedor_agendamentos_clientes = "/Produtos/Barbearia/Legiao_Barber/oRWbtoONmi1XjUVgHiJC/Empreendedor/Todos_os_Agendamentos/Agendados_por_Clientes";
  }


}


 
  // recebe o id do produto 
  String get getUrlConfigFeatures{
    return this.url_config_features;
  }

  // recebe o nome do produto
  String get getProdutoSelecionado{
    return this.produto_selecionado;
  }

  String get getIdDispositivo{
    return this.id_dispositivo;
  }

  String get getStatusAgendamento{
    return this.status_agendamento;
  }

  get i => null;

  void setIdDispositivo(String id){
    this.id_dispositivo = id;
  }

  void setProduto(String produto){
    if(produto == 'Advocacia'){
      this.url_config_features = "/Produtos/Advocacia/Lorem_IPSUM_Advocacia/Config/Features";
      this.idProduto = 1;
      this.produto_selecionado = produto;
    }
    if(produto == 'Estetica e Design'){
       this.url_config_features = "/Produtos/Estetica/Francielly_Estetica_Design/Config/Features";
       this.idProduto = 2;
       this.produto_selecionado = produto;
    }
    if(produto == 'Fisioterapia'){
       this.url_config_features = "/Produtos/Fisioterapia/Brisa_Melo_Fisioterapia/Config/Features";
       this.idProduto = 3;
       this.produto_selecionado = produto;
    }
    if(produto == 'Terapeuta Corporal'){
       this.url_config_features = "/Produtos/Estetica/Elenilza_Correia_Terapeuta_Corporal/Config/Features";
       this.idProduto = 4;
       this.produto_selecionado = produto;
    }
    if(produto == 'Barbearia'){
       this.url_config_features = "/Produtos/Barbearia/Legiao_Barber/Config/Features";
       this.idProduto = 5;
       this.produto_selecionado = produto;
    }

  }

  String get getTokenUser{
    return this.tokenUser;
  }

  // ignore: non_constant_identifier_names
  void CaptureToken(String t){
    this.tokenUser = t;
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

   // recebe o id do produto 
  String get getUrlEmpreendedor{
    return this.url_empreendedor_agendamentos_clientes;
  }

  Future<void> StatusAgendamento(String b) async {
    
    if(b == "Aguardando"){
      this.status_agendamento = "Aguardando";
    }else{
      this.status_agendamento = "Confirmado";
    }


  }

  void setProdutoSelecionadoURL(String prod){
    if(this.idProduto == 1) { // advocacia
      this.produto_selecionado = prod;
    }

    if(this.idProduto == 2) { // estetica
      this.produto_selecionado = prod;
    }

    if(this.idProduto == 3) { // fisioterapia
      this.produto_selecionado = prod;
    }

    if(this.idProduto == 4) { // estetica Elenilza
      this.produto_selecionado = prod; 
    }

    if(this.idProduto == 5) { // estetica Elenilza
      this.produto_selecionado = prod;  
    }
    
  }

    void setProfissionalServicoUrl(String p) {
    if(this.idProduto == 1) { // advocacia
       this.profissional = p;
       this.url_servicos = "/Produtos/Advocacia/Lorem_IPSUM_Advocacia/cMj5CPKqvXibRbELeHwc/Funcionarios/$profissional/Servicos"; 
       this.url_data_agendamento = "/Produtos/Advocacia/Lorem_IPSUM_Advocacia/cMj5CPKqvXibRbELeHwc/Funcionarios/$profissional/Data";  
       this.url_horario_agendamento = "/Produtos/Advocacia/Lorem_IPSUM_Advocacia/cMj5CPKqvXibRbELeHwc/Funcionarios/$profissional/Horario";
    }

      if(this.idProduto == 2) { // estetica
       this.profissional = p;
       this.url_servicos = "/Produtos/Estetica/Francielly_Estetica_Design/f4qVyClZ6etPxvpFwfmC/Funcionarios/$profissional/Servicos"; 
       this.url_data_agendamento = "/Produtos/Estetica/Francielly_Estetica_Design/f4qVyClZ6etPxvpFwfmC/Funcionarios/$profissional/Data";  
       this.url_horario_agendamento = "/Produtos/Estetica/Francielly_Estetica_Design/f4qVyClZ6etPxvpFwfmC/Funcionarios/$profissional/Horario";
    }

    if(this.idProduto == 3) { // fisioterapia
      this.profissional = p;
      this.url_servicos = "/Produtos/Fisioterapia/Brisa_Melo_Fisioterapia/blMuzcfY4LfAO42j0OPD/Funcionarios/$profissional/Servicos"; 
      this.url_data_agendamento = "/Produtos/Fisioterapia/Brisa_Melo_Fisioterapia/blMuzcfY4LfAO42j0OPD/Funcionarios/$profissional/Data";  
      this.url_horario_agendamento = "/Produtos/Fisioterapia/Brisa_Melo_Fisioterapia/blMuzcfY4LfAO42j0OPD/Funcionarios/$profissional/Horario";
    }

    if(this.idProduto == 4) { // estetica Elenilza
      this.profissional = p;
      this.url_servicos = "/Produtos/Estetica/Elenilza_Correia_Terapeuta_Corporal/Bmr1jVxZI5sMzcHdZRT3/Funcionarios/$profissional/Servicos"; 
      this.url_data_agendamento = "/Produtos/Estetica/Elenilza_Correia_Terapeuta_Corporal/Bmr1jVxZI5sMzcHdZRT3/Funcionarios/$profissional/Data";  
      this.url_horario_agendamento = "/Produtos/Estetica/Elenilza_Correia_Terapeuta_Corporal/Bmr1jVxZI5sMzcHdZRT3/Funcionarios/$profissional/Horario";
    }

    if(this.idProduto == 5) { // estetica Elenilza
      this.profissional = p;
      this.url_servicos = "/Produtos/Barbearia/Legiao_Barber/oRWbtoONmi1XjUVgHiJC/Funcionarios/$profissional/Servicos"; 
      this.url_data_agendamento = "/Produtos/Barbearia/Legiao_Barber/oRWbtoONmi1XjUVgHiJC/Funcionarios/$profissional/Data";  
      this.url_horario_agendamento = "/Produtos/Barbearia/Legiao_Barber/oRWbtoONmi1XjUVgHiJC/Funcionarios/$profissional/Horario";
    }

}

  void setAgendamentoCliente(String token) {
    if(this.idProduto == 2) { // estetica
      this.url_id_agendamento_cliente = "/Produtos/Estetica/Francielly_Estetica_Design/f4qVyClZ6etPxvpFwfmC/Clientes/$tokenUser"; 
    }
    if(this.idProduto == 3) { // fisioterapia
      this.url_id_agendamento_cliente = "/Produtos/Fisioterapia/Brisa_Melo_Fisioterapia/blMuzcfY4LfAO42j0OPD/Clientes/$tokenUser"; 
    }
    if(this.idProduto == 4) { // estetica
      this.url_id_agendamento_cliente = "/Produtos/Estetica/Elenilza_Correia_Terapeuta_Corporal/Bmr1jVxZI5sMzcHdZRT3/Clientes/$tokenUser"; 
    }
    if(this.idProduto == 5) { // estetica
      this.url_id_agendamento_cliente = "/Produtos/Barbearia/Legiao_Barber/oRWbtoONmi1XjUVgHiJC/Clientes/$tokenUser"; 
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
  
  
  final FirebaseAuth auth = FirebaseAuth.instance;

  void inicializarFirestoreApp() async {
    final FirebaseUser user = await auth.currentUser();
    // here you write the codes to input the data into firestore
  }

  // le os dados do utilizador da biblioteca shared
  Future<String> get lerDadosUtilizador async {
    SharedPreferences dadosUtilizador = await SharedPreferences.getInstance();
    final uidUser = dadosUtilizador.getString('uid');
    return uidUser;
  }

  Future<void> GravarDadosUtilizador(String id) async {
     this.dadosUtilizador = await SharedPreferences.getInstance();
     this.dadosUtilizador.setString('uid', id); // armazena o valor do uid para recuperar na tela principal
    
  }

// recebe o nome do servico e retorna uma miniatura da imagem associada ao servico
   AssetImage getAppThumbnailService(String servico) {
    
    // Advocacia
    if(servico == "Orçamento"){
       this.thumbnail_servico = AssetImage("assets/images/orcamento_advocacia_servico.jpg");
       return this.thumbnail_servico;
     }

    if(servico == "Criminal"){
       this.thumbnail_servico = AssetImage("assets/images/criminal_advocacia_servico.jpg");
       return this.thumbnail_servico;
     }

    if(servico == "Previdenciario"){
       this.thumbnail_servico = AssetImage("assets/images/previdenciario_advocacia_servico.jpg");
       return this.thumbnail_servico;
     }
    
    if(servico == "Trabalhista"){
       this.thumbnail_servico = AssetImage("assets/images/trabalhista_advocacia_servico.jpg");
       return this.thumbnail_servico;
     }

    // Estetica e Design
    if(servico == "Endermoterapia"){
       this.thumbnail_servico = AssetImage("assets/images/endermoterapia_servico.jpg");
       return this.thumbnail_servico;
     }

    if(servico == "Sobrancelhas"){
       this.thumbnail_servico = AssetImage("assets/images/sobrancelhas_servico.jpeg");
       return this.thumbnail_servico;
     }

    if(servico == "Massagem"){
       this.thumbnail_servico = AssetImage("assets/images/massagem_servico.jpg");
       return this.thumbnail_servico;
     }

    if(servico == "Depilação"){
       this.thumbnail_servico = AssetImage("assets/images/depilacao_servico.jpg");
       return this.thumbnail_servico;
     }

     // Fisioterapia
     if(servico == "Avaliação"){
       this.thumbnail_servico = AssetImage("assets/images/avaliacao_servico.jpg");
       return this.thumbnail_servico;
     }

    if(servico == "Pediatrica"){
       this.thumbnail_servico = AssetImage("assets/images/pediatrica_servico.jpg");
       return this.thumbnail_servico;
     }

  //  if(servico == "Neurologica"){
  //     this.thumbnail_servico = AssetImage("assets/images/massagem_servico.jpg");
  //     return this.thumbnail_servico;
  //   }

    if(servico == "Ortopedica"){
       this.thumbnail_servico = AssetImage("assets/images/ortopedica_servico.png");
       return this.thumbnail_servico;
     }
    
    if(servico == "Ventosa"){
       this.thumbnail_servico = AssetImage("assets/images/ventosa_servico.jpg");
       return this.thumbnail_servico;
     }

    // Terapeuta Corporal
    if(servico == "Cone Chines"){
       this.thumbnail_servico = AssetImage("assets/images/cone_chines_servico.png");
       return this.thumbnail_servico;
      }

    // Barbearia
    if(servico == "Corte de Cabelo"){
       this.thumbnail_servico = AssetImage("assets/images/corte_cabelo_servico.jpg");
       return this.thumbnail_servico;
      }
    
  }

// metodos responsaveis pelo gerenciamento das confirmações dos agendamentos
// action dialog
  void ConfirmarAgendamento(BuildContext context, var item, String idDocumento) {
  // configura os botões
  
  Widget btn_cancelar = Container(
    child:Column(
      children: [
       IconButton(
         icon: Icon(Icons.arrow_back, color:this.getIconCor),
         onPressed: (){
           Navigator.pop(context);
         },
       ),
       Text("Voltar", style: TextStyle(color:this.getTextCor)),
      ],

    ),
  );

  Widget btn_confirmar = Container(
    child:Column(
      children: [
       IconButton(
         icon: Icon(Icons.check, color: this.getIconCor),
         onPressed: (){
           
           atualizaStatusAgendamentoCliente(context, item, idDocumento);
           //
          // enviarNotificacaoCliente(context, item);
           
           Navigator.pop(context); // ao clicar no botao o status devera ser alterado para confirmado para no card do empreendedor e cliente
         },
       ),
       Text("Confirmar", style: TextStyle(color: this.getTextCor)),
      ],

    ),
  );
  Widget btnExcluir = Container(
    child:Column(
      children: [
       IconButton(
         icon: Icon(Icons.delete, color: this.getIconCor),
         onPressed: (){
           Navigator.pop(context);
         },
       ),
       Text("Excluir", style: TextStyle(color: this.getTextCor)),
      ],

    ),
  );
  // configura o  AlertDialog
  AlertDialog alert = AlertDialog(
    
    backgroundColor: this.getPrimaryCor,
    title: Text("Detalhes", style: TextStyle(color: this.getTextCor)),

    content: Text("Profisional: "+item["Profissional"]+"\n"+
                  "Serviço: "+item["Servico"]+"\n"+
                  "Data: "+item["Data"]+"\n"+
                  "Horario: "+item["Horario"]+"h\n"+
                  "Status: "+item["Status"], style: TextStyle(color: this.getTextCor)),
                  
    actions: [
      btn_cancelar,
      btn_confirmar, // MUITO IMPORTANTE ao confirmar o agendamento será enviada ao dispositivo do cliente ma notificação confirmando o agendamento
      btnExcluir, 
    ],
  );
  // exibe o dialogo
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

 void ConfirmarNotificacaoAgendamento(BuildContext context, var item) {
  // configura os botões

  Widget btn_cancelar = FlatButton(
    child: Text("Cancelar"),
    onPressed:  () {
      Navigator.pop(context);
    },
  );
  Widget btn_confirmar = FlatButton(
    child: Text("Confirmar", style: TextStyle(color: Colors.green)),
    onPressed:  () {},
  );
  Widget btn_excluir = FlatButton(
    child: Text("Excluir", style: TextStyle(color: Colors.red)),
    onPressed:  () {},
  );
  // configura o  AlertDialog
  AlertDialog alert = AlertDialog(
    
    backgroundColor: this.getPrimaryCor,
    title: Text("Detalhes"),

    content: Text("Cliente: "+item["nome"]+"\n"+
                  "Profissional: "+item["Profissional"]+"\n"+
                  "Serviço: "+item["Servico"]+"\n"+
                  "Data: "+item["Data"]+"\n"+
                  "Horario: "+item["Horario"]+"h\n"+
                  "Status: "+item["Status"]),
    actions: [
      btn_cancelar,
      btn_confirmar, // MUITO IMPORTANTE ao confirmar o agendamento será enviada ao dispositivo do cliente ma notificação confirmando o agendamento
      btn_excluir, 
    ],
  );
  // exibe o dialogo
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

// funcoes de carregamento das features direto do firebase
  // ignore: non_constant_identifier_names
  ListTile CarregarFeaturesMenu(BuildContext context, String item, bool enabled, String idProdutoSelecionado) { // recebe um item lido do firestore Firebase
  
  switch(item){
    case "Cadastro":
      if(enabled == true){
        return ListTile(
             title: Text("Cadastro", style: TextStyle(color: this.getTextCor)),
             leading: Icon(Icons.add,  color: this.getIconCor),
             trailing: Icon(Icons.arrow_right,  color: this.getIconCor), 
             onTap: (){
               
                Navigator.pop(context);
                Navigator.push(context,MaterialPageRoute(builder: (context) => LPS_Cadastro(idProdutoSelecionado: idProdutoSelecionado)));
             },
           );
      }
    break;

    case "Agendamento":
    if(enabled == true){
       return ListTile(
             title: Text("Agendamento", style: TextStyle(color: this.getTextCor)),
             leading: Icon(Icons.date_range,  color: this.getIconCor),
             trailing: Icon(Icons.arrow_right,  color: this.getIconCor), 
             onTap: (){
               
               Navigator.pop(context);
               Navigator.push(context,MaterialPageRoute(builder: (context) => LPS_Agendamento(idProdutoSelecionado: idProdutoSelecionado)));
             },
           );
    }
    break;

    case "Notificações":
    if(enabled == true){
       return ListTile(
             title: Text("Notificações", style: TextStyle(color: this.getTextCor)),
             leading: Icon(Icons.notifications,  color: this.getIconCor),
             trailing: Icon(Icons.arrow_right,  color: this.getIconCor), 
             onTap: (){
               Navigator.pop(context);
               Navigator.push(context,MaterialPageRoute(builder: (context) => HomeNotify(idProdutoSelecionado: idProdutoSelecionado)));
             },
           );
    }
    break;

    case "Empreendedor":
    if(enabled == true){
        return ListTile(
             title: Text('Empreendedor', style: TextStyle(color: this.getTextCor)),
             leading: Icon(Icons.store,  color: this.getIconCor),
             trailing: Icon(Icons.arrow_right,  color: this.getIconCor), 
             onTap: (){
               Navigator.pop(context);
               Navigator.push(context,MaterialPageRoute(builder: (context) => LPS_Empreendedor_Menu(idProdutoSelecionado: idProdutoSelecionado)));
             },
           );
    }
    break;

 //   case "Sobre":
 //   if(enabled == true){    
 //     return ListTile(
 //            title: Text("Sobre", style: TextStyle(color: produto.getTextCor)),
 //            leading: Icon(Icons.info,  color: produto.getIconCor),
 //            trailing: Icon(Icons.arrow_right,  color: produto.getIconCor), 
 //            onTap: (){},
 //          );
 //   }
 //   break;

 //   case "Sair":
 //   if(enabled == true){
 //     return ListTile(
 //            title: Text("Sair", style: TextStyle(color: this.getTextCor)),
 //            leading: Icon(Icons.exit_to_app,  color: this.getIconCor),
 //            trailing: Icon(Icons.arrow_right,  color: this.getIconCor), 
 //            onTap: () => exit(0),
 //          );
 //   }
 //   break;
    }
 }
   
   TextButton CarregarFeaturesCadastro(BuildContext context, String item, bool enabled, String idProdutoSelecionado){

     switch(item){
       case "Clientes":
       if(enabled == true){
         return TextButton.icon(
                label: Text('Clientes', style: TextStyle(color: this.getTextCor)),
                icon: Icon(Icons.person_add, size: 70, color: this.getIconCor),
              onPressed: () {
                   Navigator.push(context,MaterialPageRoute(builder: (context) => LPS_Cad_Cliente(idProdutoSelecionado: idProdutoSelecionado)));
              }
           );
      }
      break;
     
       case "Empresa":
         if(enabled == true){
         return TextButton.icon(
                label: Text('Empresa', style: TextStyle(color: this.getTextCor)),
                icon: Icon(Icons.store, size: 70, color: this.getIconCor),
              onPressed: () {
                   Navigator.push(context,MaterialPageRoute(builder: (context) => LPS_Cad_Empresa(idProdutoSelecionado: idProdutoSelecionado)));
              }
           );
      }
      break;
       
       case "Funcionarios":
             if(enabled == true){
         return TextButton.icon(
                label: Text('Funcionarios', style: TextStyle(color: this.getTextCor)),
                icon: Icon(Icons.school, size: 70, color: this.getIconCor),
              onPressed: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context) => LPS_Cadastro_Profissional(idProdutoSelecionado: idProdutoSelecionado)));
              }
           );
      }
      break;
       //
     }
   }

   //

   InkWell CarregarFeaturesCadastroCards(BuildContext context, String item, bool enabled, String idProdutoSelecionado){

     switch(item){
       case "Clientes":
       if(enabled == true){
         return InkWell(
          
          onTap:(){
              Navigator.push(context,MaterialPageRoute(builder: (context) => LPS_Cad_Cliente(idProdutoSelecionado: idProdutoSelecionado)));     
          },

           child: new Ink(
                  color: this.getFundoCor,
                     child:Container(
                     decoration: BoxDecoration(
                     gradient: LinearGradient(colors: <Color>[
                     this.getPrimaryCor,
                     this.getSecondaryCor,
                    ]),
                    borderRadius: BorderRadius.circular(10),  
                  ),

                  margin: const EdgeInsets.all(5),
                  
                  child: Container(
                     height: 120,
                     decoration: BoxDecoration(
                        image: DecorationImage(
                        image: AssetImage('assets/images/Clientes.png'),
                               fit: BoxFit.fitHeight,
                               alignment: AlignmentDirectional.centerEnd,
                              ),
                              borderRadius: BorderRadius.circular(10),
                     ),
                    
                    child: Column(  
                    crossAxisAlignment: CrossAxisAlignment.start, // responsavel por alinhar a esquerda o icone do estabelecimento
                    children: [
                        Row(
                           children: [
                           Icon(Icons.person_add, size: 50, color: this.getIconCor),
                           Text("Clientes",style: TextStyle(color: this.getTextCor, fontSize: 21)),
                        ],
                      ),
                    ]
                  ),
                ),
              ),
           ),
         );
        }
        break;

       case "Empresa":
      
       if(enabled == true){
         return InkWell(
          
          onTap:(){
             Navigator.push(context,MaterialPageRoute(builder: (context) => LPS_Cad_Empresa(idProdutoSelecionado: idProdutoSelecionado)));     
          },

           child: new Ink(
                  color: this.getFundoCor,
                     child:Container(
                     decoration: BoxDecoration(
                     gradient: LinearGradient(colors: <Color>[
                     this.getPrimaryCor,
                     this.getSecondaryCor,
                    ]),
                    borderRadius: BorderRadius.circular(10),  
                  ),

                  margin: const EdgeInsets.all(5),
                  
                  child: Container(
                     height: 120,
                     decoration: BoxDecoration(
                        image: DecorationImage(
                        image: AssetImage('assets/images/Empresa.png'),
                               fit: BoxFit.fitHeight,
                               alignment: AlignmentDirectional.centerEnd,
                              ),
                              borderRadius: BorderRadius.circular(10),
                     ),
                    
                    child: Column(  
                    crossAxisAlignment: CrossAxisAlignment.start, // responsavel por alinhar a esquerda o icone do estabelecimento
                    children: [
                        Row(
                           children: [
                           Icon(Icons.store, size: 50, color: this.getIconCor),
                           Text("Empresa",style: TextStyle(color: this.getTextCor, fontSize: 21)),
                        ],
                      ),
                    ]
                  ),
                ),
              ),
           ),
         );
        }
        break;
        case "Funcionarios":
        if(enabled == true){
         return InkWell(
          
          onTap:(){
              Navigator.push(context,MaterialPageRoute(builder: (context) => LPS_Cadastro_Profissional(idProdutoSelecionado: idProdutoSelecionado)));     
          },

           child: new Ink(
                  color: this.getFundoCor,
                     child:Container(
                     decoration: BoxDecoration(
                     gradient: LinearGradient(colors: <Color>[
                     this.getPrimaryCor,
                     this.getSecondaryCor,
                    ]),
                    borderRadius: BorderRadius.circular(10),  
                  ),

                  margin: const EdgeInsets.all(5),
                  
                  child: Container(
                     height: 120,
                     decoration: BoxDecoration(
                        image: DecorationImage(
                        image: AssetImage('assets/images/Funcionario.jpg'),
                               fit: BoxFit.fitHeight,
                               alignment: AlignmentDirectional.centerEnd,
                              ),
                              borderRadius: BorderRadius.circular(10),
                     ),
                    
                    child: Column(  
                    crossAxisAlignment: CrossAxisAlignment.start, // responsavel por alinhar a esquerda o icone do estabelecimento
                    children: [
                        
                        Row(
                           children: [
                           Icon(Icons.school, size: 50, color: this.getIconCor),
                           Text("Funcionarios",style: TextStyle(color: this.getTextCor, fontSize: 21)),
                        ],
                      ),
                    ]
                  ),
                ),
              ),
           ),
         );
        }
      }
    }


  // funcoes de criação de produtos
  // ignore: non_constant_identifier_names
  SwitchListTile EscolherFeaturesproduto(BuildContext context, String item, bool enabled) { // recebe um item lido do firestore Firebase
  
  switch(item){
    case "Agendamento":
        return SwitchListTile(
                
                activeTrackColor: Colors.lightGreenAccent,
                activeColor: Colors.green,
                secondary: Icon(Icons.date_range, color: Colors.black),
                title: Text("Agendamento", style: TextStyle(color: Colors.black)),
                value: enabled,
                    onChanged: (bool value) {
                  //    atualizaStatusProduto(item, enabled);
                    });

 //   case "Cadastro":
 //       return SwitchListTile(
 //               activeTrackColor: Colors.lightGreenAccent,
 //               activeColor: Colors.green,
 //               secondary: Icon(Icons.add,  color: Colors.black),
 //               title: Text("Cadastro", style: TextStyle(color: Colors.black)),
 //               value: enabled,
 //                   onChanged: (bool value) {
 //                     atualizaStatusProduto(item, enabled);
 //                   });

    case "Clientes":
        return SwitchListTile(
                activeTrackColor: Colors.lightGreenAccent,
                activeColor: Colors.green,
                secondary: Icon(Icons.person,  color: Colors.black),
                title: Text("Cadastro de Clientes", style: TextStyle(color: Colors.black)),
                value: enabled,
                    onChanged: (bool value) {
                      atualizaStatusProduto(item, enabled);
                    });

    case "Empresa":
        return SwitchListTile(
                activeTrackColor: Colors.lightGreenAccent,
                activeColor: Colors.green,
                secondary: Icon(Icons.store,  color: Colors.black),
                title: Text("Cadastro de Empresas", style: TextStyle(color: Colors.black)),
                value: enabled,
                    onChanged: (bool value) {
                      atualizaStatusProduto(item, enabled);
                    });

    case "Funcionarios":
        return SwitchListTile(
                activeTrackColor: Colors.lightGreenAccent,
                activeColor: Colors.green,
                secondary: Icon(Icons.home_repair_service,  color: Colors.black),
                title: Text("Cadastro de Funcionarios", style: TextStyle(color: Colors.black)),
                value: enabled,
                    onChanged: (bool value) {
                      atualizaStatusProduto(item, enabled);
                    });

 //   case "Empreendedor":
 //       return SwitchListTile(
 //               activeTrackColor: Colors.lightGreenAccent,
 //               activeColor: Colors.green,
 //               secondary: Icon(Icons.store,  color: Colors.black),
 //               title: Text("Empreendedor", style: TextStyle(color: Colors.black)),
 //               value: enabled,
 //                   onChanged: (bool value) {
 //                     atualizaStatusProduto(item, enabled);
 //                   });
    
    case "Notificações":
        return SwitchListTile(
                activeTrackColor: Colors.lightGreenAccent,
                activeColor: Colors.green,
                secondary: Icon(Icons.notifications,  color: Colors.black),
                title: Text("Notificações", style: TextStyle(color: Colors.black)),
                value: enabled,
                    onChanged: (bool value) {
                      atualizaStatusProduto(item, enabled);
                    });

  //  case "Sair":
  //      return SwitchListTile(
  //              secondary: Icon(Icons.exit_to_app_outlined,  color: this.getIconCor),
  //              title: Text("Sair", style: TextStyle(color: this.getTextCor)),
  //              value: enabled,
  //                  onChanged: (bool value) {
  //                    atualizaStatusProduto(item, enabled);
  //                  });
  }

}  
    Future<void> atualizaStatusProduto(String itemNome, itemEnabled) async{
    if(itemEnabled == false){
      Firestore.instance.collection(this.getUrlConfigFeatures).document(itemNome).updateData({
                                    'enabled':true,
                                  });
    }

   if(itemEnabled == true){
      Firestore.instance.collection(this.getUrlConfigFeatures).document(itemNome).updateData({
                                    'enabled':false,
                                  });
    }
  }

  Future<void> reiniciarConfigurador() async {
        List<String> ListaFeature = <String>[
         'Clientes',
         'Empresa',
         'Funcionarios',
         'Notificações'];


        for (int i = 0; i < ListaFeature.length; i++){
        Firestore.instance.collection(this.getUrlConfigFeatures).document(ListaFeature[i].toString()).updateData({
                                    'enabled':false,
                                  });
        }
        exit(0);
  }

   void atualizaStatusAgendamentoCliente(BuildContext context, var item, String idDocumento) async{

     
      Firestore.instance.collection(this.getUrlIdAgendamentoCliente+'/'+item["ID"]+'/Agendamento').document(item["IDAgendamento"]).updateData({
     "Status":"Confirmado",
     });

      Firestore.instance.collection(this.url_empreendedor_agendamentos_clientes).document(idDocumento).updateData({
     "Status":"Confirmado",
     });

   }

   Row alterarCorStatus(BuildContext context, var item){
     if(item["Status"] == "Aguardando"){
     return Row(
         children: [
          Icon(Icons.notifications, color: Colors.red),
          Text(item["Status"],style: TextStyle(color: Colors.red, fontSize: 18)),
         ],
     );

     }else{
    
   //  enviarNotificacaoCliente(item);

     return Row(
           children: [
           Icon(Icons.notifications, color: Colors.green),
           Text(item["Status"],style: TextStyle(color: Colors.green, fontSize: 18)),
         ],
       );

     }

   }
   
   void enviarNotificacaoCliente(var item) async {   
       NotificationService nsm;
       if(item["Status"] == "Confirmado"){
       this.nsm.showNotifications(ConfigNotification(
       id: 1,
       titulo: "Confirmação de Agendamento",
       body: "Ola! "+item["Nome"]+" Seu agendamento foi confirmado com Sucesso, compareça ao local agendado",
       payload: " ",
       ));

       }
   
   }
   //
}
// classe responsavel por apresentar as features disponiveis de acordo com o firebase



  