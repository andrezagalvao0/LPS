// classe responsavel pela criação da feature no app
import 'package:flutter/material.dart';
import 'package:lps_ufs_tcc/empresa.dart';
import 'package:lps_ufs_tcc/funcionario.dart';
import 'package:lps_ufs_tcc/models/cadastro_empresa.dart';
import 'package:lps_ufs_tcc/models/cadastro_profissional.dart';

import '../cliente.dart';
import 'cadastro_cliente.dart';
import 'produto.dart';

// ignore: must_be_immutable
class Feature extends Container{

  int id;
  bool status;
  String name;
  IconData icn;
  Produto produto = new Produto(); // produto 2 da LPS

  Feature(bool enabled, String name){
    this.name = name;
    this.status = enabled;

    if(this.name == "Agendamento"){
      this.icn = Icons.calendar_today;
    }

    if(this.name == "Clientes"){
      this.icn = Icons.person;
    }

    if(this.name == "Empresa"){
      this.icn = Icons.store;
    }

    if(this.name == "Funcionarios"){
      this.icn = Icons.work;
    }

    if(this.name == "Notificacoes"){
      this.icn = Icons.calendar_today;
    }

  }

  @override
  Widget build(BuildContext context){

   // retorna um container com o os atributos da feature
   return Container(

     decoration: BoxDecoration(
                    color: Colors.amberAccent[50],
                    //borderRadius: BorderRadius.circular(100),
                  ),

                width: 300,
                height: 150,
                child: Column(
                children: <Widget>[

                SizedBox(height: 20, width: 20),
                Visibility(
             // ignore: unrelated_type_equality_checks
                visible: this.status,
                child:RaisedButton(   // // executa uma rota para a tela de cadastro de clientes ao clicar no botão
              
                child: Column(
                    children: <Widget>[
                      Icon(this.icn, size: 100, color: produto.getIconCor),
                      Text(this.name, style: TextStyle(fontSize: 20, color: produto.getTextCor), ),
                    ]
                  ),
                color: produto.getComponentCor,
               onPressed:(){
                 
                 //Se o nome da feature for "" va para a tela correspondente
                 if(this.name == "Clientes"){
                   Navigator.push(context,MaterialPageRoute(builder: (context) => LPS_Cad_Cliente(),
                   ));
                  }

                 if(this.name == "Empresa"){
                   Navigator.push(context,MaterialPageRoute(builder: (context) => LPS_Cad_Empresa(),
                   ));
                  }

                 if(this.name == "Funcionarios"){
                   Navigator.push(context,MaterialPageRoute(builder: (context) => LPS_Cadastro_Profissional(),
                   ));
                  }
              },
             ),
            ),
          ],
         ),
        );
  
  }
}