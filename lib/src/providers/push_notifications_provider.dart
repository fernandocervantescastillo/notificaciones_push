import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';


class PushNotificationProvider{
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final _mensajesStreamController = StreamController<String>.broadcast();

  Stream<String> get mensajes => _mensajesStreamController.stream;

  initNotifications(){
    _firebaseMessaging.requestNotificationPermissions();

    _firebaseMessaging.getToken().then((token) {
      print('==== Token ====');
      print(token);
      //eskpEBfnTJOyLaKFG3O93X:APA91bH-ngU1HLjM0jNoISjMfbvv51726eY76srvrdf1uWFBmvysm6uzmjF9jXZ8jHuOQka0sc07lXkaXKp7yPTieCoSpl3Q3DNsRRfBKtY4CO5KA2sBT5bhC4K2W0bsUpTWdGa6U4kc
    });

    _firebaseMessaging.configure(
      onMessage: ( info ){
        print('===== On Message =====');
        print(info);

        String argumento = 'no-data';
        if(Platform.isAndroid){
          argumento = info['data']['comida'] ?? 'no-data';
        }
        _mensajesStreamController.sink.add(argumento);

        return null;
      },
      onLaunch: (info){
        print('===== On Launch =====');
        print(info);
        return null;
      },
      onResume: (info){
        print('===== On Resume =====');
        print(info);

        String argumento = 'no-data';
        if(Platform.isAndroid){
          argumento = info['data']['comida'] ?? 'no-data';
        }
        _mensajesStreamController.sink.add(argumento);

        return null;
      },
    );
  }


  dispose(){
    _mensajesStreamController?.close();
  }



}