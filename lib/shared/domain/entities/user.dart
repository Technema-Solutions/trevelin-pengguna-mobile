class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String? avatar;
  final DateTime createdAt;
  final bool isVerified;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.avatar,
    required this.createdAt,
    this.isVerified = false,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      avatar: json['avatar'],
      createdAt: DateTime.parse(json['created_at']),
      isVerified: json['is_verified'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'avatar': avatar,
      'created_at': createdAt.toIso8601String(),
      'is_verified': isVerified,
    };
  }
}
