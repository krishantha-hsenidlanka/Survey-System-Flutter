class User {
  final String username;
  final String email;
  final String password;
  final List<String> roles;

  User({required this.username, required this.email, required this.password, required this.roles});

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'roles': roles,
    };
  }
}