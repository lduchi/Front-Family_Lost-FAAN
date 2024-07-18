import 'dart:convert';

import 'package:familylost_faan/ServiciosApp/interceptors/store.dart';
import 'package:familylost_faan/ServiciosApp/notification/notifications.dart';
import 'package:familylost_faan/environment/environment.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

class WebSocketChnl {
  late String accessToken;
  late String username;
  late StompClient stompClient;

  WebSocketChnl._privateConstructor();

  static final WebSocketChnl _instance = WebSocketChnl._privateConstructor();

  static WebSocketChnl get instance => _instance;

  Future<void> initialize() async {
    accessToken = (await Store.getAccessToken())!;
    username = await Store.getUserName() as String;

    stompClient = StompClient(
      config: StompConfig(
        webSocketConnectHeaders: {'Authorization': 'Bearer $accessToken'},
        url: '$wsUrl/faan-websocket',
        onConnect: onConnect,
        beforeConnect: () async {
          print('waiting to connect...');
          await Future.delayed(const Duration(milliseconds: 200));
          print('connecting...');
        },
        onWebSocketError: (dynamic error) => print('WebSocket error: $error'),
        reconnectDelay: const Duration(milliseconds: 5000),
      ),
    );

    connect();
  }

  void onConnect(StompFrame frame) {
    print('Connected to the websocket to $username');
    stompClient.subscribe(
      destination: '/user/specific/notification',
      callback: (StompFrame frame) {
        if (frame.body != null) {
          print('Received new post notification, ${frame.body}');
          Map<String, dynamic> post = jsonDecode(frame.body!);
          createdPostNotification(post);
          // Handle the received post data as needed
        }
      },
    );
  }

  void connect() {
    stompClient.activate();
  }

  void disconnect() {
    stompClient.deactivate();
  }
}
