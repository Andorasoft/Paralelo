class AuthUser {
  final String id;
  final String email;
  final String? pictureUrl;

  const AuthUser({required this.id, required this.email, this.pictureUrl});
}
