import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lps_ufs_tcc/models/notificacoes.dart';

class ConfigNotification {
  int id; // id da notificação
  String titulo; // titulo da notificação
  String body;   // conteudo apresentado
  String payload; // rota ao clicar na notificação

ConfigNotification({
  this.id,
  this.titulo,
  this.body,
  this.payload,
});


}

class NotificationService{
  FlutterLocalNotificationsPlugin localNotificationsPlugin;
  AndroidNotificationDetails androidDetails;

  NotificationService(){
    localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    configurar_notificacoes();
  }

  configurar_notificacoes() async{
    // timezone notificações por horarios
    await inicializar_notificacoes();
  }

  inicializar_notificacoes() async{
    const androidConfig = AndroidInitializationSettings('@mipmap/ic_launcher');
    await localNotificationsPlugin.initialize(
      const InitializationSettings(
        android: androidConfig,

      ),
      onSelectNotification: selecionar_Notificacao, 
    );
  }

  selecionar_Notificacao(String payload){
    if( payload != null && payload.isNotEmpty){
        BuildContext context;
        Navigator.push(context,MaterialPageRoute(builder: (context) => HomeNotify()));
    }

  }

  showNotifications(ConfigNotification c){
    androidDetails = const AndroidNotificationDetails(
       'user_uid', 
       'confirmacao do agendamento',
       'esta notificação é para notificar a confirmação do agendamento',
       importance: Importance.max,
       priority: Priority.max);


       // apresentar notificação
       localNotificationsPlugin.show(c.id, 
                                     c.titulo, 
                                     c.body, 
                                     NotificationDetails(
                                       android: androidDetails,
                                     ),
                                     payload: c.payload,
                                     );
  }


  checar_notificacoes() async{
    final details = await localNotificationsPlugin.getNotificationAppLaunchDetails();
    if(details != null && details.didNotificationLaunchApp){
      selecionar_Notificacao(details.payload);
    }

  }

  


  
}