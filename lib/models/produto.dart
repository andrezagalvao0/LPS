// classe responsavel pelo gerenciamento de produtos da linha de produto

import 'dart:core';
import 'dart:core';
import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lps_ufs_tcc/views/agendamento.dart';
import 'package:lps_ufs_tcc/views/cadastro.dart';
import 'package:lps_ufs_tcc/views/empreendedor_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'notificacoes.dart';

class Produto{

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

Produto(){

    if(idProduto == 1){
     
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

    if(idProduto == 4){
     popup_color = Colors.white;
     this.componentCor =  Colors.white;
     this.iconCor = Color.fromRGBO(225,132,124,5);//Colors.pink;
     this.textCor = Color.fromRGBO(225,132,124,5);//Colors.pink;
     this.appBarCor  = Colors.white;
     this.appCor   = Colors.white;
     this.fundoCor = Colors.white;
     this.decorationPrimaryColor   = Color.fromRGBO(225,132,124,5);
     this.decorationSecondaryColor = Colors.white;
     this.drawerdecorationSecondaryColor = Colors.white;
     this.drawerdecorationPrimaryColor = Colors.white;
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
     this.url_config_features = "/Produtos/Estetica/Elenilza_Correia_Terapeuta_Corporal/Config/Features/Empreendedor";
     this.url_empreendedor_agendamentos_clientes = "/Produtos/Estetica/Elenilza_Correia_Terapeuta_Corporal/Bmr1jVxZI5sMzcHdZRT3/Empreendedor/Todos_os_Agendamentos/Agendados_por_Clientes";
  }

}
  // recebe o id do produto 
  String get getUrlConfigFeatures{
    return this.url_config_features;
  }

  String get getIdDispositivo{
    return this.id_dispositivo;
  }

  String get getStatusAgendamento{
    return this.status_agendamento;
  }

  void setIdDispositivo(String id){
    this.id_dispositivo = id;
  }

  Future<void> setProduto(int id ) async {
    this.idProduto = id;
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

  void setProfissionalServicoUrl(String p) {
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
    
  }

  // funcoes de carregamento das features direto do firebase
  ListTile CarregarFeaturesMenu(BuildContext context,String item, bool enabled) { // recebe um item lido do firestore Firebase

  if(item == "Cadastro" && enabled == true){
  
  return new ListTile(
             title: Text("Cadastro", style: TextStyle(color: this.getTextCor)),
             leading: Icon(Icons.add,  color: this.getIconCor),
             trailing: Icon(Icons.arrow_right,  color: this.getIconCor), 
             onTap: (){
                Navigator.pop(context);
                Navigator.push(context,MaterialPageRoute(builder: (context) => LPS_Cadastro()));
             },
           );
         }
         else

  if(item == "Agendamento" && enabled == true){
  
  return new ListTile(
             title: Text("Agendamento", style: TextStyle(color: this.getTextCor)),
             leading: Icon(Icons.calendar_today,  color: this.getIconCor),
             trailing: Icon(Icons.arrow_right,  color: this.getIconCor), 
             onTap: (){
               Navigator.pop(context);
               Navigator.push(context,MaterialPageRoute(builder: (context) => LPS_Agendamento()));
             },
           );
         }
         else 

  if(item == "Notificações" && enabled == true){
  
  return new ListTile(
             title: Text("Notificações", style: TextStyle(color: this.getTextCor)),
             leading: Icon(Icons.notifications,  color: this.getIconCor),
             trailing: Icon(Icons.arrow_right,  color: this.getIconCor), 
             onTap: (){
               Navigator.pop(context);
               Navigator.push(context,MaterialPageRoute(builder: (context) => HomeNotify()));
             },
           );
         }else

  if(item == "Empreendedor" && enabled == true){
  
  return new ListTile(
             title: Text('Empreendedor', style: TextStyle(color: this.getTextCor)),
             leading: Icon(Icons.store,  color: this.getIconCor),
             trailing: Icon(Icons.arrow_right,  color: this.getIconCor), 
             onTap: (){
               Navigator.pop(context);
               Navigator.push(context,MaterialPageRoute(builder: (context) => LPS_Empreendedor_Menu()));
             },
           );
         }else

  if(item == "Sobre" && enabled == true){
  
  return new ListTile(
             title: Text("Sobre", style: TextStyle(color: this.getTextCor)),
             leading: Icon(Icons.info,  color: this.getIconCor),
             trailing: Icon(Icons.arrow_right,  color: this.getIconCor), 
             onTap: (){},
           );
         }else 

  if(item == "Sair" && enabled == true){
  
  return new ListTile(
             title: Text("Sair", style: TextStyle(color: this.getTextCor)),
             leading: Icon(Icons.exit_to_app,  color: this.getIconCor),
             trailing: Icon(Icons.arrow_right,  color: this.getIconCor), 
             onTap: () => exit(0),
           );
         }       
      }  

      // metodos responsaveis pelo gerenciamento das confirmações dos agendamentos
// action dialog
  void ConfirmarAgendamento(BuildContext context, var item) {
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

    content: Text("Profissional: "+item["Profissional"]+"\n"+
                  "Serviço: "+item["Servico"]+"\n"+
                  "Data: "+item["Data"]+"\n"+
                  "Horario: "+item["Horario"]),
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
                  "Horario: "+item["Horario"]+"\n"+
                  "Situação: "+item["Status_Agendamento"]),
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
    

}

// classe responsavel por apresentar as features disponiveis de acordo com o firebase



  