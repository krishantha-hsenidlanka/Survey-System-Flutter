class User {
  final String username;
  final String email;
  final String password;
  final List<String> roles;

  User({
    required this.username,
    required this.email,
    required this.password,
    required this.roles,
  });

  factory User.fromJson(Map<String, dynamic>? json) {
  if (json == null) {
    throw Exception('Failed to parse user data');
  }
  return User(
    username: json['username'] ?? '',
    email: json['email'] ?? '',
    password: json['password'] ?? '',
    roles: List<String>.from(json['roles'] ?? []),
  );
}


  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'roles': roles,
    };
  }
}