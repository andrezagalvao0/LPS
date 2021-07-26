
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lps_ufs_tcc/main.dart';
import 'package:lps_ufs_tcc/models/produto.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main(){
  // inicializa cores

   Produto produto = new Produto("Estetica");
  

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false, // Remover o Banner de Debug
    theme: ThemeData(
      accentColor: produto.getAppCor,
      primaryColor: produto.getAppCor,
      ),
    title: 'Login',
    home: LPS_Login(),
)); // Executa a Tela de Cadastro de Cliente
}


class LPS_Login extends StatelessWidget {

   @required var ct_email = TextEditingController();
   @required var ct_senha = TextEditingController();

   final flogin = GlobalKey<FormState>();



   final auth = FirebaseAuth.instance;
     Produto produto = new Produto("Estetica");
 

  @override
 Widget build(BuildContext context){

   
   return Scaffold(
     body: SingleChildScrollView( // responsavel por oocultar o overflowed
      child: Form(
       key: flogin,
       child:Column(
         children: <Widget>[
           Container(
             width: MediaQuery.of(context).size.width,
             height: MediaQuery.of(context).size.height/2.5,
             decoration: BoxDecoration(
               image:DecorationImage( image: produto.getAppImage),
               gradient: LinearGradient(
                 begin: Alignment.topCenter,
                 end: Alignment.bottomCenter,
                 colors: [
                   produto.getPrimaryCor,
                   produto.getSecondaryCor
                 ]
               ),
               borderRadius: BorderRadius.only(
                 bottomLeft: Radius.circular(50),
                 bottomRight: Radius.circular(50),
               ),
             ),
           ),

             // Campos de Login e Senha para acessar o aplicativo
         SizedBox(height: 30),
          Container(
            padding: EdgeInsets.only(top:10),
            child: Column(
              children: <Widget>[
                  Container(
                  
                   width: 230,
                   child: TextFormField(
                     cursorColor: produto.getPrimaryCor,
                     keyboardType: TextInputType.emailAddress,
                   decoration: InputDecoration(
                 //  hintStyle: TextStyle(color: produto.textCor),
                   icon: Icon(Icons.email_outlined,  color: produto.getIconCor),
                   hintText: 'Email',
                   ),
                  
                   validator: (value){
                     if(value.length < 5){
                       return "Email muito curto";
                     }else if(!value.contains("@")){
                       return "Tem certeza que é um email?";
                     }
                     return null;
                   },
                   controller: ct_email,
                  ),
                ),
              ],
            ),
          ),

            Container(
            padding: EdgeInsets.only(top:10),
            child: Column(

              children: <Widget>[
                  Container(
                   width: 230,
                   child: TextFormField(
                   cursorColor: produto.getPrimaryCor,
                   obscureText: true,
                   decoration: InputDecoration(
                  // hintStyle: TextStyle(color: produto.textCor),
                   icon: Icon(Icons.vpn_key_outlined,  color: produto.getIconCor),
                   hintText: 'Senha',
                   ),
                   
                   validator: (value){
                     
                     if(value.length < 8){
                       return "Senha muito curta";
                     }
                     return null;
                   },
                   controller: ct_senha,
                  ), 
                ),
              ],
            ),
          ),

              new Container(
                width: 150,

                child:Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                SizedBox(height: 30),
                RaisedButton(   // // executa uma rota para a tela principal ao clicar no botão
                 child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text("Entrar", style: TextStyle(fontSize: 14.0, color: produto.getTextCor)),
                            ],
                          )),
                color: produto.getComponentCor,
                onPressed: () async{

                  if(flogin.currentState.validate()){
                
                  auth.signInWithEmailAndPassword(email: ct_email.text, password: ct_senha.text);
                  Navigator.push(context,MaterialPageRoute(builder: (context) => Homescreen()));
                
                  }
              },
              shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(50.0))),
                ],
            ),
          ),

            new Container(
                width: 150,

                child:Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                RaisedButton(   // // executa uma rota para a tela principal ao clicar no botão
                 child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text("Inscrever-se", style: TextStyle(fontSize: 14.0, color: produto.getTextCor)),
                            ],
                          )),
                color: produto.getComponentCor,
                onPressed: () async{
                   signUpCliente(context);
              },
              shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(50.0))),
                ],
            ),
          ),             
         ],
       ),
     ),
    ),
     backgroundColor: Colors.white,
   );

  }

void signUpCliente(BuildContext context){
    //
    //capturar valores dos editexts
    @required var ct_nome = TextEditingController();
    @required var ct_email = TextEditingController();
    @required var ct_senha = TextEditingController();
    
    showDialog(
      context: context, 
      builder: (BuildContext context){
         return AlertDialog(
               title: Text('Inscrição'),

               content: Form(
                 child: SingleChildScrollView(
                   child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: <Widget>[

                    SizedBox(height: 5),
                     Text('Email'),
                     TextFormField(
                       decoration: InputDecoration(
                         hintText: ('Ex. seuemail@gmail.com'),
                           border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(10),
                         ),
                       ),
                       controller: ct_email,
                     ),

                     Text('Senha'),
                     TextFormField(
                       decoration: InputDecoration(
                          border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                         ),
                       ),
                       controller: ct_senha,
                     ),

                   ],
                 ),
                ),
               ),
               actions: <Widget>[

                          FlatButton(
                            onPressed: ()=> Navigator.of(context).pop(),
                           // color: Colors.amberAccent,
                            child: Text('Cancelar', style: TextStyle(color: Colors.redAccent)),
                          ),

                          FlatButton(
                           //Utilização do Firebase
                            onPressed: () async {
                           await  auth.createUserWithEmailAndPassword(email: ct_email.text, password: ct_senha.text);
                              Navigator.of(context).pop();
                            },

                            color: produto.getTextCor,
                            child: Text('Inscrever', style: TextStyle(color: produto.getTextCor)),
            ),
          ],
        );
        });
      }


}