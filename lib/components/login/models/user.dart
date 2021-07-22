class User {
  String? firstName;
  String? lastName;
  String? userName;
  String? password;
  String name() => "$firstName + $lastName";

  User(this.firstName, this.lastName, this.password, this.userName);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json["firstName"],
      json["lastName"],
      json["userName"],
      json["password"],
    );
  }
}
