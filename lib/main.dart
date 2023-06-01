import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bein_ecommerce/app.dart';
import 'package:bein_ecommerce/bloc_observe.dart';
import 'package:bein_ecommerce/config/route/app_routes.dart';
import 'package:bein_ecommerce/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:bein_ecommerce/di.dart' as di;
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

import 'core/api/end_points.dart';





void onConnect(StompFrame frame) async{


   stompClient.subscribe(
      destination: '/channel/all',
      callback: (frame) async {

        dynamic result = json.decode(frame.body!);
        print('Socket Io respone ==========================> $result');
        NotificationService notificationService = NotificationService();
        await notificationService.init();
        await notificationService.requestIOSPermissions();
        await notificationService.showNotification(
          0,
          "BEIN",
          result['msg'],
          jsonEncode({
            "title": "",
          }),
        );
      }
  );
}

final stompClient = StompClient(
    config: StompConfig.SockJS(
  url: EndPoints.socketURL,
  onConnect: onConnect,
  beforeConnect: () async {
    print('waiting to connect...');
    await Future.delayed(const Duration(milliseconds: 200));
    print('connecting...');
  },
  onWebSocketError: (dynamic error) => print(error.toString()),
));

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  stompClient.activate();


  await di.init();
  Bloc.observer = AppBlocObserver();

  runApp(const BeInApp());
}
