class User {
  String name;
  String username;
  String email;
  String avatar;

  User({this.name, this.email, this.avatar});

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        username = json['username'],
        email = json['email'],
        avatar = json['avatar'];
}