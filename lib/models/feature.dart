// classe responsavel pela criação da feature no app
import 'package:flutter/material.dart';
import 'package:lps_ufs_tcc/empresa.dart';
import 'package:lps_ufs_tcc/funcionario.dart';

import '../cliente.dart';
import 'produto.dart';

// ignore: must_be_immutable
class Feature extends Container{

  int id;
  bool status;
  String name;
  IconData icn;

  Feature(String name, bool enabled){
    this.name = name;
    this.status = enabled;

    if(this.name == "Cliente"){
      this.icn = Icons.person;
    }

    if(this.name == "Empresa"){
      this.icn = Icons.work;
    }

    if(this.name == "Funcionario"){
      this.icn = Icons.support;
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
                      Icon(this.icn, size: 100, color: Colors.black,),
                      Text(this.name, style: TextStyle(fontSize: 20, color: Colors.black), ),
                    ]
                  ),
                color: Colors.amberAccent,
               onPressed:(){
                 
                 //Se o nome da feature for "" va para a tela correspondente
                 if(this.name == "Cliente"){
                   Navigator.push(context,MaterialPageRoute(builder: (context) => LPS_Cadastro_Cliente(),
                   ));
                  }

                 if(this.name == "Empresa"){
                   Navigator.push(context,MaterialPageRoute(builder: (context) => LPS_Cadastro_Empresa(),
                   ));
                  }

                 if(this.name == "Funcionario"){
                   Navigator.push(context,MaterialPageRoute(builder: (context) => LPS_Cadastro_Funcionario(),
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