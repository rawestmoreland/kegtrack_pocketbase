class User {
  int exp;
  String id;
  String type;

  User(this.exp, this.id, this.type);

  User.fromJson(Map<String, dynamic> json)
      : exp = json['exp'],
        id = json['id'],
        type = json['type'];

  Map<String, dynamic> toJson() => {'exp': exp, 'id': id, 'type': type};
}
