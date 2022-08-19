import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:udp/udp.dart';

class ApiManager {
  String ip = "192.168.1.1";
  int port = 42069;
  String? result = null;

  ApiManager() {
    updateSettings();
  }
  void updateSettings() async {
    final pref = await SharedPreferences.getInstance();
    String? tip = pref.getString('ip');
    int? tport = pref.getInt('port');
    if (tip != null) ip = tip;
    if (tport != null) port = tport;
  }

  Future<String?> sendRequest(String text) async {
    List<int> message = utf8.encode(text);
    Endpoint endpoint = Endpoint.unicast(InternetAddress(ip), port: Port(port));

    UDP socket = await UDP.bind(Endpoint.any());
    await socket.send(message, endpoint);
    socket.asStream().listen((datagram) {
      if (datagram != null) {
        var str = String.fromCharCodes(datagram.data);
        result = str;
      }
    });
    _closeSocket(socket); //Close socket after 0.5s
    return result;
  }

  Future<String?> getUpdates() async {
    Map message = {
      'request': 'get',
    };
    return sendRequest(json.encode(message));
  }

  _closeSocket(UDP socket) async {
    await Future.delayed(const Duration(milliseconds: 500));
    socket.close();
  }
}
