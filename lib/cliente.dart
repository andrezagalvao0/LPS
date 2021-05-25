import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false, // Remover o Banner de Debug
    title: 'Cliente',
    home: LPS_Cadastro_Cliente(),
)); // Executa a Tela de Cadastro de Cliente
}

class LPS_Cadastro_Cliente extends StatelessWidget { 

 @override
 Widget build(BuildContext context){
 
   Firestore.instance.collection('cliente').getDocuments().then((value){
     value.documents.forEach((element) {
      print(element.data);
      });
   });

   return Scaffold(
     appBar: AppBar(
       iconTheme: IconThemeData(
       color: Colors.black),

       title: Text('Meus Clientes', style: TextStyle(color: Colors.black)),
       backgroundColor: Colors.amberAccent,
     ),
     
     body: StreamBuilder(
       stream: Firestore.instance.collection('cliente').snapshots(),
       builder: (
         BuildContext context,
         AsyncSnapshot<QuerySnapshot> snapshot,
       ) {

         if(snapshot.hasError){
             return Center(child: Text('Error: ${snapshot.error}'));
         }

         if(snapshot.connectionState == ConnectionState.waiting){
             return Center(child: CircularProgressIndicator());
         }

         if(snapshot.data.documents.length == 0){
             return Center(child: Text('Nenhum Registro Existente'));
         }
         
         return ListView.builder(
           itemCount: snapshot.data.documents.length,
           itemBuilder: (BuildContext context, int i) {

           var item = snapshot.data.documents[i].data;

           return Container(
                  
                  decoration: BoxDecoration(
                    color: Colors.amber[100],
                    borderRadius: BorderRadius.circular(20),
                  ),

                  margin: const EdgeInsets.all(5),

                   child: ListTile(
                   leading: IconButton(
                     icon: Icon(Icons.person, color: Colors.black, size: 32)
                    ),
                   title: Text(item['nome'], style: TextStyle(color: Colors.black)),
                   subtitle: Text(item['email'], style: TextStyle(color: Colors.black)),
                   trailing: Icon(Icons.info_outline_rounded, color: Colors.black,  size: 32),
                     
                     isThreeLine: true,
                     onLongPress: () => model_options_cliente(context,Text(item['nome']), item),
                   

                  ),
                 );
                },
              );
             },
           ),
           

           // aciona o dialog para entrada de dados de um novo cliente
     floatingActionButton: FloatingActionButton(
       child: Icon(Icons.person_add, color: Colors.black),
       backgroundColor: Colors.amberAccent,
       
       onPressed: () => model_add_cliente(context),

       tooltip: 'Adicionar novo Cliente',
     ),
     backgroundColor: Colors.white,
    );
  }


  // menu utilizado para costumizar as opcoes do cliente 
  // ignore: non_constant_identifier_names
  void model_options_cliente(BuildContext context, Text texto_nome_cliente, item){

      showDialog(context: context, 
                 builder: (BuildContext context){
                   return AlertDialog(
                     backgroundColor: Colors.amber[100],
                     title: texto_nome_cliente,
                     actions: <Widget>[

                          FlatButton(
                            onPressed: ()=> Navigator.of(context).pop(),
                           // color: Colors.amberAccent,
                            child: Text('Atualizar Cliente', style: TextStyle(color: Colors.green)),
                          ),

                          FlatButton(
                            //Utilização do Firebase
                             onPressed: ()=>{}, //model_excluir_cliente(context),
                             // Navigator.of(context).pop();
                            // color: Colors.amberAccent,
                            child: Text('Excluir Cliente', style: TextStyle(color: Colors.red)),
            ),
          ],
         );
        });
      }

  // model excluir cliente
 
  void model_excluir_cliente(BuildContext context){
         
             Firestore.instance.collection('cliente').getDocuments().then((snapshot) {
             for (DocumentSnapshot doc in snapshot.documents) {
              doc.reference.delete();
             }
          });
        }    
 
  // model_add_cliente
  void model_add_cliente(BuildContext context){
    //
    //capturar valores dos editexts
    @required var ct_nome = TextEditingController();
    @required var ct_email = TextEditingController();
    @required var ct_telefone = TextEditingController();
    


    showDialog(
      context: context, 
      builder: (BuildContext context){
         return AlertDialog(
               title: Text('Formulario de Cliente'),

               content: Form(
                 child: SingleChildScrollView(
                   child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: <Widget>[

                    SizedBox(height: 5),
                     Text('Nome'),
                     TextFormField(
                       decoration: InputDecoration(
                         hintText: ('Ex. João, Maria'),
                          border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                         ),
                       ),
                       controller: ct_nome,
                     ),

                    
                     Text('Telefone'),
                     TextFormField(
                       decoration: InputDecoration(
                         hintText: ('Ex. 79999999999'),
                          border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                         ),
                       ),
                       controller: ct_telefone,
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
                           await   Firestore.instance.collection('cliente').add({
                                  'nome': ct_nome.text,
                                  'email': ct_email.text,
                                  'telefone': ct_telefone.text,
                               }
                              );
                              Navigator.of(context).pop();
                            },
                            color: Colors.amberAccent,
                            child: Text('Adicionar', style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      });
  }

}


  
    


