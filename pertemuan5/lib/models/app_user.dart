class AppUser {
  final int? id;
  final String name;
  final String email;

  const AppUser({this.id, required this.name, required this.email});

  factory AppUser.fromMap(Map<String, Object?> map) {
    return AppUser(
      id: map['id'] as int?,
      name: map['name'] as String,
      email: map['email'] as String,
    );
  }
}
