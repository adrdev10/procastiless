class AccountUser {
  String? name;
  String? email;
  String? avatarUrl;
  String? uuid;
  int? exp;
  AccountUser(this.name, this.email, this.avatarUrl, this.uuid, this.exp);

  factory AccountUser.fromJson(Map<String, dynamic> json) {
    return AccountUser(json["name"], json["email"], json["avatarUrl"],
        json["uuid"], json["exp"]);
  }
}
