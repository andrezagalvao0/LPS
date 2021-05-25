
import 'package:flutter/material.dart';
import 'package:lps_ufs_tcc/main.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false, // Remover o Banner de Debug
    theme: ThemeData(
      accentColor: Colors.amberAccent,
      primaryColor: Colors.amber,
      ),
    title: 'Login',
    home: LPS_Login(),
)); // Executa a Tela de Cadastro de Cliente
}

//metodo utilizado para inicializar os widgets da linha de produto
// verifica no firebase os ids das features e disponibiliza ao cliente do app as features que estao disponiveis
@override
 void initState() {
  
   print('Parabens Você inicializou o App');
 }


class LPS_Login extends StatelessWidget {
  
  @override
 Widget build(BuildContext context){
   return Scaffold(
     body: SingleChildScrollView( // responsavel por oocultar o overflowed
       child:Column(
         children: <Widget>[
           Container(
             width: MediaQuery.of(context).size.width,
             height: MediaQuery.of(context).size.height/2.5,
             decoration: BoxDecoration(
               image:DecorationImage( image: AssetImage('images/header_estetica.png')),
          //     image:DecorationImage( image: AssetImage('images/header_fisioterapia.png')),
               gradient: LinearGradient(
                 begin: Alignment.topCenter,
                 end: Alignment.bottomCenter,
                 colors: [
                   Colors.amber,
                   Colors.amberAccent,
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
        // SizedBox(height: 5),
          Container(
            padding: EdgeInsets.only(top:10),
            child: Column(
              children: <Widget>[
                  Container(
                   width: 230,
                   child: TextField(
                     cursorColor: Colors.amberAccent,
                     keyboardType: TextInputType.emailAddress,
                   decoration: InputDecoration(
                   hintStyle: TextStyle(color: Colors.black),
                   icon: Icon(Icons.email_outlined,  color: Colors.black),
                   hintText: 'Email',
                   ),
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
                   child: TextField(
                   cursorColor: Colors.amberAccent,
                   obscureText: true,
                   decoration: InputDecoration(
                   icon: Icon(Icons.vpn_key_outlined,  color: Colors.black),
                   hintText: 'Senha',
                   ),
                  ), 
                ),
              ],
            ),
          ),
                SizedBox(height: 10),
                RaisedButton(   // // executa uma rota para a tela principal ao clicar no botão
                child: Text('Entrar'),
                color: Colors.amberAccent,
                onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder: (context) => Homescreen(),
               ));
              },
             ),

                SizedBox(height: 50),
                RaisedButton(   // // executa uma rota para a tela principal ao clicar no botão
                child: Text('Agendar sem Cadastro'),
                color: Colors.amberAccent,
                onPressed: (){}
              //  Navigator.push(context,MaterialPageRoute(builder: (context) => Homescreen(),
             //  ));
             // },
             ),

                RaisedButton(   // // executa uma rota para a tela principal ao clicar no botão
                child: Text('Inscrever-se'),
                color: Colors.greenAccent,
              ///  onPressed: (){
              //  Navigator.push(context,MaterialPageRoute(builder: (context) => Homescreen(),
             //  ));
             // },
             ),

             
         ],
       ),
     ),

     backgroundColor: Colors.white,
   );

  }
}