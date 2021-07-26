// classe responsavel pelo gerenciamento de produtos da linha de produto

import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Produto{

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

//

// recebe uma identificação sobre qual esquema de aparencia sera exibida de acordo com o resultado enviado pelo firebase
// Estetica, Fisioterapia, Advocacia
Produto(String refProduto){

    if(refProduto == 'Advocacia'){
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
  }


  
  if(refProduto == 'Estetica'){
     this.componentCor =  Colors.amberAccent;
     this.iconCor = Colors.black; 
     this.textCor = Colors.black;
     this.appBarCor  = Colors.amberAccent;
     this.appCor   = Colors.amberAccent;
     this.fundoCor = Colors.amber.shade50;
     this.decorationPrimaryColor   = Colors.amber[100];
     this.decorationSecondaryColor = Colors.amber[400];
     this.decorationDateColor = Colors.amber;
     this.appImage = AssetImage('assets/images/header_estetica.png');
     this.appImageService = AssetImage('assets/images/service_header.png');
  }

    if(refProduto == 'Fisioterapia'){
     this.componentCor =  Colors.white;
     this.iconCor = Colors.green[800]; 
     this.textCor = Colors.green[800];
     this.appBarCor  = Colors.green[800];
     this.appCor   = Colors.green;
     this.fundoCor = Colors.green[50];
     this.decorationPrimaryColor   = Colors.green[50];
     this.decorationSecondaryColor = Colors.green[100];
     this.decorationDateColor = Colors.green;
     this.appImage = AssetImage('assets/images/header_fisioterapia.png');
     this.appImageService = AssetImage('assets/images/header_fisioterapia.png');
  }

}
  Color get getPrimaryCor{
    return this.decorationPrimaryColor;
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
  
}

// classe responsavel por apresentar as features disponiveis de acordo com o firebase

  