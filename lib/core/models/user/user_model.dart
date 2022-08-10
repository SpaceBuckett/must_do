class UserProfile {
  String? id;
  String? name;
  String? email;
  String? password;

  UserProfile({
    this.id,
    this.name,
    this.email,
    this.password,
  });

  UserProfile.fromJson(Map<String, dynamic> json, this.id) {
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['email'] = email;
    return data;
  }
}
