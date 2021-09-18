import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:lps_ufs_tcc/models/produto.dart';

class LPS_Cad_Empresa extends StatefulWidget {
  @override
  LPS_Cadastro_E createState() => LPS_Cadastro_E();
}

class LPS_Cadastro_E extends State<LPS_Cad_Empresa> {
  var selectedCurrency, selectedType;

  String empresa_informada;
  String cnpj_informado;

  @required
  var ct_nome_empresa = TextEditingController();
  @required
  var ct_cnpj_empresa = TextEditingController();
  

  final GlobalKey<FormState> _formKeyValue = new GlobalKey<FormState>();

  Produto produto = new Produto(); // produto 2 da LPS

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.home, color: produto.getIconCor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Cadastro de Empresa',
            style: TextStyle(color: produto.getTextCor)),
        backgroundColor: produto.getSecondaryCor,
      ),
      backgroundColor: produto.getFundoCor,
      body: Container(
          child: Form(
        key: _formKeyValue,
        child: new ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          children: <Widget>[
            SizedBox(height: 10.0),

            // cadastro de empresas dos produtos da LPS
            new TextFormField(
              decoration: InputDecoration(
                icon: Icon(
                  Icons.business,
                  color: produto.getIconCor,
                ),
                hintText: 'Informe o nome da empresa',
                labelText: 'Nome Empresa',
              ),
              controller: ct_nome_empresa,
            ),

            new TextFormField(
              decoration: InputDecoration(
                icon: Icon(
                  Icons.vpn_key,
                  color: produto.getIconCor,
                ),
                hintText: 'Informe o cnpj',
                labelText: 'CNPJ',
              ),
              controller: ct_cnpj_empresa,
            ),


            SizedBox(
              height: 100.0,
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                RaisedButton(
                    color: produto.getComponentCor,
                    textColor: produto.getTextCor,
                    child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text("Concluir Cadastro",
                                style: TextStyle(
                                    fontSize: 18.0, color: produto.getTextCor)),
                          ],
                        )),
                    onPressed: () {
                      adicionar_empresa(
                          context,
                          ct_nome_empresa.text,
                          ct_cnpj_empresa.text);

                      alerta(context);
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(50.0))),
              ],
            ),
          ],
        ),
      )),
    );
  }

  void adicionar_empresa(BuildContext context, String empresa, String cnpj) async {
    await Firestore.instance.collection(produto.getUrlEmpresas).add({
      'Empresa': empresa.toString(),
      'CNPJ': cnpj.toString()
    });
    var cl_empresa = Firestore.instance.collection(produto.getUrlEmpresas);
    cl_empresa.document(empresa).setData({
      'Empresa': empresa.toString(),
      'CNPJ': cnpj.toString()
    });
  }

  void alerta(BuildContext contex) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: produto.getPrimaryCor,
            title: Text("Cadastro Concluido",
                style: TextStyle(fontSize: 18, color: produto.getTextCor)),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK', style: TextStyle(color: produto.getTextCor)),
              ),
            ],
          );
        });
  }

  
}
