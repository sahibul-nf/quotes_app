class User {
  final String id;
  final String email;
  final String? name;
  final String? avatarUrl;
  final String? profession;

  String get username => name ?? email;

  User({
    required this.id,
    required this.email,
    this.name,
    this.avatarUrl,
    this.profession,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['user_id'],
      email: json['email'],
      name: json['name'],
      avatarUrl: json['avatar_url'],
      profession: json['profession'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': id,
      'email': email,
      'name': name,
      'avatar_url': avatarUrl,
      'profession': profession,
    };
  }
}
