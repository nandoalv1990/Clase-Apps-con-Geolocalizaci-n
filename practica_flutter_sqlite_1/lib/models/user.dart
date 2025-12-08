class User {
  int? id;
  String username;
  String password;
  int roleId;

  User (
    {
      this.id,
      required this.username,
      required this.password,
      required this.roleId,
    }
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "username": username,
    "password": password,
    "roleId": roleId,
  };

  factory User.fromMap(Map<String, dynamic> map) => User(
    id: map["id"],
    username: map["username"], 
    password: map["password"],
    roleId: map["roleId"],
  );

}
