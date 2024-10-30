class UserModel {
  String name;
  String image;
  String uid;
  String lastSeen;
  bool isOnline;
  String token;

  UserModel({
    required this.name,
    required this.image,
    required this.uid,
    required this.lastSeen,
    required this.isOnline,
    this.token = "",
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      image: json['image'],
      uid: json['uid'],
      lastSeen: json['lastSeen'],
      isOnline: json['isOnline'],
      token: json['token'] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'image': image,
        'uid': uid,
        'lastSeen': lastSeen,
        'isOnline': isOnline,
        'token': token,
      };
}
