
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lps_ufs_tcc/models/usuario.dart';
import 'package:lps_ufs_tcc/views/agendamento.dart';
import 'package:lps_ufs_tcc/views/agendamento_sem_cadastro.dart';
import 'package:lps_ufs_tcc/main.dart';
import 'package:lps_ufs_tcc/models/produto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart'; // biblioteca utilizada para capturar os dados do utilizador logado

void main(){
  // inicializa cores

   Produto produto = new Produto(); // produto 2 da LPS
   
  

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
    String idUtilizador = null;


   final flogin = GlobalKey<FormState>();
   final auth = FirebaseAuth.instance;
    
   Produto produto = new Produto(); // produto 2 da LPS
 

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
                  SharedPreferences shp = await SharedPreferences.getInstance();
               
                  if(flogin.currentState.validate()){

                    Future<String> result = signIn(ct_email.text, ct_senha.text);

                    if(result != null){
                      // capturar o token do usuario e tranfere para a proxima tela
                      Navigator.push(context,MaterialPageRoute(builder: (context) => Homescreen(uid: shp.getString("uid"),)));

                    }

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

          // recurso de acessibilidade agendar sem cadastro
          SizedBox(height: 50),
              new Container(
                width: 220,

                child:Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                RaisedButton(   // // executa uma rota para a tela principal ao clicar no botão
                 child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text("Agendar sem Cadastro", style: TextStyle(fontSize: 14.0, color: produto.getTextCor)),
                            ],
                          )),
                color: produto.getComponentCor,
                onPressed: () {
                   Navigator.push(context,MaterialPageRoute(builder: (context) => LPS_Agendamento_Sem_Cadastro()));
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
                     Text('Nome'),
                     TextFormField(
                       decoration: InputDecoration(
                         hintText: ('Ex. João, José'),
                           border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(10),
                         ),
                       ),
                       controller: ct_nome,
                     ),

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
                       obscureText: true,
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
                                  
                                  SharedPreferences dadosUtilizador = await SharedPreferences.getInstance();
                                  auth.createUserWithEmailAndPassword(email: ct_email.text, password: ct_senha.text).then((value) => {
                                  Firestore.instance.collection(produto.getUrlClientes).document(value.user.uid).setData({
                                    'nome':ct_nome.text,
                                    'uid':value.user.uid,
                                  }),
                                  // cria um documento com a identificacao do cliente no cloud firestore
                                  // cria um diretorio unico para o agendamento daquele utilizador
                                  dadosUtilizador.setString('uid', value.user.uid),
                                  dadosUtilizador.setString('Nome', ct_nome.text),
                                  alerta_Inscricao(context),


                              });
                             
                              Navigator.of(context).pop();
                            },

                            color: produto.getComponentCor,
                            child: Text('Inscrever', style: TextStyle(color: produto.getTextCor)),
            ),
          ],
        );
        });
      }

    Future<String> signIn(String email, String password) async {
      SharedPreferences dadosUtilizador = await SharedPreferences.getInstance();
      
       try{
        var id;
        FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) => {
                                   // adiciona o valor de value na captura do token
                                  // cria um documento com a identificacao do cliente no cloud firestore
        
        id = value.user.uid,
        dadosUtilizador.setString("uid", id),
         // devemos utilizar esse uid em todo o app
        // dadosUtilizador.setString('uid', id), // armazena o valor do uid para recuperar na tela principal
        //produto.GravarDadosUtilizador(id),

        });
          
         return id; // id reconhecido
         
       }catch(e){
         return null; // id nao reconhecido
       }
    }
      
      Future<void> criarDiretorios(BuildContext context, String url) async{
        await Firestore.instance.collection(url).document("Agendamento").setData({
          'Ativo':true,
        });
      }

  void alerta_Inscricao(BuildContext context){

      showDialog(context: context, 
                 builder: (BuildContext context){
                   return AlertDialog(
                     backgroundColor: produto.getPrimaryCor,
                     
                     title: Text("Cadastro Realizado com Sucesso!", style: TextStyle(fontSize: 18, color: produto.getTextCor)),
                     actions: <Widget>[

                          FlatButton(
                            onPressed: ()=> Navigator.of(context).pop(),
                           
                            child: Text('Concluido', style: TextStyle(color: produto.getTextCor)),
                          ),
                            
          ],
         );
        });
      }


}