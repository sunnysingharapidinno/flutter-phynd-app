enum UserRole {
  publisher,
  user,
}

enum UserType {
  publisher('PUBLISHER'),
  user('USER');

  final String value;

  const UserType(this.value);
}
