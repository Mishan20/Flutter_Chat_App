import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String uid;
  String message;
  DateTime time;
  String id;

  MessageModel({
    required this.uid,
    required this.message,
    required this.time,
    required this.id,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      uid: json['uid'],
      message: json['message'],
      time: (json['time'] as Timestamp).toDate(),
      id: json['id'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'message': message,
      'time': time,
      'id': id,
    };
  }
}
