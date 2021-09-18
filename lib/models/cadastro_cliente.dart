import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:lps_ufs_tcc/models/produto.dart';

class LPS_Cad_Cliente extends StatefulWidget {
  @override
  LPS_Cadastro_C createState() => LPS_Cadastro_C();
}

class LPS_Cadastro_C extends State<LPS_Cad_Cliente> {
  var selectedCurrency, selectedType;

  String cliente_informado;
  String email_informado;
  String telefone_informado;
  String senha_informado;

  @required
  var ct_nome_cliente = TextEditingController();
  @required
  var ct_email_cliente = TextEditingController();
  @required
  var ct_telefone_cliente = TextEditingController();
  @required
  var ct_senha = TextEditingController();

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
        title: Text('Cadastro de Cliente',
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

            // cadastro de clientes dos produtos da LPS
            new TextFormField(
              decoration: InputDecoration(
                icon: Icon(
                  Icons.person,
                  color: produto.getIconCor,
                ),
                hintText: 'Informe o nome',
                labelText: 'Nome',
              ),
              controller: ct_nome_cliente,
            ),

            new TextFormField(
              decoration: InputDecoration(
                icon: Icon(
                  Icons.email,
                  color: produto.getIconCor,
                ),
                hintText: 'Informe o Email',
                labelText: 'E-mail',
              ),
              controller: ct_email_cliente,
            ),

            new TextFormField(
              decoration: InputDecoration(
                icon: Icon(
                  Icons.phone,
                  color: produto.getIconCor,
                ),
                hintText: 'Informe o telefone',
                labelText: 'Telefone',
              ),
              controller: ct_telefone_cliente,
            ),

            new TextFormField(
              decoration: InputDecoration(
                icon: Icon(
                  Icons.security,
                  color: produto.getIconCor,
                ),
                hintText: 'Informe uma senha',
                labelText: 'Senha',
              ),
              controller: ct_senha,
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
                      adicionar_cliente(
                          context,
                          ct_nome_cliente.text,
                          ct_email_cliente.text,
                          ct_telefone_cliente.text,
                          ct_senha.text);

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

  void adicionar_cliente(BuildContext context, String cliente, String email,
      String telefone, String senha) async {
    await Firestore.instance.collection(produto.getUrlClientes).add({
      'Cliente': cliente.toString(),
      'E-mail': email.toString(),
      'Telefone': telefone.toString(),
      'Senha': senha.toString(),
    });
    var cl_cliente = Firestore.instance.collection(produto.getUrlClientes);
    cl_cliente.document(cliente).setData({
      'Cliente': cliente.toString(),
      'E-mail': email.toString(),
      'Telefone': telefone.toString(),
      'Senha': senha.toString(),
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
