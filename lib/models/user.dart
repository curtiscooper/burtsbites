class User {
  final int? userID;
  final String userName;
  final String? firstName;
  final String? lastName;
  final String password;
  final String? avatar;

  User({
    this.userID,
    required this.userName,
    this.firstName,
    this.lastName,
    required this.password,
    this.avatar,
  });
}
