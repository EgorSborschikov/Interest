class User {
  final String idUser;
  final String nickname;
  final String profilePhotoUrl;
  final List<String> interests;
  final List<String> motivations;

  User({
    required this.idUser,
    required this.nickname,
    required this.profilePhotoUrl,
    required this.interests,
    required this.motivations,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      idUser: json['IDUser'],
      nickname: json['nickname'],
      profilePhotoUrl: json['profilePhotoUrl'],
      interests: List<String>.from(json['interests']),
      motivations: List<String>.from(json['motivations']),
    );
  }
}