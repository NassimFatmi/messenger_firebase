import 'package:flutter/rendering.dart';

class UserData {
  final String name;
  final String uid;

  UserData({this.name, this.uid});
}

class Message {
  final String from; // Sender ID
  final String to; // recever ID
  final String message; // message content
  final DateTime time;

  Message({this.from, this.to, this.message, this.time});
}
