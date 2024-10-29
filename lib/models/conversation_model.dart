import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mi_chat_app/models/user_model.dart';

class ConversationModel {
  UserModel user;
  String lastMessage;
  DateTime lastTime;

  ConversationModel({
    required this.user,
    required this.lastMessage,
    required this.lastTime,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      lastMessage: json['lastMessage'],
      lastTime: (json['lastTime'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'lastMessage': lastMessage,
      'lastTime': lastTime,
    };
  }
}
