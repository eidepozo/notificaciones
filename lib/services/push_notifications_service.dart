//SHA1 = 41:36:3C:9F:E8:E4:58:4E:BF:C0:D1:22:25:D1:90:A5:E6:7B:32:16
import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../firebase_options.dart';

class PushNotificationService {

  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static StreamController<String> _messageStream = new StreamController.broadcast();
  static Stream<String> get messageStream => _messageStream.stream;

  static Future _backgroundHandler(RemoteMessage message) async{
    //print('onBackground Handler ${message.messageId}');
    print (message.data);
    _messageStream.add(message.notification?.title ?? 'No title');
  }
  static Future _onMessageHandler(RemoteMessage message) async{
    //print('onMessage Handler ${message.messageId}');
    print (message.data);
    _messageStream.add(message.notification?.title ?? 'No title');
  }
  static Future _onMessageOpenApp(RemoteMessage message) async{
    //print('onMessageOpenApp Handler ${message.messageId}');
    print (message.data);
    _messageStream.add(message.notification?.title ?? 'No title');
  }
  static Future initializeApp() async{
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    token = await FirebaseMessaging.instance.getToken();
    print('token: $token');

  // Handlers
    FirebaseMessaging.onBackgroundMessage( _backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessage.listen(_onMessageOpenApp);
  }
  static closeStreams(){
    _messageStream.close();
  }
}
